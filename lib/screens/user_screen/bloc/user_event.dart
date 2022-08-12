abstract class UserEvent {}

class SearchEvent extends UserEvent {
  final String? searchParam;

  SearchEvent(this.searchParam);
}
