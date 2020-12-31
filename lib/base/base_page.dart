import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

abstract class BasePage<S extends StatefulWidget, T extends BaseProvider>
    extends BaseView<S, T> {
  /// BasePage thuc chat cung la la 1 SFT Widget do no ke thua Base View
  /// gan appBar
  AppBar appBar = AppBar(
    title: Text('title'),
  );
  Color background = Colors.white;
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

        /// do no extends BaseView nen no co body, provier
        providers: provider.providers,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: [
              buildBackground(),
              Scaffold(
                  appBar: appBar,
                  // endDrawer: endDrawer,

                  /// body duoc lay o BaseView
                  body: body(),
                ),

              /// hien thi loading
              buildLoading(),
            ],
          ),
        ));
  }

  /// nen color
  Widget buildBackground() => Container(color: background);
}
