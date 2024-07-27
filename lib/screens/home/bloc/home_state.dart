part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class MainDataFetched extends HomeState {
  final List<banner.Banner> banners;
  final List<Category> categories;
  final List<Product> products;
  final MainData mainData;

  MainDataFetched({
    required this.banners,
    required this.categories,
    required this.mainData,
    required this.products
  });
}

class Failure extends HomeState {}