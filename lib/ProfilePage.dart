import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                      userData['profileImage'] ?? 'assets/profile/default.png',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    userData['username'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Correo electrónico: ${user.email}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'QuizPoints: ${userData['quizPoints']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Preguntas Acertadas Totales: ${userData['preguntasAcertadas']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Mostrar diálogo para seleccionar avatar
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Elige un avatar'),
                            content: SingleChildScrollView(
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  buildAvatarOption('assets/profile/default.png'),
                                  buildAvatarOption('assets/profile/woman1.png'),
                                  buildAvatarOption('assets/profile/man1.png'),
                                  buildAvatarOption('assets/profile/woman2.png'),
                                  buildAvatarOption('assets/profile/man2.png'),
                                  buildAvatarOption('assets/profile/cat.png'),
                                  buildAvatarOption('assets/profile/panda.png'),
                                  buildAvatarOption('assets/profile/rabbit.png'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); 
                                },
                                child: Text('Cancelar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Cambiar avatar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAvatarOption(String imagePath) {
    return GestureDetector(
      onTap: () {
        // Actualizar la ruta del avatar 
        FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).update({
          'profileImage': imagePath,
        });
        Navigator.of(context).pop(); 
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          width: 60,
          height: 60,
        ),
      ),
    );
  }
}
