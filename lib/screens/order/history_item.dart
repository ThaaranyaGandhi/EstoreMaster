import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/network/models/order_history.dart';
import 'package:fresh_store_ui/screens/order/bloc/order_bloc.dart';

import '../../db/local_db.dart';
import '../InfoVIew.dart';

class HistoryItem extends StatelessWidget {
  final OrderHistoryModel history;
  const HistoryItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order ID: ${history.id}', style: const TextStyle(color: ColorsConst.text, fontSize: 16, fontWeight: FontWeight.w600)),
            Text(history.status, style: const TextStyle(color: ColorsConst.secondary, fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: Text('\$ ${history.total}', style: const TextStyle(color: ColorsConst.text, fontSize: 18, fontWeight: FontWeight.w600))),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // OutlinedButton(
                  //   style: ButtonStyle(
                  //     side: MaterialStateProperty.all(
                  //       const BorderSide(color: Colors.grey),
                  //     ),
                  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20.0), // Change the radius here
                  //       ),
                  //     ),
                  //   ),
                  //
                  //   onPressed: (){
                  //     context.read<OrderBloc>().add(CancelOrder(oid: history.oid));
                  //   }, child: const Text('Cancel', style: TextStyle(color: ColorsConst.text, fontSize: 16, fontWeight: FontWeight.w500)))
                  OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.grey), 
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Change the radius here
                        ),
                      ),
                    ),
                    onPressed: (){
                      print(history.id);
                      print(LocalDB.getUserid());
                      //Navigator.pushNamed(context, "/infoview");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InfoviewScreen(history.id)),
                      );
                    }, child: const Text('Info', style: TextStyle(color: ColorsConst.text, fontSize: 16, fontWeight: FontWeight.w500)))
                ],
              ),
            ),
          ],
        ),

        const Divider()

      ],
    );
  }
}