import 'types.dart';

class Add extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! + b.numValue()!);
  }
  @override 
  String asString() => '+';
}

class Subtract extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! - b.numValue()!);
  }
  @override 
  String asString() => '-';
}

class Divide extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! / b.numValue()!);
  }
  @override 
  String asString() => '/';
}

class Multiply extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! * b.numValue()!);
  }
  @override 
  String asString() => '*';
}