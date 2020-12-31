import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:movie_application_cnv/widget/special_movie/special_movie_widget.dart';
import 'package:movie_application_cnv/widget/tab_bar_movie/showing_movie_widget.dart';
import 'package:movie_application_cnv/widget/upcoming_movie/upcoming_movie_widget.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'dash_board_screen.dart';

class DashBoardScreenProvider extends BaseProvider {
  DashBoardScreenProvider(State<DashBoardScreen> state) : super(state);

  final tabMovie = ["Dang chieu", "Dac biet", "Sap chieu"];
  final pages = [ShowingMovie(), SpecialMovie(), UpcomingMovie()];
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController controllerPageView =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  TabIndexNotifier tabIndexNotifier = new TabIndexNotifier(0);

  Timer timer;
  CarouselController buttonCarouselController = CarouselController();

  @override
  List<BaseNotifier> initNotifiers() {
    return [
      tabIndexNotifier
    ];
  }

  onPageChange(int index) {
    tabIndexNotifier.value = index;
    controllerPageView.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }
}



class TabIndexNotifier extends BaseNotifier<int> {
  TabIndexNotifier(int value) : super(value);

  @override
  SingleChildWidget provider() {
    return ChangeNotifierProvider<TabIndexNotifier>(create: (_) => this);
  }
}


