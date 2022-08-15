abstract class ItemEvent {}

class AddItemButtonEvent extends ItemEvent {
  final String? name;
  final int? stock;
  final int? cost;

  AddItemButtonEvent(
    this.name,
    this.stock,
    this.cost,
  );
}
