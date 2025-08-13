import 'package:equatable/equatable.dart';

/// Generic base state that can be reused for different screens
class UiState<T> extends Equatable {
  /// Whether the UI is currently loading
  final bool isLoading;

  /// The data to display (nullable until loaded)
  final T? data;

  /// Optional error message for failures
  final String? errorMessage;

  /// Whether there's no data to show
  final bool isEmpty;

  const UiState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
    this.isEmpty = false,
  });

  /// Factory for the initial state
  factory UiState.initial() => const UiState();

  /// Factory for loading state
  factory UiState.loading() => const UiState(isLoading: true);

  /// Factory for success state with data
  factory UiState.success(T data) => UiState(
        data: data,
        isEmpty: _checkIfEmpty(data),
      );

  /// Factory for empty state
  factory UiState.empty() => const UiState(isEmpty: true);

  /// Factory for error state
  factory UiState.error(String message) => UiState(errorMessage: message);

  /// Create a copy with updated fields
  UiState<T> copyWith({
    bool? isLoading,
    T? data,
    String? errorMessage,
    bool? isEmpty,
  }) {
    return UiState<T>(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  /// Helper to detect "empty" automatically
  static bool _checkIfEmpty(dynamic data) {
    if (data == null) return true;
    if (data is Iterable || data is String || data is Map) {
      return (data as dynamic).isEmpty;
    }
    return false;
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage, isEmpty];
}
