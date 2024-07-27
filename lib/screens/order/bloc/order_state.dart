part of 'order_bloc.dart';

@immutable
class OrderState {}

class OrderInitial extends OrderState {}

class Failed extends OrderState {}

class Loading extends OrderState {}

class OrderHistoryFetched extends OrderState {
  final List<OrderHistoryModel> history;
  OrderHistoryFetched(this.history);
}

class OrderCanceled extends OrderState {

}

class OrderCreated extends OrderState {}