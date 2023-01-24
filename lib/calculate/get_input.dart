

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
 
 ParseOutput dividedOutput =  divideToItems(input);
 if(dividedOutput.isProblemWrong){
  return dividedOutput.errorOutput;}
// have string input
  Solution a = calculateNumeric(dividedOutput.output);
  

  print(a.steps);

  return a.answer;
}