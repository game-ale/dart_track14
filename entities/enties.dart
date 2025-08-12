/// Entity: Represents a core business object in the domain layer.
/// Pure Dart — no framework imports (e.g., Flutter, http, sqflite)
/// Immutable — all fields are `final`
/// Equality and copy support for easy testing and state updates

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  /// Unique identifier for the product (e.g., UUID, database ID)
  final String id;

  /// Display name of the product
  final String name;

  /// Price in the default currency
  final double price;

  /// Short description of the product
  final String description;

  /// ISO 8601 date string for when the product was created
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
  });

  /// Creates a copy of this Product with some fields replaced
  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Used by Equatable to compare entities by value
  @override
  List<Object?> get props => [id, name, price, description, createdAt];
}
