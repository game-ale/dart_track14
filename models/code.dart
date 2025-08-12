import 'package:meta/meta.dart';
import '../../domain/entities/product.dart';

@immutable
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl; // Nullable because API might not always send it

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
  });

  /// From JSON (Remote API)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// To JSON (Remote API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  /// From Entity (Domain Layer → Data Layer)
  factory ProductModel.fromEntity(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
    );
  }

  /// To Entity (Data Layer → Domain Layer)
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }

  /// Copy With (Immutable update)
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
