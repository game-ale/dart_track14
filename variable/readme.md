** variable naming rule **
##String userName;
int _counter;
var $price;

***🔹 8. Const vs Final vs Var vs Dynamic ***

|Keyword | Can Reassign? | Type Fixed?|Constant?           |
|--------|---------------|------------|--------------------|
|var     | ✅ Yes       |✅ Yes      |❌ No               |
|final   | ❌ No        |✅ Yes      |✅ Runtime const
|const   | ❌ No        |✅ Yes      |✅ Compile const
|dynamic | ✅ Yes	   |❌ No	   |❌ No

***🔹 9. Tips & Tricks***
#**🎯 Tip 1: Prefer final for unchanging values**
```
final name = 'Gemechu'; // Safer and more readable
```
#**🎯 Tip 2: Avoid dynamic unless necessary**

**🎯 Tip 3: Use late only when you're sure it will be initialized**
```
late final String config; // Use with care!
```
#**🎯 Tip 4: Use null-aware operators to prevent crashes**
```
String? name;
print(name ?? 'Default'); // Output: Default
```

#**🎯 Tip 5: Use var for short-term readability, but prefer explicit types for APIs and models.**
##** 10. Example Class with Variables**
```
class User {
  final String name;
  int age;
  late String address;

  User(this.name, this.age);

  void setAddress(String addr) {
    address = addr;
  }
}
```
###***🔹 11. Shadowing Variables (Be Careful)***
```
void main() {
  int x = 10;
  {
    int x = 20; // Shadows outer x
    print(x);   // 20
  }
  print(x);     // 10
}
````
##**🔹 12. Constant Collections**
```
const List<int> numbers = [1, 2, 3];
const Map<String, String> countries = {'ET': 'Ethiopia'};
```
🧠 Summary
***Concept	        Keyword	        Usage***
Mutable	        var, dynamic	Changeable values
Immutable	    final, const	Fixed values
Lazy Init	    late	        Postpone initialization
Nullable	    String?	        May be null
***Type Inference	var	            Let Dart guess the type***
