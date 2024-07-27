import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/network/models/product.dart';
import 'package:fresh_store_ui/screens/cart/cart.dart';
import 'package:fresh_store_ui/size_config.dart';

import '../../global.dart';
import '../../utils/calculations.dart';

class ShopDetailScreen extends StatefulWidget {
  const ShopDetailScreen({super.key});

  static String route() => '/shop_detail';

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  int _quantity = 0;
  late Product product;
  late Price price;

  @override
  void initState() {
    super.initState();
  }

  int _index = 0;
  List<String>? output;

  @override
  void didChangeDependencies() {
    product = ModalRoute.of(context)!.settings.arguments as Product;
    print(product.productImage);
    price = product.price[0];
    super.didChangeDependencies();
    print(product.productImage);
    output = product.productRelatedImage.split(',');
    print(output);
    print(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: getProportionateScreenHeight(428),
                  leading: IconButton(
                    icon: Image.asset('assets/icons/back@2x.png', scale: 2),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: SizedBox(
                      height: 200, // card height
                      child: PageView.builder(
                        itemCount: output?.length,
                        controller: PageController(viewportFraction: 1),
                        onPageChanged: (int index) =>
                            setState(() => _index = index),
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 1,
                            child: InkWell(
                              onTap: () {
                                InvoiceDialog(context, _index);
                              },
                              child: Card(
                                color: ColorsConst.secondColor,
                                elevation: 3,
                                child: Center(
                                  child: Image.network(
                                    product.productImage,
                                    width: 300,
                                    height: 300,
                                  ), /*Image.network(
                                    'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/' +
                                        output![_index],
                                    fit: BoxFit.cover,
                                  ),*/
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     shrinkWrap: true,
                    //     itemCount: 5,
                    //     itemBuilder: (context, index) {
                    //       return  Container(
                    //         color: const Color(0xFFeeeeee),
                    //         child: Image.network(
                    //           product.productImage,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       );
                    //     }),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildTitle(),
                        const SizedBox(height: 15),
                        _buildLine(),
                        const SizedBox(height: 16),
                        ..._buildDescription(),
                        const SizedBox(height: 24),
                        _buildQuantity(),
                        const SizedBox(height: 115),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buldFloatBar()
          ],
        ),
      ),
    );
  }

  Future InvoiceDialog(context, index) async {
    print(index);
    final maxLines = 5;
    final Size screenSize = MediaQuery.of(context).size;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: MediaQuery.of(context).viewInsets,
                    color: Colors.transparent,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: screenSize.height / 8, //1.5
                          top: 20),
                      //color: Colors.white,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child:
                            //children: [
                            Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(top: 0, right: 10),
                              width: screenSize.width,
                              child: Row(
                                children: [
                                  const Expanded(flex: 9, child: Text('')),
                                  Expanded(
                                    child: GestureDetector(
                                        child: Container(
                                          width: 120,
                                          height: 40,
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                        ),
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          Navigator.of(context).pop();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Image.network(
                                  'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/' +
                                      output![index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        //],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  List<Widget> _buildTitle() {
    return <Widget>[
      Text(
        product.productName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     FittedBox(
      //       child: Text(
      //         product.productName,
      //         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () => setState(() => _iscollected = !_iscollected),
      //       icon: Image.asset('assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png'),
      //       iconSize: 28,
      //     ),
      //   ],
      // ),
      const SizedBox(height: 10),
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: ColorsConst.secondColor /*const Color(0xFF101010).withOpacity(0.08)*/,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              '${product.discount} % Off',
              style: const TextStyle(
                color: Color(0xFF35383F),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '\$${price.productPrice}',
            style: const TextStyle(
              color: Color(0xFF616161),
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Text(
        '\$${Calculations.calculateDiscountedPrice(price.productPrice, product.discount)}',
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121)),
      )
      // Row(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      //       decoration: const BoxDecoration(
      //         borderRadius: BorderRadius.all(Radius.circular(6)),
      //         color: Color(0xFFeeeeee),
      //       ),
      //       child: const Text(
      //         '9,742 sold',
      //         style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      //       ),
      //     ),
      //     const SizedBox(width: 16),
      //     Image.asset('assets/icons/start@2x.png', height: 20, width: 20),
      //     const SizedBox(width: 8),
      //     const Text(
      //       '4.8 (6,573 reviews)',
      //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      //     ),
      //   ],
      // ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Description',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      ExpandableText(
        product.shortDesc,
        expandText: 'view more',
        collapseText: 'view less',
        linkStyle: const TextStyle(
            color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: ColorsConst.secondColor /*Color(0xFFF3F3F3)*/,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: price,
                      items: product.price
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(e.productType,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )))
                          .toList(),
                      isExpanded: false,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            price = value;
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ),
        Container(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: ColorsConst.secondColor /*Color(0xFFF3F3F3)*/,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child:
                      Image.asset('assets/icons/detail/minus@2x.png', scale: 2),
                  onTap: () {
                    if (_quantity <= 0) return;

                    setState(() => _quantity -= 1);
                    Global.addCartItem(product, _quantity);
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const SizedBox(width: 20),
                InkWell(
                  child:
                      Image.asset('assets/icons/detail/plus@2x.png', scale: 2),
                  onTap: () {
                    setState(() => _quantity += 1);
                    Global.addCartItem(product, _quantity);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: getProportionateScreenWidth(208),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: ColorsConst.firstColor /*const Color(0xFF101010)*/,
            border: Border.all(color: Colors.black87, width: 1),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                Navigator.pushNamed(context, CartScreen.route());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/detail/bag@2x.png',
                    scale: 1.5,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'View Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ValueListenableBuilder(
        valueListenable: Global.myCartItems,
        builder: (_, cartItems, __) {
          var totalItems = Global.calculateTotalItems(cartItems);
          var totalAmount =
              Global.calculateTotalAmount(cartItems).toStringAsFixed(2);

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildLine(),
                const SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$totalItems Items',
                            style: const TextStyle(
                                color: Color(0xFF757575), fontSize: 12)),
                        const SizedBox(height: 6),
                        Text('\$ $totalAmount',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                      ],
                    ),
                    buildAddCard()
                  ],
                ),
                const SizedBox(height: 36),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class ExpandableText extends StatefulWidget {
//   ExpandableText({this.text = ""});
//   //text is the total text of our expandable widget
//   final String text;
//   @override
//   _ExpandableTextState createState() => _ExpandableTextState();
// }

// class _ExpandableTextState extends State<ExpandableText> {
//   static const viewMore = ' view more...';
//   static const fixedLength = 50;
//   late String textToDisplay;
//   @override
//   void initState() {
//     //if the text has more than a certain number of characters, the text we display will consist of that number of characters;
//     //if it's not longer we display all the text
//     print(widget.text.length);

//     //we arbitrarily chose 25 as the length
//     textToDisplay = widget.text.length > 25 ? widget.text.substring(0, 25) + viewMore : widget.text;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Text(textToDisplay),
//       onTap: () {
//         //if the text is not expanded we show it all
//         if (widget.text.length > 25 && textToDisplay.length <= (25 + viewMore.length)) {
//           setState(() {
//             textToDisplay = widget.text;
//           });
//         }
//         //else if the text is already expanded we contract it back
//         else if (widget.text.length > 25) {
//           setState(() {
//             textToDisplay = widget.text.substring(0, 25) + viewMore;
//           });
//         }
//       },
//     );
//   }
// }
