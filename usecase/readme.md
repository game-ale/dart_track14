
```

What Use Cases really are

Where they live & how they fit in

How to write them correctly

Common mistakes and how to avoid them

Best practices from experience

```


Advanced tips

1️⃣ What Use Cases Really Are
Application-specific business rules — they describe one thing your app can do.

They coordinate between the domain’s entities and repository interfaces.


***They don’t know about:***

```
UI

Databases

API endpoints

JSON serialization

```

***They do know about:***

```
Which repository to call

How to use Entities

```

💡 Think of them as “action scripts” for your app.
#### Example: GetUserProfile, SearchProducts, PlaceOrder




3️⃣ ***How to Write a Use Case***
A good use case:

### Has one clear responsibility (***Single Responsibility Principle***)

### Uses Dependency Injection to get the repository

### Has a ***call()*** method (so you can use it like a function)

### Returns Entities or Value Objects (***never raw API models***)

Example:

```
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getAllProducts();
  }
}

```
***With Parameters:***

```
class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<Product>> call(String query) async {
    if (query.isEmpty) throw ArgumentError('Query cannot be empty');
    return await repository.searchProducts(query);
  }
}

```

4️⃣ Common Mistakes
❌ 1. Putting API/DB Logic in Use Case
Bad:

```
Future<List<Product>> call() async {
  final response = await http.get(...); // 🚫 Wrong layer
}
```
### Fix: That goes in Repository Implementation in the data layer.

❌ ***2. Mixing Multiple Responsibilities***
Bad:

```
class Checkout {
  // Places order + sends email + logs event → too much!
}

```
***Fix: Split into PlaceOrder, SendOrderConfirmationEmail, LogOrderEvent.***


❌ 4. ***Making Them “ manager of Services”***
Bad:

```
class ProductService { // 🚫 vague name
  getAll() {}
  search() {}
  update() {}
}

```
### ***Fix: Make one use case per action.***

5️⃣ ***Best Practices***

```
✅ One use case = one action
✅ Keep them pure (no framework code, pure Dart)
✅ Parameterize them with simple types or value objects
✅ Test them in isolation (mock repositories)
✅ Return Either<Failure, Result> for clean error handling
✅ Name them with verbs (GetAllProducts, not ProductsGetter)

```

6️⃣ Advanced Tips
# **Async Everywhere**: Almost all use cases will be Future-based — plan for **async/await usage.**

# Functional Style: Use Either or Result types to avoid **try/catch soup.**

***Reusability***: A well-written use case can be reused across ***different UI platforms*** (Flutter mobile, Flutter web, CLI, etc.)

***NB***

## Parameter Object: If your use case takes more than 2–3 arguments, wrap them in a parameter class.


```

import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/errors/failures.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    try {
      final products = await repository.getAllProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

```

