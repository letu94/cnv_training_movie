import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_view.dart';
import 'package:movie_application_cnv/screen/dash_board/dash_board_screen.dart';
import 'package:movie_application_cnv/widget/tab_bar_movie/showing_movie_widget.dart';
import 'package:movie_application_cnv/widget/upcoming_movie/upcoming_movie_provider.dart';
import 'package:provider/provider.dart';

class UpcomingMovie extends StatefulWidget {
  @override
  UpcomingMovieState createState() => UpcomingMovieState();
}

class UpcomingMovieState
    extends BaseView<UpcomingMovie, UpcomingMovieProvider> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    provider.getUpcomingMovieAPI();
  }

  @override
  UpcomingMovieProvider initProverder() {
    return UpcomingMovieProvider(this);
  }

  @override
  Widget body() {
    return Consumer<UpcomingMovieNotifier>(builder: (context, listMovie, _) {
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
