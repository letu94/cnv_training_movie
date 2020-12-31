import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'movie_detail_screen.dart';

class MovieDetailScreenProvider extends BaseProvider {
  MovieDetailScreenProvider(State<MovieDeatailScreen> state) : super(state){
    init();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SeeMoreNotifier seeMoreNotifier = new SeeMoreNotifier(300);
  bool isExpanded = false;
  VideoPlayerController controller;
  bool readMore = true;

Future<void> initializeVideo;

init(){
  controller = VideoPlayerController.network("http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4");
  initializeVideo = controller.initialize();
  controller.setLooping(true);
  controller.setVolume(1.0);
}
  
  playVideo(){
    if(controller.value.isPlaying){
      controller.pause();
    } else controller.play();
  }

void onTapLink() {
    readMore = !readMore;
  }

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
