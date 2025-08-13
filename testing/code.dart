// lib/features/products/domain/usecases/get_product.dart
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Either<Failure, Product>> call(String id) async {
    if (id.isEmpty) {
      return Left(InvalidInputFailure());
    }
    return repository.getProductById(id);
  }
}





// test/features/products/domain/usecases/get_product_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:your_app/features/products/domain/entities/product.dart';
import 'package:your_app/features/products/domain/repositories/product_repository.dart';
import 'package:your_app/features/products/domain/usecases/get_product.dart';
import 'package:your_app/core/error/failures.dart';

// 1️⃣ Create Mock Class
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProduct usecase;
  late MockProductRepository mockRepository;

  // 2️⃣ Sample Data
  const tId = "123";
  const tProduct = Product(id: tId, name: "Coffee Mug", price: 10.0);

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProduct(mockRepository);
  });

  group('GetProduct UseCase', () {
    test('✅ should return Product when repository returns success', () async {
      // Arrange
      when(() => mockRepository.getProductById(tId))
          .thenAnswer((_) async => const Right(tProduct));

      // Act
      final result = await usecase(tId);

      // Assert
      expect(result, const Right(tProduct));
      verify(() => mockRepository.getProductById(tId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('✅ should return Failure when repository returns Failure', () async {
      // Arrange
      when(() => mockRepository.getProductById(tId))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act
      final result = await usecase(tId);

      // Assert
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(() => mockRepository.getProductById(tId)).called(1);
    });

    test('✅ should return InvalidInputFailure when id is empty', () async {
      // Act
      final result = await usecase("");

      // Assert
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => null), isA<InvalidInputFailure>());
      verifyZeroInteractions(mockRepository);
    });

    test('✅ should handle unexpected exceptions gracefully', () async {
      // Arrange
      when(() => mockRepository.getProductById(tId))
          .thenThrow(Exception("Unexpected"));

      // Act
      try {
        await usecase(tId);
        fail("Should have thrown Exception");
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
