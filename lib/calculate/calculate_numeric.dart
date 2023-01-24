import 'dart:math';

import 'types.dart';
import 'operators.dart';
import 'package:match/match.dart';

class Solution {

  List<String> steps = [];
  String answer = '';
  Item? output = null;
}


String parseSteps(List<Item> input)
{ String s = '';
  for (var e in input) {
    if (e.isBrac()) {
      s += e.getBrac()!.asString();
    }
    else{
      s+= e.asString() + ' ';
    }
  }
  return s;
}
// parse steps from items to string


// change output so it also returns steps
Solution calculateNumeric(List<Item> input){
Solution s = Solution();

 s.steps.add(parseSteps(input));

  for (var i = 0; i < input.length; i++) {
    if (input[i].isBrac()) {
      Brackets b = input[i].getBrac()!;
      Solution temp = calculateNumeric(b.content);
      s.steps.addAll(temp.steps);
      input[i] = temp.output!;
    }
    if (input[i] is Multiply || input[i] is Divide ) {
      Operator o = input[i].getOp()!;
      Expresions lVar = input[i - 1].getExp()!;
      Expresions rVar = input[i + 1].getExp()!;
      
      input[i- 1] = o.combine(lVar, rVar);
      input.removeRange(i, i + 2);
      

      s.steps.add(parseSteps(input));
      i--;
    }
  }
  for (var i = 0; i < input.length; i++) {
    
    if (input[i] is Add || input[i] is Subtract ) {
      Operator o = input[i].getOp()!;
      Expresions lVar = input[i - 1].getExp()!;
      Expresions rVar = input[i + 1].getExp()!;
      input[i- 1] = o.combine(lVar, rVar);
      input.removeRange(i, i + 2);

       s.steps.add(parseSteps(input));
      i--;
      
    }
  }

  s.output = input[0];
  s.answer = input[0].asString();
 

      return  s;
}