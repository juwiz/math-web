

import 'package:math_functions/calculate/calculate_numeric.dart';
import 'package:math_functions/calculate/types.dart';

import "parser.dart";

// output format
class Output {
  String answer;
  bool isSolved;
  Output({required this.answer, required this.isSolved});
}
// 


String solveProblem(String input){
 
// have string input
  Expresions a = calculateNumeric(divideToItems(input));
  



  return a.numValue().toString();
}