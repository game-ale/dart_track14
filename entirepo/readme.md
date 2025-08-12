📦 Entities & Repositories in Clean Architecture

***Repository = “The boundary between my pure business logic and the outside world”***

In Clean Architecture:


### Repositories (contracts): Abstract definitions of data access (live in domain/repositories)

***Repository implementations: Concrete classes fetching/storing (live in data/repositories)***

3️⃣ What Repositories Are
Interfaces (abstract classes) in the domain layer

Define what the domain can do, ***not how***

Accept and ***return entities*** or ***simple value types**


```
Entities + Repository contracts = domain layer

Implementations + API/DB logic = data layer

```
6️⃣ Common Mistakes
❌ 1. Returning API Models from Repository Contracts
Bad:
```
Future<List<ProductModel>> getAllProducts();
```
Why it’s bad:

Leaks the data layer into the domain

If the API changes, your whole domain breaks

❌ 2. Putting Repository Implementations in Domain Layer


❌ 3. Mixing UI/Framework Code in Entities
Bad:

```
class Product {
  final String name;
  final TextStyle style; // UI detail
}
```
Why it’s bad:

#### ***Entities become useless for business rules outside Flutter***

❌ 4. Making Repositories “Manager Classes”
Bad:

```
abstract class Repository {
  Future getData();

}

```
Why it’s bad:

***One repo shouldn’t know about everything — make them specific per aggregate/entity type***

7️⃣ Best Practices

✅ One repository per aggregate root (e.g., ProductRepository, UserRepository)

✅ Return entities, not data models from contracts

✅ Make entities immutable

✅ Use mappers to convert between models ↔ entities

✅ Keep repository interfaces clean & focused

✅ Name contracts after the entity they serve (not “DataRepo”)

***8️⃣ Extra Tips from Experience***

If you’re unsure whether something belongs in the repository:

***ask five questions:***

Ask: “Would the **domain care** about this?” If yes → keep it in **contract**

Ask: “Does this involve knowing the ***database or API?***” If yes → it belongs in implementation

You can use multiple data sources in one repository (remote + local)

Use ***interfaces everywhere*** in domain to maximize testability

***Keep mapping code out of use cases*** — that belongs in the data layer

