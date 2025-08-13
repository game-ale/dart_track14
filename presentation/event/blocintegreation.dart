on<LoadProducts>((event, emit) async {
  emit(UiState.loading());
  final result = await getProducts(fromCache: event.fromCache);
  result.fold(
    (failure) => emit(UiState.error(failure.message)),
    (products) => emit(UiState.success(products)),
  );
});

on<CreateProduct>((event, emit) async {
  emit(UiState.loading());
  final result = await createProduct(
    name: event.name,
    price: event.price,
    description: event.description,
  );
  result.fold(
    (failure) => emit(UiState.error(failure.message)),
    (_) => add(const LoadProducts()), // reload after create
  );
});
