part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingStates extends SearchState {}

final class SearchSuccessStates extends SearchState {
  final SearchModel model;
  SearchSuccessStates(this.model);
}

final class SearchErrorStates extends SearchState {
  final String error;
  SearchErrorStates(this.error);
}
