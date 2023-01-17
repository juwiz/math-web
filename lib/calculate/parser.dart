
import 'dart:js_util';

import 'package:match/match.dart';
import 'package:math_functions/calculate/operators.dart';

import 'package:math_functions/calculate/types.dart';


bool isWhitespace(String input){
  bool i;
  switch (input) {
    case " ":
      i = true;
      break;
    case "\t":
      i = true;
      break;
    case "\n":
      i = true;
      break;
    default:
      i = false;
  }
  
  return i;

}





List<Item> divideToItems(String input){
  int index = 0;

  List<Item> itemList = [];
  List<Brackets> trackOpenBrackets = [];

  while (index< input.length) {
    
    ///whitepace
    ///operators
    ///brackets
    ///unknown vars
    //number
    if(isWhitespace(input[index])){
      index++;
      continue;
    }

  ///parse number
    if(num.tryParse(input[index]) != null){
      bool isFullNum = true;
      List<String> number = [];
      while (true) {

        if(num.tryParse(input[index]) != null){
          number.add(input[index++]);
          
        }else if((input[index] == '.' || input[index] == ',') && isFullNum){
          isFullNum = false;
          number.add('.');
          index++;

        }
        else{
          break;
        }
      }
      itemList.add(Numeric(n : num.parse(number.toString())));
    }

    // !!add return for tracking operators, controling if problem is valid

    ///parse operators
    input[index].match({
      eq('+'): (){
        itemList.add(Add());
      },
      eq('-'): (){
        itemList.add(Subtract());
      },
      eq('/') | eq(':'): (){
        itemList.add(Divide());
      },
      eq('*') | eq('.'): (){
        itemList.add(Multiply());
      },
  });

  // if input is op increase index - track base on return



  input[index].match({
    eq('(') | eq('{') | eq('['): (){
      Brackets b = Brackets(openBracketPos: itemList.length);
      itemList.add(b);
      trackOpenBrackets.add(b);
    },

    eq(')') | eq('}') | eq(']'): (){
      Brackets b = trackOpenBrackets.last;
      if (!b.isAbsolute()) {
        b.content()!.addAll(itemList.getRange(b.openBracketPos, itemList.length));
      }
    }


  });
    










    
  }


 return itemList;
}