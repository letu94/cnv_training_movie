import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'movie_detail_screen.dart';

class MovieDetailScreenProvider extends BaseProvider {
  MovieDetailScreenProvider(State<MovieDeatailScreen> state) : super(state);

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SeeMoreNotifier seeMoreNotifier = new SeeMoreNotifier(200);
  bool isExpanded = false;
  VideoPlayerController controller;
  bool readMore = true;


  

void onTapLink() {
    readMore = !readMore;
  }
  // int end = 100;
  // final MovieItem args = ModalRoute.of(state.widget.context).settings.arguments;

  String cutString(String string) {
    RegExp exp = new RegExp(r"(<p>, </p>)");
    String newString =
        string.replaceAllMapped(exp, (match) => '"${match.group(0)}');
    return newString;
  }

  seeMore(String string) {
    seeMoreNotifier.value = string.length;
    isExpanded = true;
  }

  seeLess(String string) {
    seeMoreNotifier.value = 200;
    isExpanded = false;
  }

  playVideo() {
    controller.value.isPlaying ? controller.pause() : controller.play();
  }

  @override
  List<BaseNotifier> initNotifiers() {
    return [seeMoreNotifier];
  }
}

class SeeMoreNotifier extends BaseNotifier<int> {
  SeeMoreNotifier(int value) : super(value);

  @override
  SingleChildWidget provider() {
    return ChangeNotifierProvider<SeeMoreNotifier>(create: (_) => this);
  }
}
