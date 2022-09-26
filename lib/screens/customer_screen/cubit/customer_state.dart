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
  final List<Customer> users;
  const LoadCustomersState({required this.users});

  @override
  List<Object> get props => [users];
}

class CustomerFoundState extends CustomerState {
  final List<Customer> searchUser;
  const CustomerFoundState({required this.searchUser});

  @override
  List<Object> get props => [searchUser];
}

class CustomerNotFoundState extends CustomerState {
  final String message;
  const CustomerNotFoundState(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerLoadingState extends CustomerState {}
