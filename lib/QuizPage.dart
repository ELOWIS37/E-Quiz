import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/QuestionsList.dart';
import 'package:quiz_app/QuizHomePage.dart';
import 'question.dart';
import 'package:quiz_app/LeaderboardPage.dart';

class QuizPage extends StatefulWidget {
  final String category;

  QuizPage({required this.category});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int lives = 3;
  int quizPoints = 0;
  double totalPoints = 0;
  int numeroMin = 400;
  int numeroMax = 600;
  bool answered = false;
  bool quizCompleted = false;
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColorAnimation;
  late Stopwatch _stopwatch;
  int? _selectedOptionIndex;
  int _previousScore = 0;
  bool comodinUsado = false;
  List<int> opcionesBloqueadas = [];
  Timer? _timer;
  int _remainingTimeInSeconds = 60; 


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _backgroundColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.green,
    ).animate(_animationController);
    _stopwatch = Stopwatch();
    _stopwatch.start();

    // Iniciar la animación al equivocarse
    _animationController.addListener(() {
      setState(() {});
    });

    // Iniciar el temporizador solo para la categoría "Desafío Rápido"
    if (widget.category == 'Desafío Rápido') {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.category == 'Desafío Diario') {
      questions = _getChallengeQuestions();
      lives = 1; // La categoria de Desafío solo se tiene 1 vida
      numeroMin = 1000;
      numeroMax = 1400;
    } else if(widget.category == 'Desafío Rápido'){
      questions = _getChallengeQuestions();
      numeroMin = 400;
      numeroMax = 800;
    }else {
      switch (widget.category) {
        case 'Matemáticas':
          questions = MyAppState.of(context)!.mathQuestions;
          break;
        case 'Biología':
          questions = MyAppState.of(context)!.biologyQuestions;
          break;
        case 'Química':
          questions = MyAppState.of(context)!.chemistryQuestions;
          break;
        case 'Tecnología':
          questions = MyAppState.of(context)!.technologyQuestions;
          break;
        case 'Palabras y Lenguaje':
          questions = MyAppState.of(context)!.languageQuestions;
          break;
        case 'Deportes':
          questions = MyAppState.of(context)!.sportsQuestions;
          break;
      }
    }
    questions.shuffle();
  }

  List<Question> _getChallengeQuestions() {
    List<Question> allQuestions = [];
    allQuestions.addAll(MyAppState.of(context)!.mathQuestions);
    allQuestions.addAll(MyAppState.of(context)!.biologyQuestions);
    allQuestions.addAll(MyAppState.of(context)!.chemistryQuestions);
    allQuestions.addAll(MyAppState.of(context)!.technologyQuestions);
    allQuestions.addAll(MyAppState.of(context)!.languageQuestions);
    allQuestions.addAll(MyAppState.of(context)!.sportsQuestions);
    allQuestions.shuffle();
    return allQuestions;
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex + 1 < questions.length) {
        currentQuestionIndex++;
        answered = false;
        comodinUsado = false;
        opcionesBloqueadas.clear();
        _selectedOptionIndex = null;
        _backgroundColorAnimation = ColorTween(
          begin: Colors.transparent,
          end: Colors.green,
        ).animate(_animationController);
      } else {
        quizCompleted = true;
        _stopwatch.stop();
        // Actualizar la puntuación en Firebase
        _updateScoreInFirebase();
      }
    });
  }


  void _onOptionSelected(int index) {
    if (!answered && !opcionesBloqueadas.contains(index)) {
      setState(() {
        answered = true;
        _selectedOptionIndex = index;
        if (index == questions[currentQuestionIndex].correctOptionIndex) {
          correctAnswers++;
          _updateQuizCoinsInFirebase();
          var randomPoints = Random().nextInt(numeroMax - numeroMin + 1) + numeroMin;
          _updateScore(quizPoints + randomPoints);
          _backgroundColorAnimation = ColorTween(
            begin: Colors.transparent,
          ).animate(_animationController);
        } else {
          lives--;
          if (lives <= 0) {
            quizCompleted = true;
            _stopwatch.stop();
            // Actualizar la puntuación en Firebase
            _updateScoreInFirebase();
          }
          _backgroundColorAnimation = ColorTween(
            begin: Colors.transparent,
          ).animate(_animationController);
          _animationController.forward(from: 0.0);
        }
      });
    }
  }


  String _getQuizResult() {
    return '$correctAnswers/${questions.length}';
  }

  String _getElapsedTime() {
    final elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
    final seconds = (elapsedMilliseconds / 1000).floor();
    final minutes = (seconds / 60).floor();
    return '$minutes:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  void _updateScore(int newScore) {
    setState(() {
      quizPoints = newScore;
      _previousScore = newScore;
    });
  }

  void _updateScoreInFirebase() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Obtener el documento del usuario
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        // Obtener los datos actuales del usuario
        Map<String, dynamic> userData = userDoc.data()!;
        // Obtener datos del firebase
        int currentScore = userData['quizPoints'] ?? 0;
        int currentCorrectAnswers = userData['preguntasAcertadas'] ?? 0;
        // Sumar la puntuación actual i correct answers
        int updatedScore = currentScore + quizPoints;
        int updatedCorrectAnswers = currentCorrectAnswers + correctAnswers;
        // Verificar el nivel del jugador
        int currentLevel = getLevel(updatedScore);

        // Actualizar los datos en Firebase
        Map<String, dynamic> updatedData = {
          ...userData, // Mantener los datos existentes
          'quizPoints': updatedScore,
          'preguntasAcertadas': updatedCorrectAnswers,
        };

        // Solo actualizar trofeosOro si el nivel es 16
        if (currentLevel == 16) {
          int currentTrophies = userData['trofeosOro'] ?? 0;
          updatedData['trofeosOro'] = currentTrophies + correctAnswers;
        }

        // Verificar si se completa el desafío diario sin perder vidas
        if (widget.category == 'Desafío Diario' && lives == 1) {
          // Se ha completado el desafío diario sin perder vidas
          int currentDiamondTrophies = userData['trofeosDiamante'] ?? 0;
          updatedData['trofeosDiamante'] = currentDiamondTrophies + 1;
        }

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(updatedData);
      }
    }
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_remainingTimeInSeconds-1 > 0) {
          _remainingTimeInSeconds--;
        } else {
          timer.cancel();
          _onTimerEnd();
        }
      });
    });
  }

  String _getRemainingTime() {
    const duration = Duration(minutes: 1); // Duración total del cuestionario
    final elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
    final remainingMilliseconds = duration.inMilliseconds - elapsedMilliseconds;

    // Convertir el tiempo restante a minutos y segundos
    final remainingSeconds = (remainingMilliseconds / 1000).floor();
    final minutes = (remainingSeconds / 60).floor();
    final seconds = remainingSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }


  void _onTimerEnd() {
    setState(() {
      quizCompleted = true;
    });
    _stopwatch.stop();
    _updateScoreInFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: !quizCompleted,
      ),
      body: quizCompleted
          ? _buildQuizResultScreen()
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: widget.category == 'Desafío Rápido',
                    child: Text(
                      'Tiempo restante: ${_getRemainingTime()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.indigo],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Pregunta ${currentQuestionIndex + 1}/${questions.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Row(
                          children: List.generate(
                            lives,
                            (index) => Image.asset(
                              'assets/heart.png',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: _previousScore != quizPoints
                              ? _buildAnimatedScore(quizPoints)
                              : _buildScore(quizPoints),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Column(
                        key: ValueKey<int>(currentQuestionIndex),
                        children: [
                          QuestionCard(
                            question: questions[currentQuestionIndex],
                            onOptionSelected: _onOptionSelected,
                            selectedOptionIndex: _selectedOptionIndex,
                            disabled: answered,
                            backgroundColorAnimation: _backgroundColorAnimation,
                            animationController: _animationController,
                            opcionesBloqueadas: opcionesBloqueadas,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Visibility(
                                visible: widget.category != 'Desafío Rápido', // Oculta el botón para todo excepto "Desafío Rápido"
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.indigo,
                                    elevation: 5,
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: _usarComodin,
                                  child: Text(
                                    '50/50',
                                    style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.category != 'Desafío Rápido', // Oculta el botón para todo excepto "Desafío Rápido"
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    elevation: 5,
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: _usarComodinVida,
                                  child: Text(
                                    '+1 Vida',
                                    style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),
                          if (answered)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.indigo,
                                elevation: 5,
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _nextQuestion,
                              child: Text(
                                'Siguiente',
                                style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }



  Widget _buildQuizResultScreen() {
    // Calcular el bono de puntos basado en el número de vidas restantes
    int bonusPoints = 0;

    if (lives == 1) {
      // Si falta 1 corazón, agregar un 10% de los quizpoints como bono
      bonusPoints = (quizPoints * 0.1).toInt();
    } else if (lives == 2) {
      // Si faltan 2 corazones, agregar un 20% de los quizpoints como bono
      bonusPoints = (quizPoints * 0.2).toInt();
    } else if (lives == 3) {
      // Si faltan 3 corazones, agregar un 30% de los quizpoints como bono
      bonusPoints = (quizPoints * 0.3).toInt();
    }

    // Calcular los puntos totales sumando los puntos obtenidos y el bono por las vidas
    int totalPoints = quizPoints + bonusPoints;

  void _updateBonusQuizPoints() async {
    // Pausar por 2 segundos
    await Future.delayed(Duration(seconds: 2));

    // Obtén el usuario actualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Obtener el valor actual de quizPoints
      DocumentSnapshot userSnapshot = await userDoc.get();
      int currentQuizPoints = userSnapshot.get('quizPoints');

      // Calcular el nuevo valor de quizPoints sumando el bono
      int updatedQuizPoints = currentQuizPoints + bonusPoints;

      // Actualizar el valor de quizPoints en Firestore
      await userDoc.update({
        'quizPoints': updatedQuizPoints,
      });
    } else {
      // Manejar el caso cuando no hay un usuario autenticado
      print("No user is currently signed in.");
    }
  }

    // Llama a la función para actualizar los puntos cuando se construya la pantalla
    _updateBonusQuizPoints();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Resultado del Quiz:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 20),
          Text(
            'Preguntas acertadas: ${_getQuizResult()}',
            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 10),
          Text(
            'Tiempo transcurrido: ${_getElapsedTime()}',
            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 20),
          if (lives <= 0)
            Text(
              'Te has quedado sin vidas',
              style: TextStyle(fontSize: 20, color: Colors.red, fontFamily: 'Montserrat'),
            ),
          Text(
            'QuizPoints por Preguntas: +$quizPoints',
            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
          ),
          Text(
            'Bono por Vidas: +$bonusPoints',
            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 20),
          Text(
            'QuizPoints Totales: $totalPoints',
            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo,
              elevation: 5,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => QuizHomePage()),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              'Volver al Menú',
              style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScore(int score) {
    return Text(
      '${quizCompleted ? 'QuizPoints' : 'Q.P'}: $score',
      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
    );
  }

  void _updateQuizCoinsInFirebase() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data()!;
        int currentQuizCoins = userData['quizCoins'] ?? 0;
        int updatedQuizCoins = currentQuizCoins + 2;

        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'quizCoins': updatedQuizCoins,
        });
      }
    }
  }


  Widget _buildAnimatedScore(int newScore) {
    final int addedPoints = newScore - _previousScore;
    final String sign = addedPoints >= 0 ? '+' : '-';
    final String pointsText = '$sign ${addedPoints.abs()}';

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Column(
        key: ValueKey<int>(newScore),
        children: [
          Text(
            'QuizPoints: $_previousScore',
            key: ValueKey<int>(_previousScore),
            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 10),
          Text(
            pointsText,
            key: ValueKey<String>(pointsText),
            style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
          ),
        ],
      ),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(animation),
          child: child,
        );
      },
    );
  }

  void _usarComodin() async {
    if (comodinUsado || answered || questions.isEmpty) return;

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        int quizCoins = userDoc.data()?['quizCoins'] ?? 0;
        if (quizCoins >= 30) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Confirmar Uso del Comodín",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "¿Estás seguro de usar el comodín por 30 quizCoins?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _restarQuizCoins(user.uid, 30); // Corregido
                      _confirmarUsoComodin();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.indigoAccent,
                    ),
                    child: Text(
                      'Confirmar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          _mostrarMensaje("No tienes suficientes quizCoins para usar el comodín.");
        }
      }
    }
  }

  void _usarComodinVida() async {
    if (comodinUsado || answered || questions.isEmpty) return;

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        int quizCoins = userDoc.data()?['quizCoins'] ?? 0;
        int maxLives = 3; // Establecer el número máximo de vidas

        if (quizCoins >= 70 && lives < maxLives) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Confirmar Compra de Vida Extra",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "¿Estás seguro de comprar una vida extra por 70 quizCoins?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _restarQuizCoins(user.uid, 70); // Corregido
                      comprarVidaExtra();
                      comodinUsado = true;
                      _incrementarComodinesUsados();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      'Confirmar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          if (lives == 3){
            _mostrarMensaje("No puedes tener mas de 3 vidas al mismo tiempo.");
          } else {
            _mostrarMensaje("No tienes suficientes quizCoins para usar el comodín.");
          }
        }
      }
    }
  }



  void comprarVidaExtra() {
    setState(() {
      lives++;
    });
  }



  void _confirmarUsoComodin() {
    setState(() {
      comodinUsado = true;
      List<int> incorrectOptions = [];
      for (int i = 0; i < questions[currentQuestionIndex].options.length; i++) {
        if (i != questions[currentQuestionIndex].correctOptionIndex) {
          incorrectOptions.add(i);
        }
      }
      incorrectOptions.shuffle();
      opcionesBloqueadas = incorrectOptions.sublist(0, 2);

      _incrementarComodinesUsados();
    });
  }

  void _mostrarMensaje(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _restarQuizCoins(String userId, int amount) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'quizCoins': FieldValue.increment(-amount),
    });
  }




  void _incrementarComodinesUsados() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        int currentComodinesUsados = userDoc['comodinesUsados'] ?? 0;
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'comodinesUsados': currentComodinesUsados + 1,
        });
      }
    }
  }

}

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(int) onOptionSelected;
  final int? selectedOptionIndex;
  final bool disabled;
  final Animation<Color?> backgroundColorAnimation;
  final AnimationController animationController;
  final List<int> opcionesBloqueadas; // Nueva propiedad

  QuestionCard({
    required this.question,
    required this.onOptionSelected,
    required this.selectedOptionIndex,
    required this.disabled,
    required this.backgroundColorAnimation,
    required this.animationController,
    required this.opcionesBloqueadas, // Nueva propiedad
  });


  @override
Widget build(BuildContext context) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final optionLetter = String.fromCharCode(65 + index);
              final isSelected = selectedOptionIndex == index;
              final isCorrect = question.correctOptionIndex == index;
              final isBlocked = opcionesBloqueadas.contains(index); // Verificar si la opción está bloqueada

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  onTap: () {
                    if (!disabled && !isBlocked) {
                      onOptionSelected(index);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? backgroundColorAnimation.value : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          optionLetter,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.blue : Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              color: isBlocked ? Colors.grey : (isSelected ? Colors.blue : Colors.black),
                              decoration: isBlocked ? TextDecoration.lineThrough : TextDecoration.none,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        if (isSelected)
                          AnimatedBuilder(
                            animation: animationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(sin(animationController.value * pi * 5) * 10, 0),
                                child: child,
                              );
                            },
                            child: Icon(
                              isCorrect ? Icons.check : Icons.close,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

}
