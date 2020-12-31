import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_view.dart';
import 'package:movie_application_cnv/screen/dash_board/dash_board_screen.dart';
import 'package:movie_application_cnv/widget/tab_bar_movie/showing_movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

// enum TabType  {Showing, Lived ,Coming}

class ShowingMovie extends StatefulWidget {
  // final TabType type;

  // ShowingMovie({Key key, this.type}) : super(key: key);

  @override
  ShowingMovieState createState() => ShowingMovieState();
}

class ShowingMovieState extends BaseView<ShowingMovie, ShowingMovieProvider> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  ShowingMovieProvider initProverder() {
    return ShowingMovieProvider(this);
  }

  @override
  void initState() {
    super.initState();
    provider.getShowingMovieAPI();
  }

  @override
  Widget body() {
    return Consumer<MovieShowingNotifier>(builder: (context, listMovie, _) {
      return Container(
        color: Colors.black87,
        child: Column(
          children: [
            CarouselSlider.builder(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                aspectRatio: 1.0,
                autoPlay: true,
              ),
              itemCount: listMovie.value.isEmpty ? 1 : listMovie.value.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'movieDetail',
                      arguments: listMovie.value[index]);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: imageMovieItem(listMovie.value.isEmpty
                            ? ''
                            : listMovie
                                .value[index].show?.urlImageList?.urlOriginal),
                      ),
                    ),
                    movieItemSmall(
                        context,
                        listMovie.value.isEmpty
                            ? provider.movieItem
                            : listMovie.value[index],
                        Colors.white, Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

imageMovieItem(String url) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Center(
        child: Platform.isIOS
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(),
      ),
      Container(
          width: double.infinity,
          height: 300,
          child: (url.isEmpty || url == null)
              ? SizedBox()
              : FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage, image: url, fit: BoxFit.fill,)),
    ],
  );
}
