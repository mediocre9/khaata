import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khata/constants.dart';
import 'package:khata/models/model/product_model.dart';
import 'package:khata/screens/add_item_screen/bloc/add_item_event.dart';

enum ItemState {
  initialState,
  validState,
  invalidState,
}

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemState.initialState) {
    onButtonPressed();
  }

  onButtonPressed() {
    on<AddItemButtonEvent>(
      (event, emit) {
        if (event.name.toString().isNotEmpty &&
            event.cost.toString().isNotEmpty &&
            event.stock.toString().isNotEmpty) {
          productBox?.add(ProductModel(
              name: event.name.toString(),
              initialStock: event.stock,
              cost: event.cost));
          emit(ItemState.validState);
        }
        emit(ItemState.invalidState);
      },
    );
  }
}
