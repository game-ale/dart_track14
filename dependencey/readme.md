1️⃣ What is Dependency Injection (DI)?
Definition:
Dependency Injection is the process of providing (injecting) an object’s dependencies from outside, instead of letting the object create them itself.

📌 Example without DI:

```
class CoffeeShop {
  final CoffeeMachine machine = CoffeeMachine(); // ❌ Direct creation
}
```
Here, CoffeeShop controls which coffee machine to use — making it hard to change or test.

📌 Example with DI:

```
class CoffeeShop {
  final CoffeeMachine machine;
  CoffeeShop(this.machine); // ✅ Injected from outside
}

```
Now, we can inject any kind of CoffeeMachine (mock, premium, cheap, etc.).

2️⃣ Why Do We Use DI?

#### Testability → We can pass mocks instead of real APIs.

#### Flexibility → Swap implementations without changing dependent code.

#### Decoupling → Classes don’t know how dependencies are made.

#### Maintainability → Changes in one layer don’t break others.

#### Reusability → Components can be reused with different dependencies.

3️⃣ Where Does DI Fit in Clean Architecture?
In Flutter Clean Architecture:

***Entities:*** No DI needed (pure logic).

Use Cases: Dependencies ***(repos)*** injected via constructor.

Repositories: ***Inject data sources*** (remote, local).

Data Sources: ***Inject API clients, DB clients,*** etc.

BLoC / Cubit: ***Inject use cases.***

Main App: ***Configures all injections.***

📌 The DI container is often set up in injection_container.dart or service_locator.dart.

4️⃣ How to Do DI in Flutter
Option 1 — Manual DI
Pass dependencies manually.

```
final repo = ProductRepositoryImpl(remote: remoteDataSource);
final usecase = GetProducts(repo);
final bloc = ProductBloc(usecase);

```

✅ Pros: Simple, explicit
❌ Cons: Messy in large apps

Option 2 — Service Locator (with get_it)
***get_it*** is the most popular DI library in Flutter.

```
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ProductBloc(getProducts: sl()));

  // Use case
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remote: sl()),
  );

  // Data source
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => HttpClient());
}

```

📌 Using DI in the app:

```
void main() async {
  await init();
  runApp(MyApp());
}

// Inject into UI
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>(),
      child: Container(),
    );
  }

}

```

5️⃣ Common DI Mistakes


Overusing the service locator everywhere
#### → ***Avoid calling sl<T>()*** inside business logic. Inject dependencies through constructors instead.

Putting DI logic in random places
#### → Always ***centralize DI setup*** (e.g., injection_container.dart).

#### Not separating registration types

#### registerFactory() → Creates new instance every time (good for BLoC).

#### registerLazySingleton() → Creates once, reused (good for repos, use cases).

#### registerSingleton() → Creates immediately & reuses.

Mixing UI creation & DI registration
#### → Set up all DI before runApp().

No cleanup in tests
#### → Always reset sl.reset() between test runs.



6️⃣ Best-of-the-Best DI Template for Clean Architecture

```
// injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/data/datasources/remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => ProductBloc(getProducts: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );

  // External libs
  sl.registerLazySingleton(() => http.Client());
}

```

7️⃣ Quick DI Lifecycle Guide

```
registerFactory → New instance each time (BLoC, Cubit).

registerLazySingleton → Create when first needed, then reuse (Repo, UseCase).

registerSingleton → Create immediately, reuse forever (AppConfig).

```

📌 Key Notes
1. ***Registration Types***
registerFactory() → Every time you ask for it, you get a new instance
✅ Use for BLoCs, Cubits (short-lived)

registerLazySingleton() → Create once when first needed, then reuse
✅ Use for Repositories, UseCases, DataSources (medium/long-lived)

registerSingleton() → Create immediately & reuse forever
✅ Use for global configs, constants, logging services

2. ***DI Setup Order***

### BLoCs at the top

### Use Cases next

### Repositories after that

### Data Sources (remote + local)

### Core utilities (e.g., NetworkInfo, Logger)

### External packages (http, shared prefs, DB, etc.)

3. Using DI in main.dart

```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // initialize DI
  runApp(MyApp());
}

```
4. Providing Dependencies to Widgets

```
class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(LoadProductsEvent()),
      child: ProductView(),
    );
  }
}

```

5. Common Mistakes to Avoid
❌ Injecting dependencies directly in methods
✅ Always inject through the constructor (even in BLoCs)

❌ Mixing registerSingleton with BLoCs
✅ Use registerFactory for BLoCs so they’re fresh each time

❌ Scattering DI code everywhere
✅ Keep it all in injection_container.dart

❌ Forgetting to reset in tests
✅ In tests:


```
setUp(() async {
  sl.reset();
  await init();
});

```