
```
What events are

How they work in Clean Architecture

Where they live

How to design them for maintainability

Common mistakes

Best-of-the-best event template

```

1️⃣ What Are Events?
Events represent things that happen in the UI that trigger some action in your app.
They’re user intentions or system triggers.


Example:

```
User clicks "Login" → LoginRequested(username, password)

User scrolls to refresh → RefreshProducts()

App starts → AppStarted()

```

2️⃣ How They Work in Clean Architecture

In BLoC / Cubit architecture:

```
UI layer detects something happened → dispatches an event

BLoC listens for that event → calls Use Cases in the domain layer

The result is returned → BLoC emits a new State

```

Flow:

```
UI → Event → Bloc → UseCase → Repository → DataSource → Response → State → UI

```

4️⃣ How to Design Good Events

Golden Rules:

##### Events must be verbs → they represent actions, not things (LoadProducts, not ProductsLoaded)

##### Events should carry only the necessary data for the action

##### Keep them immutable (use const and final)

##### Use Equatable for value comparison in tests

##### Name them clearly so future you knows what they do

5️⃣ Common Mistakes
##### 🚫 Mixing events and states — events trigger actions, states describe results.
##### 🚫 Too generic events like ButtonClicked — be specific, e.g., SubmitOrder.
##### 🚫 No parameters when needed — LoginRequested without username/password is useless.
##### 🚫 Adding business logic to events — events are dumb, logic stays in the BLoC.

8️⃣ Best Practices Recap
##### ✅ Keep events clean and specific
##### ✅ Use Equatable for comparison
##### ✅ Always carry needed parameters
##### ✅ No logic inside events
##### ✅ Group events logically per BLoC



Here’s the ultimate events template that covers:

```
CRUD (Create, Read, Update, Delete)

Filtering & Searching

Pagination & Refreshing

Local & Remote loading

Error retry

Form submission

Realtime updates (optional)

```


🔥 Why this is “Best of Best”

```
Covers all core scenarios — CRUD, search, filter, pagination, refresh, retry, realtime.

Flexible parameters — e.g., optional fields in UpdateProduct so you can send partial updates.

Immutable + Comparable — using const + Equatable.

Extensible — adding new events won’t break the existing structure.

Separation of concerns — events only describe “what happened”, no logic.

```

