class Animal {
  void makeSound() {
    print("Animal makes a sound");
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print("Dog barks!");
  }
}

class Cat extends Animal {
  @override
  void makeSound() {
    print("Cat meows!");
  }
}

void main() {
  Animal animal1 = Dog(); // Polymorphism: Dog treated as Animal
  Animal animal2 = Cat(); // Polymorphism: Cat treated as Animal

  animal1.makeSound(); // Output: Dog barks!
  animal2.makeSound(); // Output: Cat meows!
}

/* in very consise way */

void makeAnimalSound(Animal animal) {
  animal.makeSound();
}

void main() {
  makeAnimalSound(Dog());
  makeAnimalSound(Cat());
}
