part of 'inventory_cubit.dart';

abstract class InventoryState {
  const InventoryState();
}

class InventoryInititalState extends InventoryState {
  final String message;
  InventoryInititalState({required this.message});
}

class LoadInventoryDataState extends InventoryState {
  final List<Product> products;
  const LoadInventoryDataState({required this.products});
}

class ProductInStockState extends InventoryState {
  final String message;
  ProductInStockState(this.message);
}

class ProductOutOfStockState extends InventoryState {
  final String message;
  final IconData iconData;
  final Color color;
  ProductOutOfStockState(this.message, this.iconData, this.color);
}

class ProductFoundState extends InventoryState {
  final List<Product> products;
  const ProductFoundState({required this.products});
}

class ProductNotFoundState extends InventoryState {
  final String message;
  const ProductNotFoundState({required this.message});
}
