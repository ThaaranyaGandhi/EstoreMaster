part of 'order_bloc.dart';

@immutable
class OrderEvent {}

class OrderHistory extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final String ddate;
  final String addressId;
  final String ordertype;
  final double total;
  final List<OrderProduct> products;

  CreateOrder({
    required this.ddate, 
    required this.addressId,
    required this.products,
    required this.total,
    required this.ordertype
  });
}

class CancelOrder extends OrderEvent {
  final String oid;
  CancelOrder({required this.oid});
}