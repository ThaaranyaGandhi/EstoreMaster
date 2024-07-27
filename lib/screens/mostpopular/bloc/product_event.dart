part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetProducts extends ProductEvent {
  final String cid;

  GetProducts({required this.cid});
}