*** Inheritance, Polymorphism, Abstract Classes, Interfaces, and Mixins ***
## 🔗 1. Inheritance (Extending a Class) 

Dart supports single inheritance using the extends keyword.

✨ Key Points:

A subclass inherits all public and protected members from the parent.


Dart doesn’t support multiple inheritance via classes.


Overriding is allowed (explained below).


** 🔄 2. Method Overriding **


You can override a method in a subclass using the @override annotation.

🔥 3. Super Keyword

The super keyword refers to the parent class.

🧩 4. Polymorphism

Polymorphism allows objects of different classes to be treated as objects of a common superclass.

In Dart, polymorphism works seamlessly with method ** overriding. **


🧰 5. Abstract Classes

Abstract classes cannot be instantiated directly and are used to define a contract.

✔️ Tips:

Use abstract classes for base functionality & shared code.


You can have concrete (non-abstract) methods in an abstract class.


🕸️ 6. Interfaces (Implicit Interfaces in Dart)

In Dart, all classes can act as interfaces. Use implements to force a class to define all the methods and properties.

✔️ Use interfaces when:

You want to force multiple classes to follow the same contract, but without inheriting implementation.


🧬 7. Mixins (Code Reuse)

Mixins are used to reuse code in multiple classes. Use the with keyword.

✔️ Use Mixins for:

Adding functionality to multiple unrelated classes


Avoiding duplication of code


Can be combined (with A, B, C)



📂 8. Multiple Inheritance with Mixins (Workaround for Dart's Single Inheritance)

Dart doesn’t allow multiple inheritance, but you can use multiple mixins:

⚙️ 9. The Object Class

In Dart, all classes implicitly extend the Object class, which provides methods like:
toString()


✅ 1. Favor Composition Over Inheritance

Instead of extending a class, sometimes it’s better to compose it as a member variable. This promotes loose coupling and flexibility.

⚠️ 2. Keep Classes Small and Focused

Each class should have one responsibility.


Break large classes into smaller, manageable ones.

🔑 3. Use Abstract Classes and Interfaces to Define Contracts

If you have a shared contract, define it as an abstract class or interface. This makes testing and future scaling easier.

🚀 4. Avoid Overusing Mixins

Mixins are powerful, but overusing them can make your codebase confusing. Use them wisely and keep them single-purpose.

⚙️ 5. Encapsulate Internal Details

Use private fields and methods (_fieldName, _methodName) to hide implementation details.

🏷️ 6. Use Factory Constructors for Singleton and Object Control

Factory constructors let you control how instances of a class are created.

🔍 7. Override toString(), ==, and hashCode for Better Object Comparison

🔄 8. Use the late Keyword Wisely

late allows you to declare non-nullable variables that will be initialized later.

📦 9. Favor Immutability for Model/Data Classes

You can create immutable classes using final fields and a const constructor.

⚙️ 10. Avoid Anti-Patterns

❌ Over-inheritance

 ❌ God Classes (one class doing too much)

 ❌ Using static where instance is better

 ❌ Ignoring encapsulation

 ❌ Over-engineering small projects

🏛️ Advanced OOP Design Patterns in Dart
🔹 Singleton
Ensure only one instance of a class exists.
🔹 Factory
Use factory constructors to control instantiation.
🔹 Builder
Useful for complex object creation.
🔹 Dependency Injection
Make your classes independent and testable. Use packages like get_it.
🔹 Observer
You can implement the observer pattern manually or use Stream/ChangeNotifier.

🌟 Bonus Dart OOP Features
Feature
Description
Extension Methods
Add functionality to classes without editing them
Named Constructors
Create multiple ways to initialize a class
Cascade Notation (..)
Chain multiple methods on the same object
Const Constructors
Optimize constant values
Operator Overloading
Redefine operators like +, ==, etc.
Collection If / Spread
Concise initialization of lists/maps




