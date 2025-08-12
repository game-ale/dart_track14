1️⃣ What Are Data Sources?
Definition:
Data Sources are classes (or modules) responsible for 
```
fetching, 
saving,
 and updating
 ```
*** raw data *** from an external system (API, local DB, file storage, cache, ***device sensors,*** etc.).

In Clean Architecture:

Remote Data Source → Talks to network APIs (***REST, GraphQL, gRPC, Firebase, etc.).***

Local Data Source → Talks to persistent storage ***(SQLite, Hive, SharedPreferences, Secure Storage, etc.).***

Important:

##### ***NOtice ***

Data sources are not aware of Entities or Use Cases. ***They work with raw models (DTOs).***



3️⃣ How Do They Work?
Data sources follow these rules:

### 1) Have clear contracts (interfaces/abstract classes).

### 2) Return raw models (DTOs), not entities.

### 3) Do NOT handle business rules — just CRUD.

Notice

### 4) Throw exceptions (***don’t convert them into Failures ***here — that’s the repo’s job).

### 5) Keep them stateless (no caching inside unless specifically a cache data source).

4️⃣ Example Flow
When a Use Case needs data:


UseCase → Repository → DataSource → API/DB
For example:

Use Case: GetProductDetails

Repository: Decides whether to call Remote or Local data source.

Data Source: Actually hits GET /products/{id} or reads SQLite.

5️⃣ Best Practices
✅ Separate Remote & Local clearly — never mix both in one file.

✅ Interface first — ensures ***testability & flexibility.***

✅ ***One data source*** per “kind of data” — don’t make **giant** classes.

✅ Use DTOs — keep entities away from the data layer.

✅ Fail Fast — ***throw exceptions when something goes wrong.***

✅ Keep dependencies ***low*** — only import what’s needed (http, sqflite, etc.).

6️⃣ Common Mistakes
❌ ***Returning Entities*** from Data Sources — breaks the separation of concerns.

❌ Mixing remote and local logic — makes testing & maintenance harder.

NB

❌ ***Catching exceptions here*** — let the repository handle mapping exceptions to Failures.

❌ ***Putting business logic here*** — Data Sources should be dumb “data fetchers/savers.”

❌ Overengineering — you don’t need 3 layers of abstraction for a simple SQLite read.







2. What They Are NOT
```
They aren’t responsible for deciding what the app should do with data.

They shouldn’t convert entities → models or models → entities (that’s done in the repository layer).

They shouldn’t handle UI state.

```

#### 4. Why Separate Remote & Local
Remote Data Source → API calls (e.g., Dio, http, Chopper).

Local Data Source → Persistent storage (e.g., Hive, SharedPreferences, Sqflite).

***They have different error handling, different dependencies, and different test strategies.***



}
🛠 Best Practices

```
Keep it Pure — only talk to one data source type (remote OR local) per class.

No Entity Conversion — Data Sources should only handle Models, not Entities.

Use Dependency Injection — pass Dio, Box, etc. from outside.

Error Handling — wrap API/database calls with try-catch, throw custom exceptions.

Testability — always depend on abstract classes in repository implementations so you can mock data sources in tests.

Avoid Logic — business rules belong in Use Cases, not here.

```

🚨 Common Mistakes

### ❌ Mixing remote & local logic in one class.

### ❌ Returning raw JSON directly to the repository (should return models).

### ❌ Handling UI state (e.g., loading flags) inside data sources.

### ❌ Hardcoding API URLs or database keys inside multiple methods — use constants.

