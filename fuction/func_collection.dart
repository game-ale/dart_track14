//🔸 Function Without Parameters
// Functions can be defined without parameters and can return a value or not.
void welcome() {
  print('Welcome to Dart!');
}
// 🔸 Function With Parameters
void great(String name){
  print("Hello, $name!");
}
// 🔸 Function With Return Value

String fullName(String first, String last){
  return '$first $last';
}
// 🔸 Function With Optional Parameters
// one line fuction
int square(int x) => x * x;

void printName(String name) => print('Name: $name');
// Functions can have optional parameters, which can be positional or named.
/*🔸 Anonymous Functions (Lambdas)
Functions without names. Useful in callbacks or higher-order functions.*/

var list = [1, 2, 3];
list.forEach((num) {
  print(num);
});

// 0ptional fuction 
void greet(String name, [int? age]) {
  print('Hello $name, age: ${age ?? 'unknown'}');
}

greet('Gemechu');         // age: unknown
greet('Gemechu', 30);     // age: 30

//1. Anonymous Functions
var numbers = [1, 2, 3, 4, 5];
numbers.forEach(num)=>print(num*2);

