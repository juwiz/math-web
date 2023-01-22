 
import 'package:match/match.dart';
import 'package:math_functions/calculate/operators.dart';

import 'package:math_functions/calculate/types.dart';



///negative numbers
///


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


bool isProblemWrong = false;


error(){
  isProblemWrong = true;
  return -69;
}



List<Item> divideToItems(String input){
  int index = 0;

  List<Item> itemList = [];
  List<Brackets> trackOpenBrackets = [];

  while (index< input.length) {
    
    
    if(isWhitespace(input[index])){
      index++;
      continue;
    }

  ///parse number
    if(num.tryParse(input[index]) != null){
      bool isFullNum = true;
      List<String> number = [];
      while (true && index < input.length) {

        if( num.tryParse(input[index]) != null){
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
      String n = "";
      for (var e in number) {
        n+= e;
      }

      itemList.add(Numeric(n : num.tryParse(n, ) ?? error()));
     
      continue;
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
      any:(){},
      
  });

  // if input is op increase index - track base on return


///parse brackets
  input[index].match({
    eq('(') | eq('{') | eq('['): (){
      Brackets b = Brackets(openBracketPos: itemList.length);
      itemList.add(b);
      trackOpenBrackets.add(b);
    },
    
    eq(')') | eq('}') | eq(']'): (){
      
      Brackets b = trackOpenBrackets.last;
      
      if (!b.isAbsolute) {
        b.content.addAll(itemList.getRange(b.openBracketPos + 1, itemList.length ));
        itemList.removeRange(b.openBracketPos + 1, itemList.length);
         itemList[b.openBracketPos] = b;
        trackOpenBrackets.removeLast();
      }
      
      else{
        error();
      }
    },
    eq('|'):(){
       Brackets b = trackOpenBrackets.last;
      if(!b.isAbsolute){
        Brackets a = Brackets(openBracketPos: itemList.length, isAbsolute: true);
        
        itemList.add(a);
        trackOpenBrackets.add(a);
      }
      else{
        b.content.addAll(itemList.getRange(b.openBracketPos + 1, itemList.length));
        itemList.removeRange(b.openBracketPos + 1, itemList.length - 1);
        itemList[b.openBracketPos] = b;
        trackOpenBrackets.removeLast();
      }

    },
    any: (){},


  });
    










    index++;
  }


 return itemList;
}