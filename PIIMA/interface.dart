abstract class Vehicle {
  void start(); // Abstract method (must be implemented)
  void stop(); // Abstract method
}

class Car implements Vehicle {
  @override
  void start() {
    print("Car engine started 🚗");
  }

  @override
  void stop() {
    print("Car brakes applied 🛑");
  }
}

class Bike implements Vehicle {
  @override
  void start() {
    print("Bike kick-started 🏍️");
  }

  @override
  void stop() {
    print("Bike stopped 🚦");
  }
}

void main() {
  Vehicle myCar = Car(); // Treat Car as Vehicle (Polymorphism)
  Vehicle myBike = Bike();

  myCar.start(); // Output: "Car engine started 🚗"
  myBike.stop(); // Output: "Bike stopped 🚦"
}
