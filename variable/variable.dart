/* Declaring Variables*/

void main() {
  // Declaring a variable
  var name = 'John Doe';
  print(name);

  // Reassigning a variable
  name = 'Jane Doe';
  print(name);

  // Declaring a constant
  const pi = 3.14;
  print(pi);

  // Using final for a variable that can only be set once
  final currentYear = DateTime.now().year;
  print(currentYear);
}

//dynamic and var are similar, but dynamic can change type at runtime
// var is statically typed, meaning its type is determined at compile time
// code of them
void dynamicExample() {
  dynamic variable = 'Hello';
  print(variable); // Output: Hello

  variable = 42; // Changing type to int
  print(variable); // Output: 42

  variable = true; // Changing type to bool
  print(variable); // Output: true
}

void varExample() {
  var variable = 'Hello';
  print(variable); // Output: Hello

  // variable = 42; // This will cause an error because 'var' is statically typed
  // print(variable); // Uncommenting this line will cause a compile-time error

  variable = 'World'; // Reassigning to a new string value
  print(variable); // Output: World
}
//✅ Using final and const (Immutable Variables)

void finalConstExample() {
  final name = 'Alice'; // Can be set once
  print(name);

  // name = 'Bob'; // Uncommenting this line will cause an error

  const pi = 3.14; // Compile-time constant
  print(pi);

  // pi = 3.14159; // Uncommenting this line will cause an error
}

//✅ Using late for lazy initialization

void lateExample() {
  late String descripstion;
  descripstion = 'This is a late initialized variable.';
  print(descripstion);
}

/*declaration list,map,set,runes,sympol*/
void decrationListExample() {
  // List declaration
  List<String> fruits = ["Apple", "Banana", "Cherry"];
  print(fruits);
}

void mapExample() {
  // Map declaration
  Map<String, int> ages = {"Alice": 30, "Bob": 25, "Charlie": 35};
  print(ages);
}

void setExample() {
  // Set declaration
  Set<String> colors = {"Red", "Green", "Blue"};
  print(colors);
}

// Null Safety
void nullSafetyExample() {
  String name = 'Bob'; // Cannot be null
  String? nickname = null; // Nullable
  print(nickname?.length); // Safe access
  print(nickname ?? 'No name'); // Default value
  int? age; // Nullable integer
  age ??= 18; // If age is null, assign 18
  print(age); // Output: 18
}

// Using Symbols
void symbolsExample() {
  Symbol symbol1 = #mySymbol;
  Symbol symbol2 = #anotherSymbol;
  print(symbol1); // Output: Symbol(mySymbol)
  print(symbol2); // Output: Symbol(anotherSymbol)
}

// Using Runes
void runesExample() {
  String str = 'Hello, world!';
  Runes runes = str.runes; // Convert string to runes
  for (var rune in runes) {
    print(String.fromCharCode(rune)); // Print each character
  }
}
