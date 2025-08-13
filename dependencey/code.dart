// lib/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/data/datasources/remote_data_source.dart';
import 'features/products/data/datasources/local_data_source.dart';

import 'core/network/network_info.dart';
import 'core/utils/app_config.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! --------------------------
  //! Blocs / Cubits
  //! --------------------------
  sl.registerFactory(
    () => ProductBloc(
      getProducts: sl(),
      refreshProducts: sl(), // example: multiple use cases
    ),
  );

  //! --------------------------
  //! Use Cases
  //! --------------------------
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => RefreshProducts(sl())); // example

  //! --------------------------
  //! Repositories
  //! --------------------------
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! --------------------------
  //! Data Sources
  //! --------------------------
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! --------------------------
  //! Core
  //! --------------------------
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //! --------------------------
  //! External Dependencies
  //! --------------------------
  sl.registerLazySingleton(() => http.Client());

  // Example: SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Example: App Config (singleton for global config)
  sl.registerSingleton(AppConfig(env: 'production'));
}
