import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/CategoryCard.dart';
import 'package:quiz_app/LeaderboardPage.dart';
import 'package:quiz_app/LoginPage.dart';
import 'package:quiz_app/ProfilePage.dart';
import 'package:quiz_app/QuizPage.dart';

class QuizHomePage extends StatefulWidget {
  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _canPlayChallenge = true;
  int quizCoins = 0; // Variable para almacenar los quizCoins

  @override
  void initState() {
    super.initState();
    _checkDailyChallengeStatus(); // Verificar si se puede jugar el Desafío Diario al cargar la página
    _fetchQuizCoins(); // Obtener los quizCoins del usuario al cargar la página
  }

  Future<void> _fetchQuizCoins() async {
    var user = _auth.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          quizCoins = userDoc.data()?['quizCoins'] ?? 0;
        });
      }
    }
  }

  Future<void> _checkDailyChallengeStatus() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        var userData = userDoc.data();
        if (userData != null && userData['lastDailyChallengeDate'] != null) {
          // Obtener la data de l'ultim challenge fet
          DateTime lastDate = (userData['lastDailyChallengeDate'] as Timestamp).toDate();
          // Verificar si la data es la actual
          if (DateTime.now().year == lastDate.year &&
              DateTime.now().month == lastDate.month &&
              DateTime.now().day == lastDate.day) {
            // Si l'usuari ha realitzat el challenge avui, es denega
            setState(() {
              _canPlayChallenge = false;
            });
          }
        }
      }
    }
  }

  Future<void> _updateLastDailyChallengeDate() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'lastDailyChallengeDate': DateTime.now(),
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cerrar Sesión'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de que quieres cerrar sesión?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cerrar Sesión'),
              onPressed: () async {
                // Cerrar sesión y navegar a la página de inicio de sesión
                await _auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Quiz300',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              int quizCoins = snapshot.data?.data()?['quizCoins'] ?? 0;
              return Row(
                children: [
                  Image.asset(
                    '../assets/quizCoin.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$quizCoins',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.leaderboard, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeaderboardPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Categorías de aprendizaje',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding: EdgeInsets.all(20),
                children: [
                  CategoryCard(
                    title: 'Matemáticas',
                    image: 'assets/math_icon.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Matemáticas'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Biología',
                    image: 'assets/biology_icon.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Biología'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Química',
                    image: 'assets/chemistry_icon.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Química'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Tecnología',
                    image: 'assets/technology_icon.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Tecnología'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Lenguaje',
                    image: 'assets/language_icon.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Palabras y Lenguaje'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Deportes',
                    image: 'assets/sports_icon.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Deportes'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Desafío Rápido',
                    image: 'assets/countDown.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Desafío Rápido'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Desafío Diario',
                    image: 'assets/challenge_icon.png',
                    onTap: () {
                      if (_canPlayChallenge) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              _updateLastDailyChallengeDate();
                              return QuizPage(category: 'Desafío Diario');
                            },
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('¡Ya jugaste el Desafío Diario hoy!'),
                            content: Text('Vuelve mañana para jugar de nuevo.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
