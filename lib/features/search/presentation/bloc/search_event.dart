part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {
  const SearchEvent();
}

final class ProductSubscriptionRequestedEvent extends SearchEvent {
  const ProductSubscriptionRequestedEvent();
}



final class BrandsSubscriptionRequestedEvent extends SearchEvent {
  const BrandsSubscriptionRequestedEvent();
}

final class SizeSubscriptionRequestedEvent extends SearchEvent {
  const SizeSubscriptionRequestedEvent();
}

final class ColorSubscriptionRequestedEvent extends SearchEvent {
  const ColorSubscriptionRequestedEvent();
}

final class AppliedFilterCountSubscriptionRequestedEvent extends SearchEvent {
  const AppliedFilterCountSubscriptionRequestedEvent();
}



final class SearchActionEvent extends SearchEvent {
  final String query;

  const SearchActionEvent({required this.query});
}

final class ToggleBrandActionEvent extends SearchEvent {
  final String brand;

  const ToggleBrandActionEvent({required this.brand});
}

final class ToggleSizeActionEvent extends SearchEvent {
  final String size;

  const ToggleSizeActionEvent({required this.size});
}
final class ToggleColorActionEvent extends SearchEvent {
  final String color;

  const ToggleColorActionEvent({required this.color});
}
final class ResetFilterActionEvent extends SearchEvent {


  const ResetFilterActionEvent();
}