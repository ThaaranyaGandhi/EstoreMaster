import 'package:bloc/bloc.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/global.dart';
import 'package:fresh_store_ui/network/models/order_history.dart';
import 'package:fresh_store_ui/network/models/order_product.dart';
import 'package:fresh_store_ui/network/services/order_service.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderHistory>(_onOrderHistory);
    on<CancelOrder>(_onCancelOrder);
    on<CreateOrder>(_onCreateOrder);
  }


  void _onCreateOrder(CreateOrder event, Emitter emit)async{

    emit(Loading());
    try{
      var response = await OrderService().createOrder(
        ddate: event.ddate,
        addressId: event.addressId,
        total: event.total,
        products: event.products, ordertype: 'Cash On Delivery',
          
      );
      Global.myCartItems.value = [];
      emit(OrderCreated());
    }catch(e){
      emit(Failed());

    }

  }

  void _onOrderHistory(OrderHistory event, Emitter emit)async{

    emit(Loading());
    try{

      var response = await OrderService().orderHistory(LocalDB.getUserid());
      var history = (response["Data"] as List).map((e) => OrderHistoryModel.fromMap(e)).toList();
      emit(OrderHistoryFetched(history));
    }catch(e){
      emit(Failed());

    }

  }

  void _onCancelOrder(CancelOrder event, Emitter emit)async{

    emit(Loading());
    try{

      await OrderService().cancelOrder("1", event.oid);
      add(OrderHistory());
    }catch(e){
      emit(Failed());

    }

  }
}
