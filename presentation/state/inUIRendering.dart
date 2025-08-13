BlocBuilder<ProductBloc, UiState<List<ProductEntity>>>(
  builder: (context, state) {
    if (state.isLoading) return const CircularProgressIndicator();
    if (state.errorMessage != null) return Text(state.errorMessage!);
    if (state.isEmpty) return const Text("No products available");
    return ListView.builder(
      itemCount: state.data!.length,
      itemBuilder: (_, i) => Text(state.data![i].name),
    );
  },
)
