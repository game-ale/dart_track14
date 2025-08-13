import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'product_event.dart';
import 'product_state.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';
import '../../domain/usecases/filter_products_usecase.dart';

/// Central BLoC handling all product-related logic.
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUseCase getAllProducts;
  final GetProductUseCase getProduct;
  final CreateProductUseCase createProduct;
  final UpdateProductUseCase updateProduct;
  final DeleteProductUseCase deleteProduct;
  final SearchProductsUseCase searchProducts;
  final FilterProductsUseCase filterProducts;

  ProductBloc({
    required this.getAllProducts,
    required this.getProduct,
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.searchProducts,
    required this.filterProducts,
  }) : super(const ProductInitial()) {
    // Load products list
    on<LoadProducts>(_onLoadProducts);

    // Pagination
    on<LoadMoreProducts>(_onLoadMoreProducts);

    // Single product detail
    on<LoadProductDetail>(_onLoadProductDetail);

    // Create
    on<CreateProduct>(_onCreateProduct);

    // Update
    on<UpdateProduct>(_onUpdateProduct);

    // Delete
    on<DeleteProduct>(_onDeleteProduct);

    // Search
    on<SearchProducts>(_onSearchProducts);

    // Filter
    on<FilterProducts>(_onFilterProducts);

    // Refresh
    on<RefreshProducts>(_onRefreshProducts);

    // Retry
    on<RetryLastAction>(_onRetryLastAction);

    // Realtime (optional)
    on<SubscribeToProductUpdates>(_onSubscribeToProductUpdates);
  }

  // ===============================
  // Handlers for each event
  // ===============================

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final result = await getAllProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductListLoaded(products)),
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductListLoaded) {
      final current = (state as ProductListLoaded).products;
      emit(ProductListLoadingMore(current));
      final result = await getAllProducts(page: event.page, limit: event.limit);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(ProductListLoaded([...current, ...products])),
      );
    }
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final result = await getProduct(event.productId);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }

  Future<void> _onCreateProduct(
    CreateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final result = await createProduct(
      name: event.name,
      price: event.price,
      description: event.description,
    );
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) => add(const LoadProducts()),
    );
  }

  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final result = await updateProduct(
      id: event.productId,
      name: event.name,
      price: event.price,
      description: event.description,
    );
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) => add(LoadProductDetail(event.productId)),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final result = await deleteProduct(event.productId);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) => add(const LoadProducts()),
    );
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final result = await searchProducts(event.query);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductListLoaded(products)),
    );
  }

  Future<void> _onFilterProducts(
    FilterProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final result = await filterProducts(
      category: event.category,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
    );
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductListLoaded(products)),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    add(const LoadProducts());
  }

  Future<void> _onRetryLastAction(
    RetryLastAction event,
    Emitter<ProductState> emit,
  ) async {
    // NOTE: Implement based on how you track the last event.
    // Could be storing the last ProductEvent and re-adding it here.
  }

  Future<void> _onSubscribeToProductUpdates(
    SubscribeToProductUpdates event,
    Emitter<ProductState> emit,
  ) async {
    // NOTE: Example for listening to a stream of updates
    // await for (final product in productUpdatesStream) {
    //   add(UpdateProduct(...));
    // }
  }
}
