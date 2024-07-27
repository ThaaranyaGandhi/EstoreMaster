import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/screens/mostpopular/most_popular_screen.dart';

import '../../constants/urls_const.dart';
import '../../network/models/banner.dart' as banner;

import '../../components/special_offer_widget.dart';
import '../../network/models/category.dart';
import 'bloc/home_bloc.dart';

typedef SpecialOffersOnTapSeeAll = void Function();

class SpecialOffers extends StatefulWidget {
  final SpecialOffersOnTapSeeAll? onTapSeeAll;

  const SpecialOffers({super.key, this.onTapSeeAll});

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late List<Category> categories = [];
  late List<banner.Banner> specials = [];

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is MainDataFetched) {
          specials = state.banners;
          categories = state.categories;
        }

        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: /* Colors.red.shade100 */ const Color(0xFFE7E7E7),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      final data = specials[index];
                      return SpecialOfferWidget(
                        context,
                        data: data,
                        index: index,
                      );
                    },
                    itemCount: specials.length,
                    allowImplicitScrolling: true,
                    onPageChanged: (value) {
                      setState(() => selectIndex = value);
                    },
                  ),
                ),
                _buildPageIndicator(),
              ],
            ),
            const SizedBox(height: 5),
            _buildTitle(),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 125,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
              ),
              itemBuilder: ((context, index) {
                final data = categories[index];
                return GestureDetector(
                  onTap: () {
                    print(index);
                    MostPopularScreenState.selectedindex = index;
                    Navigator.pushNamed(context, MostPopularScreen.route());
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorsConst.secondColor,
                          /*const Color(0x10101014),*/
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            "${UrlsConst.siteHost}${data.catimg}",
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        data.catname,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xff424242),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        );
      },
    );
  }

  Widget _buildTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Special Offers',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF212121)),
        ),
        // TextButton(
        //   onPressed: () => widget.onTapSeeAll?.call(),
        //   child: const Text(
        //     'See All',
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 16,
        //         color: Color(0xFF212121)),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < specials.length; i++) {
      list.add(i == selectIndex ? _indicator(true) : _indicator(false));
    }
    return Container(
      height: 190,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 4.0,
        width: isActive ? 16 : 4.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          color: isActive ? const Color(0XFF101010) : const Color(0xFFBDBDBD),
        ),
      ),
    );
  }
}
