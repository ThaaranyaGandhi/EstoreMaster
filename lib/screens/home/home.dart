import 'package:flutter/material.dart';
import 'package:fresh_store_ui/components/product_card.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/screens/detail/detail_screen.dart';
import 'package:fresh_store_ui/screens/home/bloc/home_bloc.dart';
import 'package:fresh_store_ui/screens/home/hearder.dart';
import 'package:fresh_store_ui/screens/home/most_popular.dart';
import 'package:fresh_store_ui/screens/home/search_field.dart';
import 'package:fresh_store_ui/screens/home/special_offer.dart';
import 'package:fresh_store_ui/screens/mostpopular/most_popular_screen.dart';
import 'package:fresh_store_ui/screens/search/search_screen.dart';
import 'package:fresh_store_ui/screens/special_offers/special_offers_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Contactus.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late var datas = [];

  @override
  void initState() {
    context.read<HomeBloc>().add(GetMainData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.fromLTRB(15, 0, 15, 0);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const
            SliverAppBar(
              backgroundColor: ColorsConst.firstColor,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: HomeAppBar(),
            ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) => _buildBody(context)),
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            sliver: _buildPopulars(),
          ),
          const SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: SizedBox(height: 24))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            /// search bar
            Navigator.pushNamed(context, SearchScreen.route());
          },
          child: const IgnorePointer(
            child: SearchField(),
          ),
        ),
        const SizedBox(height: 15),

        /// Special offer
        SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),

        const SizedBox(height: 20),

        /// Custom Design Enquiry
        Container(
          height: 150,
          decoration: BoxDecoration(
            image: const DecorationImage(image: AssetImage('assets/images/back_green_1.png'),fit: BoxFit.fill),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 7, // Blur radius
                offset: const Offset(0, 2), // Offset in the x and y direction
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          //  border: Border.all(color: Colors.grey, width: 1),
            color: ColorsConst.secondColor /*const Color(0xFFFFFFFF)*/,
          ),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const contactusScreen()));
            },
            child:  Container(
              decoration: const BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorsConst.firstColor /*const Color(0xFFFFFFFF)*/,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              child: const Text(
                'Subscription',
                style: TextStyle(
                  color: Colors.white /*Colors.white*/,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0xFF101010), width: 1),
            color: ColorsConst.firstColor /*const Color(0xFFFFFFFF)*/,
          ),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const contactusScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              child: Text(
                'Subscription',
                style: TextStyle(
                  color: Color(0xFF101010) /*Colors.white*/,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),

        /// popular
        MostPopularTitle(onTapseeAll: () => _onTapMostPopularSeeAll(context)),
        // const SizedBox(height: 24),
        // const MostPupularCategory(),
      ],
    );
  }

  Widget _buildPopulars() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is MainDataFetched) {
          datas = state.products;
        }

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 185,
            mainAxisSpacing: 24,
            crossAxisSpacing: 16,
            mainAxisExtent: 270,
          ),
          delegate: SliverChildBuilderDelegate(_buildPopularItem,
              childCount: datas.length),
        );
      },
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    final data = datas[index];
    return ProductCard(
      data: data,
      ontap: (data) => Navigator.pushNamed(context, ShopDetailScreen.route(),
          arguments: data),
    );
  }

  void _onTapMostPopularSeeAll(BuildContext context) {
    Navigator.pushNamed(context, MostPopularScreen.route());
  }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.pushNamed(context, SpecialOfferScreen.route());
  }
}
