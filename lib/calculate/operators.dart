import 'types.dart';

class Add extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! + b.numValue()!);
  }
}

class Subtract extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! - b.numValue()!);
  }
}

class Divide extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! / b.numValue()!);
  }
}

class Multiply extends Operator {
  @override
  Expresions combine(Expresions a, Expresions b) {
    return Numeric(n: a.numValue()! * b.numValue()!);
  }
}