**✅ PART 1: Core Concepts of Classes and OOP in Dart**
#*🎯 1. What is a Class?*

A class is a blueprint for creating objects. It defines the properties (variables) and behaviors (methods) of the objects.

#*🔑 2. Creating an Object (Instance)*

You can create objects from a class using the new keyword (optional in Dart).

#*🧱 3. Fields and Methods*

Fields: Variables inside the class (attributes)


Methods: Functions inside the class (actions)

#*🔧 4. Constructors*

A constructor is a special method used to initialize objects.

➤ Default Constructor:

➤ Parameterized Constructor:

➤ Named Constructors:

#*🔐 5. Access Modifiers (Encapsulation)*

Dart has no public, private, or protected keywords.


But you can make a member private by prefixing it with an underscore (_).



#*🌟 6. Getters and Setters*

Use get and set to control access to private fields.

#*⚙️ 7. Static Keyword*

Static members belong to the class, not the instance.

#*🔄 8. this Keyword*

Refers to the current instance of the class.

#*⚠️ 9. Final & Const in Classes*

final → Variable is initialized once (runtime constant).


const → Compile-time constant.

#*⚡ 10. Object Initialization Order (Tip)*

Fields are initialized first → then constructors are executed.

***######impletartion***

🎯 1. What is a Class?

```
class Person {
  String name = '';
  int age = 0;

  void greet() {
    print('Hello, my name is $name and I am $age years old.');
  }
}
```
🔑 2. Creating an Object (Instance)
```
void main() {
  var person = Person();
  person.name = 'Gemechu';
  person.age = 24;
  person.greet();
}
```

🔧 3. Constructors
➤ Default Constructor:
```
class Car {
  String brand = '';

  Car() {
    print('Car created!');
  }
}
```

➤ Parameterized Constructor:
```
class Car {
  String brand;

  Car(this.brand);  // shorthand for assignment
}
```
➤ Named Constructors:
```
class Car {
  String brand;

  Car.electric(this.brand);
  Car.gasoline(this.brand);
}
```
🔐 4. Access Modifiers (Encapsulation)
Dart has no public, private, or protected keywords.

But you can make a member private by prefixing it with an underscore (_).
```
BankAccount {
  double _balance = 0;

  double get balance => _balance; // getter
  set balance(double amount) => _balance = amount; // setter
}
```
🌟 5. Getters and Setters
Use get and set to control access to private fields.
```
class Temperature {
  double _celsius;

  Temperature(this._celsius);

  double get fahrenheit => _celsius * 9 / 5 + 32;

  set fahrenheit(double f) => _celsius = (f - 32) * 5 / 9;
}
```
⚙️ 6. Static Keyword
Static members belong to the class, not the instance.
```
class MathUtils {
  static const double pi = 3.14159;

  static double square(double num) => num * num;
}
```
🔄 7. this Keyword
Refers to the current instance of the class.

```
class Student {
  String name;
  
  Student(this.name) {
    print('Student name is ${this.name}');
  }
}
⚠️ 8. Final & Const in Classes
final → Variable is initialized once (runtime constant).

const → Compile-time constant.
```
 AppConfig {
  static const String appName = 'MyApp';
  final String version;

  AppConfig(this.version);
}
```