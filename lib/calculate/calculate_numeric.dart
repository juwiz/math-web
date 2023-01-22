import 'types.dart';
import 'operators.dart';


// change output so it also returns steps
Expresions calculateNumeric(List<Item> input){

  for (var i = 0; i < input.length; i++) {
    if (input[i].isBrac()) {
      Brackets b = input[i].getBrac()!;
     
      input[i] = calculateNumeric(b.content);
    }
    if (input[i] is Multiply || input[i] is Divide ) {
      Operator o = input[i].getOp()!;
      Expresions lVar = input[i - 1].getExp()!;
      Expresions rVar = input[i + 1].getExp()!;
      
      input[i- 1] = o.combine(lVar, rVar);
      input.removeRange(i, i + 2);

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

      i--;
      
    }
  }
 

      return  input[0].getExp()!;
}