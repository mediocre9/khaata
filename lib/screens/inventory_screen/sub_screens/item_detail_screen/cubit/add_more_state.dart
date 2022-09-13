part of 'add_more_cubit.dart';

abstract class AddMoreState extends Equatable {
  const AddMoreState();

  @override
  List<Object> get props => [];
}

class AddMoreInitial extends AddMoreState {}

class AddMoreToStockState extends AddMoreState {}

class DeleteProductFromInventoryState extends AddMoreState {}
