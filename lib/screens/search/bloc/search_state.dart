part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class Loading extends SearchState {}

class SearchDataFetched extends SearchState {
  final List<Product> products;

  SearchDataFetched(this.products);
}

class Failure extends SearchState {}