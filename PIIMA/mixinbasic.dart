abstract class Animal {
  String get name;
}

mixin Walking on Animal {
  void walk() {
    print('$name is walking'); // Can access Animal properties
  }
}

class Dog extends Animal with Walking {
  @override
  final String name = 'Rex';
}

void main() {
  var dog = Dog();
  dog.walk(); // Output: "Rex is walking"
}
