import 'package:flutter/cupertino.dart';
import 'package:fresh_store_ui/constants/urls_const.dart';

import '../network/models/banner.dart' as banner;

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget(
    this.context, {
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final banner.Banner data;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
      /*  image: DecorationImage(
          image: NetworkImage("${UrlsConst.siteHost}${data.bimg}"),
          fit: BoxFit.fill  
        )*/
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
          child: Image.network("${UrlsConst.siteHost}${data.bimg}", fit:BoxFit.fill  ,)),
    );
    
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     // Expanded(
    //     //   child: Padding(
    //     //     padding: const EdgeInsets.only(left: 32),
    //     //     child: Column(
    //     //       mainAxisAlignment: MainAxisAlignment.center,
    //     //       crossAxisAlignment: CrossAxisAlignment.start,
    //     //       children: [
    //     //         Text(
    //     //           data.discount,
    //     //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
    //     //         ),
    //     //         const SizedBox(height: 12),
    //     //         Text(
    //     //           data.title,
    //     //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //     //         ),
    //     //         const SizedBox(height: 12),
    //     //         Text(
    //     //           data.detail,
    //     //           style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
    //     //         ),
    //     //       ],
    //     //     ),
    //     //   ),
    //     // ),
    //     Image.network("${UrlsConst.siteHost}${data.bimg}"),
    //   ],
    // );
  }
}
