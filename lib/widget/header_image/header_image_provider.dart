import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/widget/header_image/header_image_widget.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class HeaderImageProvider extends BaseProvider<HeaderImageState> {
  HeaderImageProvider(HeaderImageState state) : super(state) {
    countDownTimerHeader();
  }
  PageController controllerPageView = PageController(initialPage: 0);
  HeaderImageNotifier headerImageNotifier = new HeaderImageNotifier([]);
  int _currentPage = 0;
  Timer timer;

  @override
  List<BaseNotifier> initNotifiers() {
    return [headerImageNotifier];
  }

  getHeaderImageAPI() async {
    showLoading();
    var url = 'http://api.tvmaze.com/search/shows?q=avengers';
    var response = await http.get(url);
    hiddenLoading();
    List<dynamic> data = json.decode(response.body);
    List<MovieItem> dataJson = data == null ? [] :
      List.from(data.map((e) => MovieItem.fromJson(e))) ;
    headerImageNotifier.value = dataJson;
  }

  countDownTimerHeader() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (!state.mounted) timer.cancel();
      if (_currentPage < headerImageNotifier.value?.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (state.mounted)
        controllerPageView.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),

          /// hieu ung chuyen man hinh, cang nho se ko thay hieu ung chuyen
          curve: Curves.easeIn,
        );
    });
  }
}

class HeaderImageNotifier extends BaseNotifier<List<MovieItem>> {
  HeaderImageNotifier(List<MovieItem> value) : super(value);

  @override
  SingleChildWidget provider() {
    return ChangeNotifierProvider<HeaderImageNotifier>(create: (_) => this);
  }
}
