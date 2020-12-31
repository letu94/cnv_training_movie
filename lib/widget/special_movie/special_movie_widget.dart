import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_view.dart';
import 'package:movie_application_cnv/screen/dash_board/dash_board_screen.dart';
import 'package:movie_application_cnv/widget/special_movie/special_movie_provider.dart';
import 'package:movie_application_cnv/widget/tab_bar_movie/showing_movie_widget.dart';
import 'package:provider/provider.dart';

class SpecialMovie extends StatefulWidget {
  @override
  SpecialMovieState createState() => SpecialMovieState();
}

class SpecialMovieState extends BaseView<SpecialMovie, SpecialMovieProvider> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    provider.getMovieSpecialAPI();
  }

  @override
  Widget body() {
    return Consumer<MovieShowingNotifier>(builder: (context, listMovie, _) {
      return Container(
        color: Colors.black54,
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

  @override
  SpecialMovieProvider initProverder() {
    return SpecialMovieProvider(this);
  }
}
