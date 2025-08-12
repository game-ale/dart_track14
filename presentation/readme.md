📌 Presentation Layer Steps (Best Order)
1️⃣ Define UI States & Events
What: Decide what states your UI can be in ***(loading, error, data loaded, empty, etc.)*** and what events trigger changes.

Why: ***This creates clarity before writing any UI code.***


2️⃣ Create State Management (BLoC / Cubit / Riverpod / Provider)
What: A controller that ***reacts to events, calls Use Cases from the domain layer, and emits states***.

#### ***Why: Keeps business logic away from widgets.***



Example Flow:

```
User taps login button → Event is fired.

BLoC receives event → Calls use case.

Emits LoadingState → Emits SuccessState or ErrorState.

```

3️⃣ Connect to Use Cases
What: The presentation layer never directly touches repositories or data sources—only use cases.

Why: Keeps dependency direction correct.

Where: Inside the BLoC’s mapEventToState() or on<Event>() handlers.

Example:


4️⃣ Build UI Widgets
What: The visual part of your app—stateless & stateful widgets.

Why: Widgets should only display data, not process it.

Where: presentation/pages/ or presentation/widgets/.

Tip: Keep them dumb—pass data from state management into widgets.

5️⃣ Listen & React to States
What: The UI observes the BLoC/Cubit and reacts to changes in state.

Why: Makes your UI automatically refresh when the data changes.

```
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) return CircularProgressIndicator();
    if (state is AuthError) return Text(state.message);
    if (state is AuthAuthenticated) return HomePage();
    return LoginPage();
  },
)

```

6️⃣ Handle Navigation
What: Move between screens when states change.

Where: Use BlocListener or Navigator in response to state changes.

```
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  },
  child: LoginForm(),
)

```
7️⃣ Error & Loading Handling
### Show consistent loading ***spinners, error snackbars, and empty states.***

Extract into reusable widgets.

⚠️ Common Mistakes to Avoid
❌ Putting business logic in widgets → ***Should be in BLoC/Controller.***

❌ Directly calling repositories from UI → ***Always go through Use Cases.***

❌ Massive Widgets → Break them into ***smaller components.***

❌ Hardcoding navigation logic everywhere → ***Centralize it if possible.***

❌ Ignoring error states → ***Every UI should handle errors gracefully.***

✅ Golden Rule:

```
UI should only render states and dispatch events.
Business logic lives in BLoC/Cubit, data fetching in Use Cases, and raw data handling in the Data Layer.

```

