part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  final List<Medication> medications;

  SearchState(this.medications);
}

class SearchArrived extends SearchState {
  SearchArrived() : super([]);
}

class SearchSearching extends SearchState {
  SearchSearching() : super([]);
}

class SearchComplete extends SearchState {
  SearchComplete(List<Medication> medications) : super(medications);
}

class SearchError extends SearchState {
  final Exception error;

  SearchError(this.error) : super([]);
}
