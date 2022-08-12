abstract class AddUserEvent {}

class AddUserButtonEvent extends AddUserEvent {
  final String? username;
  final String? address;

  AddUserButtonEvent(this.username, this.address);
}
