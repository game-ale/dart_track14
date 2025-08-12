UI States in Clean Architecture
1. What They Are
UI State is a representation of what the ***UI should look like at any moment in time.***

It’s a snapshot of *** all the data and UI conditions*** (loading, success, error, empty, etc.) for a specific screen or widget.

Think of it like a ***blueprint for your screen*** — if you know the state, ***you know exactly what to render.***

2. Why We Use Them

***Predictable rendering → UI updates happen only when the state changes.***

Easier testing → You can test UI without actually running the app.

Separation of concerns → UI doesn’t decide what the state is; business logic does.

Less UI bugs → All possible UI conditions are explicitly defined.

3. Where They Live
In Flutter with BLoC, Cubit, or Riverpod, states live inside the presentation layer (usually in the bloc/ or state/ folder).

Example folder:

markdown
Copy
Edit
lib/
  presentation/
    bloc/
      product/
        product_state.dart
        product_bloc.dart
4. Common UI State Patterns
You generally model UI states in one of two ways:

A. Multiple Classes (sealed states pattern)
Each UI condition is a separate class.

dart
Copy
Edit
sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
✅ Pros:

Very clear for simple flows.

Easy to debug — type tells you exactly the state.

❌ Cons:

Can get repetitive for complex screens with many small changes.

B. Single Immutable Class (copyWith pattern)
One class contains all possible state variables, and you update only what changes.

dart
Copy
Edit
class ProductState {
  final bool isLoading;
  final List<ProductEntity> products;
  final String? error;

  const ProductState({
    this.isLoading = false,
    this.products = const [],
    this.error,
  });

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error,
    );
  }
}
✅ Pros:

Scales well for complex UIs.

Easy partial updates with copyWith.

❌ Cons:

Slightly harder to read at first compared to multiple classes.

5. Common Mistakes
Mixing state with events → Events are triggers, states are results. Never confuse them.

Mutating state directly → Always create a new state object (immutability).

Not covering all scenarios → Forgetting "empty state" or "error state" causes UI gaps.

Overcomplicated states → Don’t store unnecessary data in state; only store what UI needs.

6. Best Practices
Keep it immutable — Use const constructors and copyWith.

Make all fields final — No mutating after creation.

Cover all UI possibilities — Loading, success, empty, error.

Use Equatable — For easy equality checks and efficient re-renders.

Don’t store logic in state — State is pure data, not functions.

💡 Best-of-the-Best UI State Template (copyWith + Equatable)

dart
Copy
Edit
import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final List<ProductEntity> products;
  final String? errorMessage;

  const ProductState({
    this.isLoading = false,
    this.products = const [],
    this.errorMessage,
  });

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    String? errorMessage,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, products, errorMessage];
}
If you want, in the next step we can go just as deep into UI Event