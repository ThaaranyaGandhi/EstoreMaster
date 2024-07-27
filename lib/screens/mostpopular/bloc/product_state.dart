part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class Loading extends ProductState {}

class ProductsFetched extends ProductState {
  final List<Product> products;
  ProductsFetched(this.products);
}

class Failure extends ProductState {}