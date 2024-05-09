import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Tabla de Clasificación',
        style: TextStyle(
          color: Colors.white, 
        ),
      ),
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('quizPoints', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error al cargar los datos'));
          }
          final users = snapshot.data!.docs;
          final currentUser = FirebaseAuth.instance.currentUser;
          final currentUserId = currentUser != null ? currentUser.uid : '';
          QueryDocumentSnapshot<Object?>? currentUserData;
          try {
            currentUserData = users.firstWhere((user) => user.id == currentUserId);
          } catch (e) {
            print('Usuario actual no encontrado en la lista de usuarios: $e');
          }

          final currentLevel =
              currentUserData != null ? _getLevel(currentUserData.get('quizPoints')) : 1;
          final currentPoints = currentUserData != null ? currentUserData.get('quizPoints') : 0;
          final nextLevelPoints = _getPointsRequired(currentLevel + 1);
          final pointsRequiredForNextLevel = nextLevelPoints - currentPoints;

          return ListView(
            children: [
              SizedBox(height: 10),
              _buildLevelTable(currentLevel, currentPoints, pointsRequiredForNextLevel.toInt()),
              SizedBox(height: 20),
              _buildLeaderboard(users, currentUserId),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLevelTable(int currentLevel, int currentPoints, int pointsRequiredForNextLevel) {
    final nextLevelPoints = _getPointsRequired(currentLevel + 1); // Calcular los puntos necesarios para el próximo nivel
    final pointsRequiredForNextLevel = nextLevelPoints - currentPoints;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nivel actual: $currentLevel'),
                Text('QuizPoints: $currentPoints'),
              ],
            ),
          ),
          Divider(),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(16, (index) {
              final level = index + 1;
              final pointsRequired = _getPointsRequired(level);
              final isLevelReached = currentLevel >= level;
              return InkWell(
                onTap: () {
                  print('Nivel $level pulsado');
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isLevelReached ? Colors.indigo : Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Nivel $level',
                            style: TextStyle(
                              color: isLevelReached ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '$pointsRequired',
                            style: TextStyle(
                              color: isLevelReached ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.star,
                          color: isLevelReached ? Colors.amber : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 10),
          // Barra de progreso de nivel
          LinearProgressIndicator(
            value: ((currentPoints - _getPointsRequired(currentLevel)) /
                    (nextLevelPoints - _getPointsRequired(currentLevel))).clamp(0.0, 1.0),
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
          ),
          SizedBox(height: 5),
          // Texto que muestra los puntos necesarios para el próximo nivel
          Text(
            'Puntos necesarios para el próximo nivel: $pointsRequiredForNextLevel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }


  Widget _buildLeaderboard(List<QueryDocumentSnapshot> users, String currentUserId) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Mejores Jugadores',
              style: TextStyle(color: Colors.indigo),
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index];
              final username = userData.get('username');
              final quizPoints = userData.get('quizPoints');
              final userLevel = _getLevel(quizPoints);
              final isCurrentUser = userData.id == currentUserId;
              final profileImage = userData.get('profileImage') ?? 'assets/profile/default.png'; // Obtener la URL de la imagen de perfil
              return InkWell(
                onTap: () {
                  print('$username pulsado');
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(profileImage),
                  ),
                  title: Row(
                    children: [
                      Text(
                        '${index + 1}. ',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$username',
                            style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'Nivel $userLevel ' '- QuizPoints: $quizPoints',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  hoverColor: Colors.lightBlue.withOpacity(0.1),
                  tileColor: isCurrentUser ? Colors.amber.withOpacity(0.3) : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  int _getPointsRequired(int level) {
    switch (level) {
      case 1:
        return 0;
      case 2:
        return 2000;
      case 3:
        return 5000;
      case 4:
        return 12000;
      case 5:
        return 20000;
      case 6:
        return 40000;
      case 7:
        return 68000;
      case 8:
        return 105000;
      case 9:
        return 145000;
      case 10:
        return 190000;
      case 11:
        return 250000;
      case 12:
        return 350000;
      case 13:
        return 500000;
      case 14:
        return 800000;
      case 15:
        return 1400000;
      case 16:
        return 3000000;
      default:
        return 0;
    }
  }

  int _getLevel(int quizPoints) {
    for (int i = 16; i > 0; i--) {
      if (quizPoints >= _getPointsRequired(i)) {
        return i;
      }
    }
    return 1;
  }
}
