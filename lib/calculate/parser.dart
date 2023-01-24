 
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




class ParseOutput {
  List<Item> output;
  bool isProblemWrong = false;
  String errorOutput = ''; 
  ParseOutput({required this.output});

 
}
 




ParseOutput divideToItems(String input){
  int index = 0;



//checking for operators changing nums to negative
int negCheck = 1;
String negCheckOp = '';
//  2 + -  are assosiated with numbers
// 1 operators stand by themself

  List<Item> itemList = [];
  List<Brackets> trackOpenBrackets = [];
  ParseOutput output = ParseOutput(output: itemList);

  error(String errorMessage){
 output.errorOutput = errorMessage;
  output.isProblemWrong = true;
  return -1;
}

  while (index< input.length) {
    
    
    if(isWhitespace(input[index])){
      index++;
      continue;
    }

  ///parse number
    if(num.tryParse(input[index]) != null){
      bool isFullNum = true;
      List<String> number = [];
      
       if (negCheck == 2) {
         
          number.add(negCheckOp);
        }

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
      
      itemList.add(Numeric(n : num.tryParse(n, ) ?? error("wrong number")));
      negCheck = 0;
      continue;
    }

    

    ///parse operators
    input[index].match({
      eq('+'): (){
         if (negCheck == 1) {
          negCheckOp = '+';
          negCheck = 2;
         
        }
        else if(negCheck == 2){
          error('too many operators');
          
        }
        else{
           itemList.add(Add());
           negCheck = 1;
        }
      },
      eq('-'): (){
        if (negCheck == 1) {
          negCheckOp = '-';
          negCheck = 2;
        }else if(negCheck == 2){
          error('too many operators');
          
        }
        else{
           itemList.add(Subtract());
            negCheck = 1;
        }
       
      },
      eq('/') | eq(':'): (){
         if(negCheck == 2){
          error('too many operators');
         
        }
        itemList.add(Divide());
        negCheck = 1;
      },
      eq('*') | eq('.'): (){
        if(negCheck == 2){
          error('too many operators');
          
        }
        itemList.add(Multiply());
        negCheck = 1;
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
        error("wrong bracket order");
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
    


  if (output.isProblemWrong) {
    output.output = itemList;
    break;
  }







    index++;
  }
  if (trackOpenBrackets.isNotEmpty) {
    error("Not enought brackets");
    
  }
  if (!output.isProblemWrong) {
    output.output = itemList;
  }
  



 return output;
}