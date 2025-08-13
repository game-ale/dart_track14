class ProductBloc extends Bloc<ProductEvent, UiState<List<ProductEntity>>> {
  final GetProductsUseCase getProducts;

  ProductBloc(this.getProducts) : super(UiState.initial()) {
    on<LoadProducts>((event, emit) async {
      emit(UiState.loading());
      final result = await getProducts();
      result.fold(
        (failure) => emit(UiState.error(failure.message)),
        (products) => emit(UiState.success(products)),
      );
    });
  }
}
