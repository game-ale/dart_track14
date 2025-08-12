class Person {
  String _name = ""; // Private field (underscore makes it library-private)

  // Getter
  String get name => _name;

  // Setter
  set name(String value) {
    if (value.isEmpty) {
      throw Exception("Name cannot be empty");
    }
    _name = value;
  }
}

void main() {
  var person = Person();

  // Using setter
  person.name = "Gemechu"; // Works
  // person.name = ""; // Throws exception

  // Using getter
  print(person.name); // "Gemechu"
}
