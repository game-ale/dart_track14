class Animal {
  void makeSound() => print('Some animal sound');
}

class Dog extends Animal {
  @override
  void makeSound() => print('Woof!');
}
