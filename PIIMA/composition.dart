class Engine {
  void start() => print('Engine started');
}

class Car {
  final Engine engine = Engine();

  void startCar() {
    engine.start();
    print('Car is ready to go!');
  }
}

void main() {
  Car myCar = Car();
  myCar.startCar(); // Output: Engine started \n Car is ready to go!
}
