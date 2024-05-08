import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/CategoryCard.dart';
import 'package:quiz_app/LeaderboardPage.dart';
import 'package:quiz_app/LoginPage.dart';
import 'package:quiz_app/ProfilePage.dart';
import 'package:quiz_app/QuizPage.dart';

class QuizHomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // El usuario debe hacer una elección para cerrar el diálogo
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
                Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
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
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.indigo, // Cambiar el color del AppBar a uno más claro
        actions: [
          IconButton( // Botón para navegar a la página de Leaderboard
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
                    image: 'assets/math_icon.png', // Restaurar la ruta de la imagen
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
                    image: 'assets/biology_icon.png', // Restaurar la ruta de la imagen
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
                    image: 'assets/chemistry_icon.png', // Restaurar la ruta de la imagen
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
                    image: 'assets/technology_icon.png', // Restaurar la ruta de la imagen
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
                    title: 'Palabras y Lenguaje',
                    image: 'assets/language_icon.png', // Restaurar la ruta de la imagen
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
                    image: 'assets/sports_icon.png', // Restaurar la ruta de la imagen
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: 'Deportes'),
                        ),
                      );
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
