import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/LeaderboardPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
                Navigator.of(context).pop();
            },
          ),
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
          int currentQuizPoints = userData['quizPoints'] ?? 0;
          double currentLevel = getLevel(currentQuizPoints);

          List<int> rewardLevels = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
          Map<int, int> rewards = {
            2: 10,
            3: 20,
            4: 20,
            5: 50,
            6: 50,
            7: 50,
            8: 100,
            9: 150,
            10: 200,
            11: 200,
            12: 250,
            13: 300,
            14: 400,
            15: 500,
            16: 500,
          };

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
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
                    Text(
                      '${user.email}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
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
                                    buildAvatarOption('assets/profile/leon.png'),
                                    buildAvatarOption('assets/profile/monstruo.png'),
                                    buildAvatarOption('assets/profile/robot.png'),
                                    buildAvatarOption('assets/profile/extraterrestre.png'),
                                    buildAvatarOption('assets/profile/hacker.png'),
                                    buildAvatarOption('assets/profile/superheroe.png'),
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
                    SizedBox(height: 20),
                    _buildStatsSection(userData, currentLevel),
                    SizedBox(height: 20),
                    _buildTrophySection(userData),
                    SizedBox(height: 20),
                    _buildRewardsSection(currentLevel, userData, rewardLevels, rewards),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsSection(Map<String, dynamic> userData, double currentLevel) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 650),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Estadísticas de Jugador',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 5),
                Text(
                  'Estrellas de Nivel',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  currentLevel.toInt().toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('../assets/quizPoints.png', width: 24, height: 24),
                SizedBox(width: 5),
                Text(
                  'QuizPoints',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  userData['quizPoints'].toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('../assets/quizCoin.png', width: 24, height: 24),
                SizedBox(width: 5),
                Text(
                  'QuizCoins',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  userData['quizCoins'].toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('../assets/preguntaAcertada.png', width: 24, height: 24),
                SizedBox(width: 5),
                Text(
                  'Preguntas Acertadas',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  userData['preguntasAcertadas'].toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('../assets/comodin.png', width: 24, height: 24),
                SizedBox(width: 5),
                Text(
                  'Comodines Utilizados',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  userData['comodinesUsados'].toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTrophySection(Map<String, dynamic> userData) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 650),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Estadísticas de Trofeos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            Row(
              children: [
                Image.asset('informacion.png', width: 12, height: 12),
                SizedBox(width: 5),
                Text(
                  'Trofeos a partir de N.16 por cada respuesta acertada',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset('assets/trofeoOro.png', width: 24, height: 24),
                SizedBox(width: 5),
                Text(
                  'Trofeos',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  userData['trofeosOro'].toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/trofeoDiamante.png', width: 24, height: 24),
                SizedBox(width: 5),
                Text(
                  'Trofeos Diamante',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  userData['trofeosDiamante'].toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsSection(double currentLevel, Map<String, dynamic> userData, List<int> rewardLevels, Map<int, int> rewards) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 650),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Recompensas de Nivel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: rewardLevels.length,
                    itemBuilder: (context, index) {
                      int level = rewardLevels[index];
                      bool unlocked = currentLevel >= level;
                      bool alreadyClaimed = userData['rewards'] != null && userData['rewards'][level.toString()] == true;

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nivel $level',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!unlocked)
                                  Icon(Icons.lock, color: Colors.grey.withOpacity(0.5)),
                                SizedBox(width: 5),
                                Text(
                                  '    ${rewards[level]}',
                                  style: TextStyle(fontSize: 16, color: unlocked ? Colors.black : Colors.grey.withOpacity(0.5)),
                                ),
                                SizedBox(width: 2),
                                if (alreadyClaimed)
                                  SizedBox(width: alreadyClaimed ? 5 : 0),
                                  Image.asset('assets/quizCoin.png', width: 24, height: 24),
                                  SizedBox(width: 20),
                              ],
                            ),
                            SizedBox(height: 20),
                            if (unlocked && !alreadyClaimed)
                              ElevatedButton(
                                onPressed: () {
                                  _claimReward(level, rewards[level]!);
                                },
                                child: Text('Reclamar Recompensa'),
                              ),
                            if (alreadyClaimed)
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.3), // Fondo sutil
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/preguntaAcertada.png', width: 24, height: 24), // Imagen de marca de verificación
                                    SizedBox(width: 5),
                                    Text(
                                      'Reclamado',
                                      style: TextStyle(fontSize: 16, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        _pageController.previousPage(duration: Duration(milliseconds: 1000), curve: Curves.ease);
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        _pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.ease);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
// Función para reclamar la recompensa
void _claimReward(int level, int rewardAmount) async {
  DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid);

  try {
    // Obtener el documento del usuario
    DocumentSnapshot userDoc = await userDocRef.get();

    // Verificar si el documento del usuario existe y tiene la estructura 'rewards'
    if (userDoc.exists && userDoc.data() is Map<String, dynamic>) {
      // Convertir los datos del usuario a un mapa
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Obtener el saldo actual de QuizCoins del usuario
      int currentQuizCoins = userData['quizCoins'] ?? 0;
      int updatedQuizCoins = currentQuizCoins + rewardAmount;

      // Actualizar el saldo de QuizCoins del usuario
      await userDocRef.update({'quizCoins': updatedQuizCoins});

      // Marcar la recompensa como reclamada
      Map<String, bool> claimedRewards = {...(userData['rewards'] ?? {}), level.toString(): true};
      await userDocRef.update({'rewards': claimedRewards});

      print('Recompensa reclamada: $rewardAmount QuizCoins');

      setState(() {}); // Actualizar el estado para reflejar el cambio

      // Mostrar un mensaje de éxito o realizar cualquier otra acción necesaria
    } else {
      // Si no existe la estructura 'rewards', crea la estructura y luego reclama la recompensa
      Map<String, bool> claimedRewards = {level.toString(): true};
      await userDocRef.update({'rewards': claimedRewards});

      print('Estructura "rewards" creada y recompensa reclamada: $rewardAmount QuizCoins');

      setState(() {}); // Actualizar el estado para reflejar el cambio

      // Mostrar un mensaje de éxito o realizar cualquier otra acción necesaria
    }
  } catch (e) {
    print('Error al reclamar la recompensa: $e');
    // Manejar cualquier error que ocurra durante el proceso
  }
}



  // Otras funciones de ayuda (getLevel, buildAvatarOption)...

  // Función para obtener el nivel del usuario
  double getLevel(int quizPoints) {
    for (int i = 16; i > 0; i--) {
      if (quizPoints >= getPointsRequired(i)) {
        return i.toDouble();
      }
    }
    return 1.0;
  }

  // Función para construir opciones de avatar
  Widget buildAvatarOption(String imagePath) {
    return GestureDetector(
      onTap: () {
        // Actualizar la ruta del avatar en Firebase
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
