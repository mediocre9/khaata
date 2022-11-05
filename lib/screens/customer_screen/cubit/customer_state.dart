part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitialState extends CustomerState {
  final String message;
  const CustomerInitialState(this.message);
}

class LoadCustomersState extends CustomerState {
  final List<Customer> customers;
  const LoadCustomersState({required this.customers});

  @override
  List<Object> get props => [customers];
}

class CustomerFoundState extends CustomerState {
  final List<Customer> searchResult;
  const CustomerFoundState({required this.searchResult});

  @override
  List<Object> get props => [searchResult];
}

class CustomerNotFoundState extends CustomerState {
  final String message;
  const CustomerNotFoundState(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerLoadingState extends CustomerState {}
