import 'package:flutter/material.dart';
import 'question.dart';

class MyAppState extends InheritedWidget {
  final List<Question> mathQuestions = [
    Question(
      question: '¿Cuánto es 18 + 15?',
      options: ['29', '33', '41', '36'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el resultado de 3 x 5?',
      options: ['8', '12', '15', '20'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuánto es la raíz cuadrada de 16?',
      options: ['2', '4', '6', '8'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuánto es 3^2 - 2^3?',
      options: ['5', '1', '4', '9'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el resultado de 2^4 ÷ 4^2?',
      options: ['1/2', '1', '2', '4'],
      correctOptionIndex: 1,
    ),
  ];

  final List<Question> biologyQuestions = [
    Question(
      question: '¿Cuál es la célula más grande del cuerpo humano?',
      options: ['Célula nerviosa', 'Célula muscular', 'Célula ósea', 'Célula reproductora femenina'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuántos huesos tiene el cuerpo humano?',
      options: ['206', '204', '220', '230'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el órgano más grande del cuerpo humano?',
      options: ['Hígado', 'Cerebro', 'Piel', 'Corazón'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué tipo de células son las encargadas de la defensa del cuerpo?',
      options: ['Neuronas', 'Eritrocitos', 'Leucocitos', 'Plaquetas'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el nombre de la célula reproductora masculina?',
      options: ['Óvulo', 'Espermatozoide', 'Glóbulo rojo', 'Glóbulo blanco'],
      correctOptionIndex: 1,
    ),
  ];

  final List<Question> chemistryQuestions = [
    Question(
      question: '¿Cuál es la fórmula del agua?',
      options: ['H2O', 'CO2', 'HO2', 'HCl'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el elemento más abundante en la corteza terrestre?',
      options: ['Hierro', 'Aluminio', 'Oxígeno', 'Silicio'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el símbolo químico del oro?',
      options: ['Au', 'Ag', 'Pt', 'Cu'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el gas más abundante en la atmósfera terrestre?',
      options: ['Nitrógeno', 'Oxígeno', 'Dióxido de carbono', 'Hidrógeno'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la fórmula química del dióxido de carbono?',
      options: ['CO', 'CO2', 'C2O', 'C2O4'],
      correctOptionIndex: 1,
    ),
  ];

  final List<Question> technologyQuestions = [
    Question(
      question: '¿Quién es el fundador de Microsoft?',
      options: ['Steve Jobs', 'Bill Gates', 'Mark Zuckerberg', 'Elon Musk'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál de estos no es un sistema operativo móvil?',
      options: ['Android', 'iOS', 'Windows', 'Linux'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿En qué año se fundó Google?',
      options: ['1996', '1998', '2000', '2002'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Quién es el CEO de Tesla Motors?',
      options: ['Jeff Bezos', 'Tim Cook', 'Elon Musk', 'Mark Zuckerberg'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué empresa desarrolló el primer microprocesador comercial?',
      options: ['Intel', 'Microsoft', 'Apple', 'IBM'],
      correctOptionIndex: 0,
    ),
  ];

  final List<Question> languageQuestions = [
    Question(
      question: '¿Cuál es el idioma más hablado del mundo?',
      options: ['Mandarín', 'Español', 'Inglés', 'Hindi'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué significa "Hello" en español?',
      options: ['Hola', 'Adiós', 'Gracias', 'Por favor'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la palabra más larga en español según la RAE?',
      options: ['Esternocleidomastoideo', 'Desoxirribonucleico', 'Anticonstitucionalmente', 'Electroencefalografista'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el término para una palabra que se lee igual al revés?',
      options: ['Anagrama', 'Palíndromo', 'Sinónimo', 'Antónimo'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué palabra describe el miedo a los números?',
      options: ['Aritmofobia', 'Acrofobia', 'Claustrofobia', 'Aracnofobia'],
      correctOptionIndex: 0,
    ),
  ];

  final List<Question> sportsQuestions = [
    Question(
      question: '¿Cuál es el deporte más popular en el mundo?',
      options: ['Fútbol', 'Baloncesto', 'Tenis', 'Críquet'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Quién es considerado el mejor jugador de baloncesto de todos los tiempos?',
      options: ['LeBron James', 'Magic Johnson', 'Kobe Bryant', 'Michael Jordan'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el deporte nacional de Japón?',
      options: ['Sumo', 'Judo', 'Karate', 'Kendo'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿En qué país se originó el tenis?',
      options: ['Francia', 'Inglaterra', 'Estados Unidos', 'España'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuántos jugadores hay en un equipo de fútbol?',
      options: ['10', '11', '12', '9'],
      correctOptionIndex: 1,
    ),
  ];

  MyAppState({Key? key, required Widget child}) : super(key: key, child: child);

  static MyAppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyAppState>();
  }

  @override
  bool updateShouldNotify(MyAppState oldWidget) => false;
}
