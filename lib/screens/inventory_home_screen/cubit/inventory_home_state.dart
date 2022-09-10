part of 'inventory_home_cubit.dart';

abstract class InventoryHomeState {
  const InventoryHomeState();
}

class InventoryInititalState extends InventoryHomeState {
  final String message;
  InventoryInititalState({required this.message});
}

class LoadInventoryDataState extends InventoryHomeState {
  final List<ProductModel> products;
  const LoadInventoryDataState({required this.products});
}

class ProductInStockState extends InventoryHomeState {
  final String message;
  ProductInStockState(this.message);
}

class ProductOutOfStockState extends InventoryHomeState {
  final String message;
  final IconData iconData;
  final Color color;
  ProductOutOfStockState(this.message, this.iconData, this.color);
}

class ProductFoundState extends InventoryHomeState {
  final List<ProductModel> products;
  const ProductFoundState({required this.products});
}

class ProductNotFoundState extends InventoryHomeState {
  final String message;
  const ProductNotFoundState({required this.message});
}
