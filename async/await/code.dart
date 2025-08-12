import 'dart:async';

// Simulated network call
Future<String> fetchProductFromServer() async {
  print("⏳ Fetching product...");
  await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  return "Laptop";
}

// Simulated data processing
Future<String> processProduct(String product) async {
  print("🔄 Processing product...");
  await Future.delayed(Duration(seconds: 1)); // Simulate work
  return product.toUpperCase();
}

// Main flow using async/await
Future<void> main() async {
  try {
    print("🚀 Start");

    // Step 1: Fetch product
    String product = await fetchProductFromServer();
    print("✅ Product fetched: $product");

    // Step 2: Process product
    String processed = await processProduct(product);
    print("✨ Processed product: $processed");

    print("🏁 Done");
  } catch (e) {
    print("❌ Error: $e");
  }
}
