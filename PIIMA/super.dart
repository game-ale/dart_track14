class Animal {
  void sleep() {
    print('Animal sleeping');
  }
}

class Cat extends Animal {
  void sleep() {
    super.sleep(); // call parent method
    print('Cat sleeping');
  }
}
