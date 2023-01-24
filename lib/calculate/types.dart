// normal operators + - * / 
// special operat..ors ! 
// brackets {} ||
// = < >
// ^ and square root


// operators
// numbers 
// problem dividers






class Item {
  bool isOp() => false;
  bool isExp() => false;
  bool isBrac() => false;
  String asString() => '';

  Expresions? getExp() => null;
  Operator? getOp() => null;
  Brackets? getBrac() => null;
}

abstract class Operator extends Item {
  
  @override
  bool isOp() => true;
  @override
  Operator getOp() => this;

  Expresions combine(Expresions a, Expresions b);
   
}

class Brackets extends Item{

  int openBracketPos;
   bool isAbsolute = false;
  Brackets({required this.openBracketPos , isAbsolute});



  @override
  Brackets? getBrac() => this;
  @override
  bool isBrac() => true;



  String s (){
    String s = '';
    if (isAbsolute) {
      s = '|';
    }
    else{
      s = '{';
    }
    for (var e in content) {
      s+= e.asString();
    }
     if (isAbsolute) {
      s += '|';
    }
    else{
      s += '}';
    }
    return s;
  }
  
  @override 
  String asString() => s();
 
 List<Item> content = []; 
}


class Expresions extends Item {

  num? numValue( ) => null; 

  @override
   bool isExp() => true;
   @override
  Expresions getExp()=> this;
} 

class Numeric extends Expresions  {
  num n;
  Numeric({required this.n});

  @override
  num? numValue() => n;
  @override 
  String asString() => n.toString();
}


class UnknownVar extends Expresions  {
  
}

