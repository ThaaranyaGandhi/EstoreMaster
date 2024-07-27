import 'package:flutter/material.dart';

import 'colors_const.dart';

class ShadowConst {

  ShadowConst._();

  static normal(context) => [
    BoxShadow(
      color: Theme.of(context).dividerColor,
      offset: const Offset(4, 4),
      blurRadius: 12
    ),
    BoxShadow(
      color: Theme.of(context).dividerColor,
      offset: const Offset(-4, -4),
      blurRadius: 12
    ),
  ];

  static spreaded(context) => [
    BoxShadow(
      color: Theme.of(context).dividerColor,
      offset: const Offset(4, 4),
      blurRadius: 20
    ),
    BoxShadow(
      color: Theme.of(context).dividerColor,
      offset: const Offset(-4, -4),
      blurRadius: 20
    ),
  ];

  static dark(context) => [
    const BoxShadow(
      color: ColorsConst.shadow,
      offset: Offset(0, 0),
      blurRadius: 12
    )
  ];

}