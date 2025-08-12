import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../core/errors/failures.dart';

/// Abstract base class for use cases that return a result of type [T]
/// and accept parameters of type [Params].
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Example parameter class for GetProduct use case.
class GetProductParams {
  final String id;

  GetProductParams(this.id);
}

/// Example concrete use case for getting a product by ID.
class GetProduct implements UseCase<Product, GetProductParams> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(GetProductParams params) async {
    if (params.id.isEmpty) {
      return Left(InvalidInputFailure());
    }
    try {
      final product = await repository.getProduct(params.id);
      return Right(product);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

/// Failure classes for error handling.
abstract class Failure {}

class InvalidInputFailure extends Failure {}

class ServerFailure extends Failure {}
