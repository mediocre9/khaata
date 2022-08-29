part of 'add_item_cubit.dart';

abstract class AddItemState {
  const AddItemState();
}

class AddItemInitial extends AddItemState {
  AddItemInitial();
}

class ItemAddedState extends AddItemState {
  final String message;
  final Color color;

  ItemAddedState(this.message, this.color);
}

class ItemNotAddedState extends AddItemState {
  final String message;
  final Color color;

  ItemNotAddedState(this.message, this.color);
}
