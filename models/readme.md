```
What models are (and how they differ from Entities)

Why they exist

Where they live in the architecture

How to create them

Common mistakes to avoid

Pro tips for production-ready models

```

1️⃣ What Models Are
In Clean Architecture, a Model is usually the ***data-layer representation of your domain Entity.***

### Entity → Pure business object (lives in domain/)

### Model → Entity + serialization/deserialization logic (lives in data/)

Think of Model as the bridge between:

### *External data sources (APIs, databases, local storage, etc.)*

### *Domain layer (pure business rules and entities)*

2️⃣ Why Models Exist
Entities don’t (and shouldn’t) know:

3 points i neeed to know

## How to ****parse** JSON from an API

## How to ***read/write*** from SQLite

## How to convert ***to/from DTOs***

If you tried to put all that into the entity, you’d break separation of concerns.
### ***Models protect your domain layer from knowing about external systems.***

Model → data/models/

4️⃣ How to Create Models
Step-by-Step
Start from the Entity

Your model will ***extend or implement*** the Entity.

## Add serialization methods

## fromJson(Map<String, dynamic> json)

## toJson()

## Keep immutability

## Use const constructors and final fields.

## Add copyWith (optional but useful for updates)


5️⃣ Common Mistakes to Avoid

❌ Mistake 1: Putting ***JSON parsing*** in the entity.

### ✅ Keep that in the model only.

❌ Mistake 2: Making models ***mutable*** (changing values directly).
### ✅ Always use final + copyWith for safety.


❌ Mistake 4: ***Not validating data from APIs.***

### ✅ Add null checks, type conversions, and fallbacks.

❌ Mistake 5: ***Tight coupling between API response keys and model field names.***
### ✅ Use constants for keys or mapping logic.

6️⃣ Pro Tips

💡 Tip 1: Use code ***generation***

json_serializable + freezed can make models easier to maintain.

💡 Tip 2: Make all model constructors const for ***immutability and performance.***

💡 Tip 3: Keep model → entity conversion in toEntity() ***if they differ.***

💡 Tip 4: Keep ***test coverage high for parsing logic*** (especially if API changes are frequent).

💡 Tip 5: Separate ***Remote Models and Local Models*** if their structures differ.

```
data/models/remote/product_remote_model.dart
data/models/local/product_local_model.dart

```

2. Golden Rules for Models

```
Immutable – Use final fields, no mutable state.

Conversion Ready – Must be able to convert:

From JSON (fromJson)

To JSON (toJson)

From Entity (fromEntity)

To Entity (toEntity)

No Business Logic – Only data mapping logic.

Self-Contained – Avoid direct dependency on Flutter widgets or UI code.

Serializable – Easy to store in local DB or send over the network.

```

3. Common Mistakes

#### ❌ Mixing business logic (calculations, validation) inside the model — keep that in use cases.

#### ❌ Forgetting entity mapping — causes tight coupling between layers.

#### ❌ Using non-nullable fields when API can send null — leads to crashes.

#### ❌ Not versioning models — breaking changes can crash the app when API changes.



```
5. Why This Template Is Best
✅ Immutable (final + const)
✅ Covers both local & remote data (toJson, fromJson)
✅ Maps between domain & data (fromEntity, toEntity)
✅ Safe nullable handling
✅ Copy-with method for partial updates
✅ No business logic — pure data transformation

```