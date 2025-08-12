***These implementations coordinate between data sources (remote, local, cache) and transform data models into entities.***

Think of it like:

### ***How to Implement a Repository***

Here’s the step-by-step flow:

Step 1: Start from the Domain Layer
Look at your ***abstract class ProductRepository.***

Each method signature there ***must be implemented***in the data layer.


Inject data sources as dependencies.

Example:

```
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  ```

```
  @override
  Future<Product> getProduct(String id) async {
    try {
      // Try local first
      final localProduct = await localDataSource.getProduct(id);
      if (localProduct != null) return localProduct;

      // Fallback to remote
      final remoteProduct = await remoteDataSource.getProduct(id);
      
      // Cache for next time
      await localDataSource.cacheProduct(remoteProduct);
      
      return remoteProduct;
    } catch (e) {
      throw RepositoryException("Failed to get product", e);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final remoteProducts = await remoteDataSource.getAllProducts();
    await localDataSource.cacheProducts(remoteProducts);
    return remoteProducts;
  }

  @override
  Future<void> createProduct(Product product) {
    return remoteDataSource.createProduct(product);
  }
}

```
3. Where Does it Go?

4. Common Mistakes & How to Avoid Them

❌ Mistake 1: ***Putting API*** code directly in the repository

✅ Fix: Keep HTTP, Firebase, or DB calls inside ***data sources***, not the repo. The repo just coordinates.

❌ Mistake 2: ***Returning***  models instead of ***entities***

✅ Fix: Always map models → entities before returning to domain/use cases.

❌ Mistake 3: ***Ignoring caching strategies***

✅ Fix: Use localDataSource as a first stop if the data is already stored.

❌ Mistake 4: ***No proper error handling***

✅ Fix: Catch exceptions in repo, throw domain-friendly errors (not ***SocketException or DioError directly***).

❌ Mistake 5: Mixing responsibilities

✅ Fix: Repo shouldn’t ***format UI strings,*** sort data for display, or know about widgets.

5. Pro Tips
💡 Tip 1: Make your repositories return ***Either<Failure, T> or Result<T>*** for predictable error handling.

💡 Tip 2: ***Inject dependencies***  via constructor so you can easily mock for ***unit testing.***

💡 Tip 3: If the repository is big, ***split into multiple smaller repos*** for different contexts.

💡 Tip 4: If you use caching, implement sync logic — so local and remote stay in ***sync.***

💡 Tip 5: Keep all transformations between Entity ↔ Model inside ***the model class to keep repo code clean***.




1️⃣ How


***It fetches or stores data using:***

### Remote Data Source (API, Firebase, etc.)

### Local Data Source (SQLite, Hive, SharedPrefs, etc.)

### It maps raw data models ↔ domain entities.



4️⃣ Common Mistakes
❌ Mixing domain and data layer — Don’t return ProductModel to domain, always map to Product entity.

❌ Direct API calls in use cases — The repository should handle it, not the use case.

❌ No exception mapping — If API fails, you must convert it into a Failure type, not throw raw exceptions.

❌ Skipping local caching — Many beginners forget offline-first approaches.

❌ Overloading the repository — Keep it lean; complex orchestration can go into a separate service.



6️⃣ Extra Best Practices
Mapping methods in model:

```

Product toEntity() => 
Product(id: id, 
name: name, price: price);


static ProductModel fromEntity(
    Product entity) =>
    ProductModel(id: entity.id, name: entity.name, 
    price: entity.price);

```

Error handling — ***Always convert*** exceptions into Failure objects.

Unit tests — ***Mock remoteDataSource & localDataSource to ensure repository logic is correct.***

Offline-first strategy — ***Try local first, then remote if online.***

Dependency injection — ***Inject all data sources & network info via constructors.***