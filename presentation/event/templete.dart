import 'package:equatable/equatable.dart';

/// Base class for all Product BLoC events.
/// Keeps them immutable and comparable.
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

// ========================
// 🔹 READ / LOAD EVENTS
// ========================

/// Load initial list of products
class LoadProducts extends ProductEvent {
  final bool fromCache; // true = local first, false = API first

  const LoadProducts({this.fromCache = false});

  @override
  List<Object?> get props => [fromCache];
}

/// Load next page for infinite scroll
class LoadMoreProducts extends ProductEvent {
  final int page;
  final int limit;

  const LoadMoreProducts({required this.page, this.limit = 20});

  @override
  List<Object?> get props => [page, limit];
}

/// Load single product detail
class LoadProductDetail extends ProductEvent {
  final String productId;

  const LoadProductDetail(this.productId);

  @override
  List<Object?> get props => [productId];
}

// ========================
// 🔹 CREATE EVENT
// ========================

/// Add a new product
class CreateProduct extends ProductEvent {
  final String name;
  final double price;
  final String description;

  const CreateProduct({
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props => [name, price, description];
}

// ========================
// 🔹 UPDATE EVENT
// ========================

/// Update an existing product
class UpdateProduct extends ProductEvent {
  final String productId;
  final String? name;
  final double? price;
  final String? description;

  const UpdateProduct({
    required this.productId,
    this.name,
    this.price,
    this.description,
  });

  @override
  List<Object?> get props => [productId, name, price, description];
}

// ========================
// 🔹 DELETE EVENT
// ========================

/// Remove a product
class DeleteProduct extends ProductEvent {
  final String productId;

  const DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}

// ========================
// 🔹 FILTER / SEARCH EVENTS
// ========================

/// Search products by keyword
class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

/// Filter products by criteria
class FilterProducts extends ProductEvent {
  final String category;
  final double? minPrice;
  final double? maxPrice;

  const FilterProducts({
    required this.category,
    this.minPrice,
    this.maxPrice,
  });

  @override
  List<Object?> get props => [category, minPrice, maxPrice];
}

// ========================
// 🔹 OTHER EVENTS
// ========================

/// Refresh the entire list
class RefreshProducts extends ProductEvent {
  const RefreshProducts();
}

/// Retry last failed request
class RetryLastAction extends ProductEvent {
  const RetryLastAction();
}

/// Listen for realtime product updates (optional WebSocket/Stream)
class SubscribeToProductUpdates extends ProductEvent {
  const SubscribeToProductUpdates();
}
