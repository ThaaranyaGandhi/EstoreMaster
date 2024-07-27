part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class Search extends SearchEvent{
  final String keyword;
  
  Search({required this.keyword});
}