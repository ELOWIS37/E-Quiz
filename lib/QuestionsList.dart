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
    Question(
      question: '¿Cuál es el resultado de 45 + 4 / (9 - 2)?',
      options: ['7', '6', '5', '9'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuánto es la raíz cuadrada de 169?',
      options: ['16', '13', '43', '17'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué número romano es LX?',
      options: ['9', '110', '60', '510'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuánto es la suma de los ángulos internos de un triángulo?',
      options: ['180', '120', '90', '360'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el resultado de 2^5?',
      options: ['20', '16', '25', '32'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el teorema que relaciona los lados de un triángulo rectángulo?',
      options: ['Teorema de Euclides', 'Teorema de Bayes', 'Teorema de Pitágoras', 'Teorema de Tales'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el valor del número pi (π) truncado a tres decimales?',
      options: ['3,142', '3,145', '3,155', '3,141'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué día es el día de pi (π)?',
      options: ['12 de Febrero', '1 de Mayo', '3 de Junio', '14 de Marzo'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Quién inventó el signo de igual a "="?',
      options: ['Robert Record', 'Pitágoras', 'Arquímedes', 'Tales de Mileto'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cual és el promedio de los primeros 50 números naturales?',
      options: ['50', '25', '25,5', '17,5'],
      correctOptionIndex: 2,
    ),
    Question(
      question: 'Nombre de un ángulo mayor de 180 grados pero menor de 360 grados.',
      options: ['Ángulo Obtuso', 'Ángulo reflexo', 'Ángulo reflejo', 'Ángulo negativo'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Quién descubrió las leyes de la palanca y la polea?',
      options: ['Arquímedes', 'Albert Einstein', 'Euclides', 'Alan Turing'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Dónde se originó el “Cuadrado Mágico”?',
      options: ['Estados Unidos', 'China', 'Grecia', 'Italia'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué palabra matemática significa el tamaño relativo de algo?',
      options: ['Area', 'Perímetro', 'Base', 'Escala'],
      correctOptionIndex: 3,
    ),
    Question(
      question: 'Nombre del sistema de medición antes de los métricos?',
      options: ['FPS', 'Imperial', 'Sistema Técnico', 'CGS'],
      correctOptionIndex: 1,
    ),
    Question(
      question: 'Nombre del sistema de medición antes de los métricos?',
      options: ['FPS', 'Imperial', 'Sistema Técnico', 'CGS'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Qué término matemático significa lo más correcto y exacto posible?',
      options: ['Preciso', 'Perfecto', 'Óptimo', 'Puntual'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la "receta" matemática para resolver algo?',
      options: ['Técnica', 'Método', 'Fórmula', 'Procedimiento'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuántos lados tiene un icosaedro regular?',
      options: ['10', '12', '20', '24'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es la probabilidad de obtener tres caras al lanzar una moneda tres veces?',
      options: ['1/8', '1/2', '1/4', '1/6'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el área de un círculo con radio 5 unidades?',
      options: ['25π', '10π', '20π', '15π'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el número áureo, representado por la letra griega phi, truncado a tres decimales?',
      options: ['1,618', '1,414', '2,718', '3,142'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el resultado de (2^3) + (4^2)?',
      options: ['20', '17', '18', '24'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el valor de x en la ecuación 2x + 5 = 17?',
      options: ['6', '8', '7', '10'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es la suma de los primeros 10 números primos?',
      options: ['100', '155', '58', '129'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el resultado de la serie geométrica: 1 + 2 + 4 + 8 + ... + 256?',
      options: ['510', '511', '508', '505'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el valor de la derivada de x^3 en x=2?',
      options: ['6', '12', '8', '4'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuántos grados hay en la suma de los ángulos de un octógono regular?',
      options: ['1200', '1400', '1080', '960'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuántos divisores tiene el número 120?',
      options: ['14', '12', '16', '18'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es la probabilidad de obtener un número par al lanzar un dado de seis caras?',
      options: ['1/2', '1/3', '1/4', '1/6'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el volumen de un cubo con arista de longitud 6 unidades?',
      options: ['36', '72', '108', '216'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el área de un triángulo con lados de longitud 3, 4 y 5 unidades?',
      options: ['6', '8', '10', '12'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el resultado de la serie aritmética: 3 + 7 + 11 + 15 + ... + 35?',
      options: ['168', '154', '140', '126'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el valor de e elevado a la potencia de 1?',
      options: ['1', '2', 'e', '0'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el resultado de (4^3) / (2^3)?',
      options: ['16', '8', '64', '32'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el resultado de la serie aritmética: 4 + 9 + 14 + 19 + ... + 39?',
      options: ['185', '190', '195', '200'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el valor de e elevado a la potencia de 0?',
      options: ['1', '2', 'e', '0'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el resultado de la suma de los primeros 100 números naturales?',
      options: ['5050', '4950', '5000', '5150'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el resultado de la raíz cúbica de 64?',
      options: ['4', '6', '8', '12'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el resultado de la suma de los ángulos internos de un cuadrilátero convexo?',
      options: ['180°', '270°', '360°', '540°'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es la fórmula general del teorema de Pitágoras para un triángulo rectángulo?',
      options: ['a^2 + b^2 = c^2', 'a^2 = b^2 + c^2', 'c^2 = a^2 - b^2', 'c = a + b'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el resultado de la suma de los primeros 20 números pares?',
      options: ['200', '210', '220', '230'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el resultado de la operación (2^3)^4?',
      options: ['8', '64', '256', '4096'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el resultado de la raíz cuadrada de 144?',
      options: ['12', '13', '14', '15'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuántos grados hay en un ángulo recto?',
      options: ['90°', '180°', '270°', '360°'],
      correctOptionIndex: 0,
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
    Question(
      question: '¿La mitosis es un proceso de...?',
      options: ['División celular de células sexuales', 'División celular de células idénticas', 'Alimentación celular', 'Muerte celular programada'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué función tiene el ADN en una célula?',
      options: ['Almacena información genética', 'Regula la producción de proteínas', 'Mantiene la estructura celular', 'Participa en la fotosíntesis'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál de estos no es un tipo de tejido animal?',
      options: ['Epitelial', 'Nervioso', 'Vascular', 'Esquelético'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿La fotosíntesis es un proceso de...?',
      options: ['Respiración celular', 'División celular', 'Producción de energía.', 'Conversión de luz en energía química'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es la función principal del sistema circulatorio?',
      options: ['Respiración', 'Digestión', 'Transporte de nutrientes y oxígeno', 'Movimiento'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿La homeostasis es un proceso de...?',
      options: ['Adaptación al ambiente', 'Regulación interna del cuerpo', 'Reproducción celular', 'Evolución'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es la función de las mitocondrias en una célula?',
      options: ['Almacenar agua', 'Producir energía', 'Producir proteínas', 'Almacenar nutrientes'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿La polinización en las plantas es un proceso de...?',
      options: ['Transporte de nutrientes', 'Reproducción', 'Obtención de agua', 'Fertilización'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el órgano responsable de la producción de insulina en el cuerpo humano?',
      options: ['Páncreas', 'Hígado', 'Riñones', 'Estómago'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es el sistema inmunológico?',
      options: ['Un sistema de transporte de nutrientes', 'Un sistema de control hormonal', 'Un sistema contra enfermedades', 'Un sistema de reproducción'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el proceso por el cual las plantas convierten la luz solar en energía?',
      options: ['Fotosíntesis', 'Respiración', 'Digestión', 'Transpiración'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué órgano del cuerpo humano es responsable de filtrar los desechos de la sangre?',
      options: ['Pulmones', 'Riñones', 'Hígado', 'Estómago'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cómo se llama el proceso de división celular que produce células sexuales?',
      options: ['Mitosis', 'Fotosíntesis', 'Meiosis', 'Digestión'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué tipo de células son los glóbulos rojos?',
      options: ['Leucocitos', 'Eritrocitos', 'Plaquetas', 'Neuronas'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué estructura celular almacena el material genético en las células eucariotas?',
      options: ['Membrana celular', 'Mitocondria', 'Núcleo', 'Cloroplasto'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cómo se llama el proceso de respiración celular que ocurre en ausencia de oxígeno?',
      options: ['Fotosíntesis', 'Respiración celular', 'Oxidación', 'Fermentación'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Qué sistema del cuerpo humano está compuesto por huesos y cartílagos?',
      options: ['Sistema muscular', 'Sistema esquelético', 'Sistema nervioso', 'Sistema circulatorio'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué tipo de tejido cubre la superficie del cuerpo y las cavidades internas?',
      options: ['Tejido conectivo', 'Tejido muscular', 'Tejido nervioso', 'Tejido epitelial'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es la enzima responsable de desnaturalizar las proteínas en el estómago?',
      options: ['Pepsina', 'Amilasa', 'Lipasa', 'Tripsina'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué parte del sistema nervioso regula funciones como la respiración y el ritmo cardíaco?',
      options: ['Sistema nervioso autónomo', 'Sistema nervioso central', 'Sistema nervioso periférico', 'Sistema nervioso somático'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué tipo de células son las células madre que pueden convertirse en cualquier tipo de célula del cuerpo?',
      options: ['Células totipotentes', 'Células pluripotentes', 'Células multipotentes', 'Células unipotentes'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el nombre del proceso por el cual los organismos vivos obtienen energía de las moléculas de glucosa?',
      options: ['Glicólisis', 'Gluconeogénesis', 'Fosforilación oxidativa', 'Ciclo de Krebs'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Qué tipo de biomoléculas son las enzimas?',
      options: ['Proteínas', 'Ácidos nucleicos', 'Lípidos', 'Carbohidratos'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la función principal del sistema linfático en el cuerpo humano?',
      options: ['Transportar nutrientes', 'Producir hormonas', 'Proteger contra infecciones', 'Regular la temperatura corporal'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el órgano donde ocurre la mayor parte de la absorción de nutrientes en el sistema digestivo?',
      options: ['Estómago', 'Intestino delgado', 'Hígado', 'Intestino grueso'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué función tienen las células ciliadas en el oído interno?',
      options: ['Detectar luz', 'Detectar sonidos', 'Producir moco', 'Regular la temperatura'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué estructura del ojo es responsable de enfocar la luz en la retina?',
      options: ['Cristalino', 'Córnea', 'Iris', 'Pupila'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del proceso de división celular que permite el crecimiento y la reparación de tejidos?',
      options: ['Mitosis', 'Meiosis', 'Fotosíntesis', 'Apoptosis'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el proceso de reproducción asexual en el que una célula madre se divide en dos células hijas idénticas?',
      options: ['Mitosis', 'Meiosis', 'Fecundación', 'Fragmentación'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué proceso biológico es esencial para la producción de cerveza y vino?',
      options: ['Fermentación', 'Fotosíntesis', 'Respiración celular', 'Digestión'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del ácido nucleico que almacena la información genética en los seres vivos?',
      options: ['Ácido ribonucleico (ARN)', 'Ácido desoxirribonucleico (ADN)', 'Ácido fosfórico (ADP)', 'Ácido cítrico (ATP)'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el proceso mediante el cual las plantas pierden agua a través de sus hojas?',
      options: ['Transpiración', 'Evaporación', 'Infiltración', 'Percolación'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué tipo de organismos son capaces de producir su propio alimento mediante la fotosíntesis?',
      options: ['Heterótrofos', 'Autótrofos', 'Saprofitos', 'Parásitos'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el nombre de la interacción entre dos especies en la que ambas se benefician?',
      options: ['Depredación', 'Competencia', 'Comensalismo', 'Simbiosis mutualista'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Qué tipo de estructura tienen los hongos que utilizan para la reproducción y la dispersión de esporas?',
      options: ['Raíz', 'Tallo', 'Hoja', 'Seta'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el proceso de crecimiento y desarrollo de un organismo desde la etapa de embrión hasta la adultez?',
      options: ['Metamorfosis', 'Fecundación', 'Ontogenia', 'Mutación'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué tipo de células son las encargadas de la producción de anticuerpos en el sistema inmunológico?',
      options: ['Linfocitos T', 'Linfocitos B', 'Macrófagos', 'Plaquetas'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el proceso por el cual los organismos convierten los compuestos orgánicos en energía sin usar oxígeno?',
      options: ['Fermentación', 'Respiración celular', 'Fotosíntesis', 'Oxidación'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué teoría propone que todas las formas de vida en la Tierra comparten un ancestro común?',
      options: ['Teoría de la evolución', 'Teoría del creacionismo', 'Teoría del fijismo', 'Teoría de la abiogénesis'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué término se refiere al conjunto de genes presentes en un organismo?',
      options: ['Genotipo', 'Fenotipo', 'Cariotipo', 'Mutación'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la principal función de las células epiteliales en el cuerpo humano?',
      options: ['Conducción de impulsos nerviosos', 'Producción de hormonas', 'Protección y revestimiento de tejidos', 'Almacenamiento de energía'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el nombre del proceso mediante el cual las células se especializan para llevar a cabo funciones específicas en un organismo multicelular?',
      options: ['Diferenciación celular', 'División celular', 'Reproducción celular', 'Mutación genética'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué estructura celular es responsable de la fotosíntesis en las plantas?',
      options: ['Núcleo', 'Cloroplasto', 'Mitochondria', 'Ribosoma'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué molécula almacena la información genética en los organismos vivos?',
      options: ['ARN', 'ADN', 'ARNt', 'ARNr'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el nombre del proceso mediante el cual las plantas obtienen agua y nutrientes del suelo?',
      options: ['Fotosíntesis', 'Transpiración', 'Absorción', 'Respiración'],
      correctOptionIndex: 2,
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
    Question(
      question: '¿Qué es el pH de una solución neutra?',
      options: ['7', '0', '14', '10'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el símbolo químico del hierro?',
      options: ['Fe', 'H', 'Ir', 'He'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué elemento químico tiene el símbolo "K"?',
      options: ['Potasio', 'Calcio', 'Magnesio', 'Plata'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el proceso de separación de una mezcla en sus componentes mediante la aplicación de un solvente?',
      options: ['Cromatografía', 'Destilación', 'Filtración', 'Extracción'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es la fórmula química del amoniaco?',
      options: ['NH3', 'NO2', 'N2O', 'NH4'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué tipo de enlace se forma cuando dos átomos comparten electrones?',
      options: ['Enlace covalente', 'Enlace iónico', 'Enlace metálico', 'Enlace polar'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la fórmula química del ácido clorhídrico?',
      options: ['HCl', 'H2SO4', 'HNO3', 'H2O'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es un catión?',
      options: ['Un ion con carga positiva', 'Un ion con carga negativa', 'Un átomo neutro', 'Un átomo con masa atómica alta'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la unidad básica de la materia?',
      options: ['Átomo', 'Molécula', 'Célula', 'Partícula'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del proceso en el cual una sustancia sólida se convierte en vapor sin pasar por el estado líquido?',
      options: ['Sublimación', 'Evaporación', 'Condensación', 'Solidificación'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el compuesto químico comúnmente conocido como sal de mesa?',
      options: ['Cloruro de sodio', 'Sulfato de calcio', 'Carbonato de sodio', 'Óxido de magnesio'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el gas utilizado en las bebidas gaseosas para producir efervescencia?',
      options: ['Nitrógeno', 'Oxígeno', 'Dióxido de carbono', 'Hidrógeno'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué elemento químico es esencial para la vida y se encuentra en todas las proteínas?',
      options: ['Fósforo', 'Carbono', 'Calcio', 'Sodio'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el proceso mediante el cual un líquido pasa a estado gaseoso a temperatura ambiente?',
      options: ['Fusión', 'Sublimación', 'Evaporación', 'Condensación'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el nombre del ácido presente en el vinagre?',
      options: ['Ácido clorhídrico', 'Ácido sulfúrico', 'Ácido acético', 'Ácido cítrico'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es la fórmula química del dióxido de azufre?',
      options: ['SO2', 'CO2', 'H2SO4', 'N2O'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué propiedad química define la capacidad de un ácido para ceder protones en una reacción química?',
      options: ['Densidad', 'Basicidad', 'Acidez', 'Reactividad'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es la función principal de los catalizadores en una reacción química?',
      options: ['Aumentar la temperatura de la reacción', 'Reducir la velocidad de la reacción', 'Acelerar la velocidad de la reacción', 'Cambiar el equilibrio químico de la reacción'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es la fórmula química del agua oxigenada?',
      options: ['H2O', 'H2O2', 'HCl', 'NaOH'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué propiedad define la tendencia de un átomo a atraer electrones en una molécula?',
      options: ['Electronegatividad', 'Valencia', 'Masa atómica', 'Radio atómico'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es la fórmula química del hidróxido de sodio?',
      options: ['NaOH', 'H2O', 'NaCl', 'HCl'],
      correctOptionIndex: 0,
    ),
      Question(
      question: '¿Qué es el número atómico de oxígeno?',
      options: ['7', '8', '16', '32'],
      correctOptionIndex: 1,
    ),
      Question(
      question: '¿Cuál es la fórmula química del cloruro de sodio?',
      options: ['NaOH', 'HCl', 'NaCl', 'H2SO4'],
      correctOptionIndex: 2,
    ),
      Question(
      question: '¿Cuál de los siguientes elementos es un metal alcalino?',
      options: ['Flúor', 'Litio', 'Yodo', 'Nitrógeno'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el número atómico del carbono?',
      options: ['4', '6', '12', '14'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál de los siguientes elementos es un halógeno?',
      options: ['Litio', 'Flúor', 'Sodio', 'Potasio'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es la fórmula química del monóxido de carbono?',
      options: ['CH4', 'CO2', 'H2O', 'CO'],
      correctOptionIndex: 3,
    ),
     Question(
      question: '¿Cuál es la fórmula química del peróxido de hidrógeno?',
      options: ['H2O', 'H2O2', 'HCl', 'NaOH'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál de las siguientes sustancias es un ácido fuerte?',
      options: ['Ácido acético', 'Ácido cítrico', 'Ácido clorhídrico', 'Ácido láctico'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el compuesto químico comúnmente conocido como cal?',
      options: ['Carbonato de calcio', 'Hidróxido de calcio', 'Óxido de calcio', 'Cloruro de calcio'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Que es una solución?',
      options: ['Mezcla de dos o mas compuestos', 'Compuesto único', 'Sustancia incolora', 'Ninguna es correcta'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el número atómico del hidrógeno?',
      options: ['1', '2', '3', '4'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el estado de la materia que no tiene forma ni volumen fijo?',
      options: ['Sólido', 'Líquido', 'Gas', 'Plasma'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué científico es conocido como el padre de la tabla periódica?',
      options: ['Isaac Newton', 'Albert Einstein', 'Dmitri Mendeléyev', 'Marie Curie'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el nombre del proceso de separación de los componentes de una mezcla mediante su distribución entre dos fases?',
      options: ['Destilación', 'Cristalización', 'Cromatografía', 'Filtración'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el nombre del proceso de conversión de un gas o vapor a líquido?',
      options: ['Evaporación', 'Sublimación', 'Condensación', 'Fusión'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué ley establece que la masa total en una reacción química cerrada permanece constante?',
      options: ['Ley de Dalton', 'Ley de Lavoisier', 'Ley de Gay-Lussac', 'Ley de Boyle'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Por qué la tabla periódica está organizada como lo está?',
      options: ['Por el número atómico', 'Por el peso atómico', 'Por el número de electrones', 'Por el número de protones'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el último elemento de la tabla periódica?',
      options: ['Ununseptio', 'Livermorio', 'Flerovio', 'Oganesón'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál de los siguientes elementos es un metal alcalino?',
      options: ['Aluminio', 'Astatino', 'Oro', 'Francio'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál de los siguientes es un polímero natural?',
      options: ['Polietileno', 'PVC', 'Celulosa', 'Nylon'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál de los siguientes elementos es un gas noble?',
      options: ['Oxígeno', 'Helio', 'Hidrógeno', 'Nitrógeno'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál de los siguientes elementos es un metaloide?',
      options: ['Rodio', 'Zinc', 'Aluminio', 'Arsénico'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál de los siguientes no es un compuesto orgánico?',
      options: ['Metano', 'Etanol', 'Sal de mesa', 'Glucosa'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál de los siguientes es un isótopo del carbono?',
      options: ['Carbono-12', 'Carbono-13', 'Ambos son isótopos del carbono', 'Ninguno de los anteriores'],
      correctOptionIndex: 2,
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
    Question(
      question: '¿Cuál de estos lenguajes de programación es orientado a objetos?',
      options: ['C', 'Java', 'Python', 'JavaScript'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué significa la sigla "HTML"?',
      options: ['Hyper Text Markup Language', 'High Tech Machine Learning', 'Human Testing Modem Logic', 'Home Tool Markup Language'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál de estas compañías no se dedica principalmente al desarrollo de software?',
      options: ['Microsoft', 'Oracle', 'IBM', 'Tesla'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Qué sigla representa una medida de velocidad de transmisión de datos en redes de computadoras?',
      options: ['RPM', 'GPU', 'MB', 'Mbps'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Qué significa "CPU"?',
      options: ['Central Processing Unit', 'Computer Processing Unit', 'Core Processing Unit', 'Central Program Unit'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál de las siguientes opciones no es un tipo de memoria de computadora?',
      options: ['RAM', 'ROM', 'CPU', 'Cache'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué protocolo se utiliza para enviar y recibir correos electrónicos?',
      options: ['HTTP', 'FTP', 'SMTP', 'TCP'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué tecnología se utiliza para conectar dispositivos a Internet sin necesidad de cables?',
      options: ['Wi-Fi', 'Bluetooth', 'NFC', 'Ethernet'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es un "algoritmo de hashing"?',
      options: ['Un algoritmo para ordenar datos', 'Un algoritmo para cifrar datos', 'Un algoritmo para comprimir archivos', 'Un algoritmo para buscar información'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es la diferencia principal entre "machine learning" y "deep learning"?',
      options: ['Tipo de algoritmos', 'Cantidad de datos', 'Costo', 'Velocidad'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es una "API RESTful" y cuáles son sus principales características?',
      options: ['Interacción con REST', 'Acceso a bases de datos', 'Transferencia de archivos', 'Comunicación móvil'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es la "computación cuántica" y en qué se diferencia de la computación clásica?',
      options: ['Transistores', 'Ceros y unos', 'Basada en mecánica cuántica', 'Matemáticas avanzadas'],
      correctOptionIndex: 2, 
    ),
    Question(
      question: '¿Cuál es su función de el "algoritmo de enrutamiento" en las redes informáticas?',
      options: ['Optimizar ruta de datos', 'Detectar errores', 'Controlar acceso', 'Garantizar seguridad'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es el "procesamiento paralelo" y en qué se diferencia del "procesamiento secuencial"?',
      options: ['Requiere menos energía', 'Realiza una tarea a la vez', 'Utiliza más memoria RAM', 'Realiza tareas simultáneamente'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Qué tecnología se utiliza para hacer posibles las llamadas telefónicas?',
      options: ['Ethernet', 'Bluetooth', 'POP', 'VoIP'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuándo se fundó Nintendo?',
      options: ['1974', '1889', '1976', '2001'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué marca vende más teléfonos en el mundo?',
      options: ['Samsung', 'Apple', 'Huawei', 'Xiaomi'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué significa la sigla CGI en un programa?',
      options: ['Control Group Items', 'Common Gateway Interface', 'Computer Graphics Interface', 'Cascading Style Sheets'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el lenguaje de alto nivel de propósito general creado por Van Rossum?',
      options: ['Ruby', 'C++', 'Java', 'Python'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es la red social más grande del mundo?',
      options: ['Twitter', 'Facebook', 'Instagram', 'LinkedIn'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el nombre del primer navegador web desarrollado por Tim Berners-Lee?',
      options: ['Firefox', 'Internet Explorer', 'Netscape Navigator', 'WorldWideWeb'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el nombre del protocolo de transferencia de archivos utilizado para descargar archivos de la web?',
      options: ['HTTP', 'SSH', 'FTP', 'SMTP'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Qué compañía desarrolló la primera computadora personal?',
      options: ['IBM', 'Apple', 'Microsoft', 'HP'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del primer videojuego comercialmente exitoso?',
      options: ['Pac-Man', 'Tetris', 'Space Invaders', 'Pong'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el algoritmo de consenso utilizado por la red de Bitcoin?',
      options: ['Proof of Stake', 'Delegated Proof of Stake', 'Proof of Authority', 'Proof of Work'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el nombre del primer virus informático conocido?',
      options: ['ILOVEYOU', 'Stuxnet', 'Morris Worm', 'Brain'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Cuál es el nombre del lenguaje de programación utilizado para el desarrollo de aplicaciones iOS?',
      options: ['Swift', 'Objective-C', 'Java', 'C#'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué significa la sigla "URL"?',
      options: ['Uniform Resource Locator', 'Universal Resource Link', 'Uniform Reference Locator', 'Universal Reference Link'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del algoritmo utilizado por el motor de búsqueda de Google?',
      options: ['PageRank', 'SearchRank', 'RankBoost', 'KeywordRank'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del modelo de programación utilizado para dividir una aplicación en pequeños componentes independientes?',
      options: ['Microservicios', 'Monolito', 'Arquitectura de capas', 'Servicios web'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es un "phishing"?',
      options: ['Un tipo de malware', 'Robo de información personal', 'Sistema de autenticación', 'Acoso Virtual'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Cuál es el nombre del primer sistema operativo desarrollado por Microsoft?',
      options: ['Windows 95', 'MS-DOS', 'Windows XP', 'Windows 10'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Quién es conocido como el "padre de la informática"?',
      options: ['Bill Gates', 'Alan Turing', 'Steve Jobs', 'Tim Berners-Lee'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué famoso científico es considerado el padre de la computación cuántica?',
      options: ['Stephen Hawking', 'Alan Turing', 'Richard Feynman', 'David Deutsch'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Quién fue el cofundador de Apple junto con Steve Jobs?',
      options: ['Steve Wozniak', 'Bill Gates', 'Mark Zuckerberg', 'Larry Page'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Dónde se encuentra la sede central de Google?',
      options: ['Nueva York', 'San Francisco', 'Seattle', 'Mountain View'],
      correctOptionIndex: 3,
    ),
    Question(
      question: '¿Quién es conocido como el cofundador de Tesla Motors?',
      options: ['Elon Musk', 'Jeff Bezos', 'Mark Zuckerberg', 'Larry Page'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del primer navegador web desarrollado por Netscape Communications Corporation?',
      options: ['Mozilla Firefox', 'Internet Explorer', 'Netscape Navigator', 'Google Chrome'],
      correctOptionIndex: 2,
    ),
    Question(
      question: '¿Cuál es el nombre del algoritmo utilizado para buscar elementos en una lista de forma eficiente?',
      options: ['Búsqueda lineal', 'Búsqueda binaria', 'Búsqueda aleatoria', 'Búsqueda rápida'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué es Git?',
      options: ['Un sistema de control de versiones', 'Un lenguaje de programación', 'Una página web', 'Un editor de texto'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Cuál es el nombre del primer lenguaje de programación de alto nivel?',
      options: ['Fortran', 'COBOL', 'C', 'Pascal'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es un "framework" en el desarrollo de software?',
      options: ['Herramienta de soporte', 'Sistema de guardado de protocolos', 'Una base de datos de internet', 'Lenguaje de programación'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué es un "IDE" en programación?',
      options: ['Interfaz de Desarrollo Externo', 'Entorno de Desarrollo Integrado', 'Instrucción de Desarrollo Estructural', 'Interfaz de Desarrollo Extendido'],
      correctOptionIndex: 1,
    ),
    Question(
      question: '¿Qué es un "mutex" en programación concurrente?',
      options: ['Un mecanismo de sincronización que evita que múltiples threads accedan simultáneamente a recursos compartidos', 'Una función de hash para encriptar datos sensibles', 'Un tipo de bucle en programación', 'Una técnica para resolver ecuaciones diferenciales'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué significa "DRY" en el contexto de desarrollo de software?',
      options: ['Data Retrieval Yearly', 'Designated Regular Yield', 'Don\'t Repeat Yourself', 'Definitely Required Yes'],
      correctOptionIndex: 2,
    ),
  ];

  final List<Question> languageQuestions = [
    Question(
      question: '¿Cuál es el idioma más hablado del mundo?',
      options: ['Mandarín', 'Español', 'Inglés', 'Hindi'],
      correctOptionIndex: 0,
    ),
    Question(
      question: '¿Qué significa "Tomorrow" en español?',
      options: ['Grácias', 'Fin de Semana', 'Ayer', 'Mañana'],
      correctOptionIndex: 3,
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
