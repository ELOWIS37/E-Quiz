import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app/QuestionsList.dart';
import 'package:quiz_app/QuizHomePage.dart';
import 'question.dart';

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
  bool answered = false;
  bool quizCompleted = false;
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColorAnimation;
  late Stopwatch _stopwatch;
  int? _selectedOptionIndex;

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

    questions.shuffle();
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex + 1 < questions.length) {
        currentQuestionIndex++;
        answered = false;
        _selectedOptionIndex = null;
        _backgroundColorAnimation = ColorTween(
          begin: Colors.transparent,
          end: Colors.green,
        ).animate(_animationController);
      } else {
        quizCompleted = true;
        _stopwatch.stop();
      }
    });
  }

  void _onOptionSelected(int index) {
    if (!answered) {
      setState(() {
        answered = true;
        _selectedOptionIndex = index;
        if (index == questions[currentQuestionIndex].correctOptionIndex) {
          correctAnswers++;
          _backgroundColorAnimation = ColorTween(
            begin: Colors.transparent,
          ).animate(_animationController);
        } else {
          lives--;
          if (lives <= 0) {
            quizCompleted = true;
            _stopwatch.stop();
          }
          _backgroundColorAnimation = ColorTween(
            begin: Colors.transparent,
          ).animate(_animationController);
          _animationController.forward(from: 0.0); // Iniciar la animación al equivocarse
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.category,
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            SizedBox(width: 10),
            Image.asset(
              'assets/health.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 5),
            Text(
              'x $lives',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: quizCompleted
          ? _buildQuizResultScreen()
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.green],
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
                    child: Text(
                      'Pregunta ${currentQuestionIndex + 1}/${questions.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
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
}

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(int) onOptionSelected;
  final int? selectedOptionIndex;
  final bool disabled;
  final Animation<Color?> backgroundColorAnimation;
  final AnimationController animationController;

  QuestionCard({
    required this.question,
    required this.onOptionSelected,
    required this.selectedOptionIndex,
    required this.disabled,
    required this.backgroundColorAnimation,
    required this.animationController,
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: InkWell(
                    onTap: () {
                      if (!disabled) {
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
                                color: isSelected ? Colors.blue : Colors.black,
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
