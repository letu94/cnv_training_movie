import 'dart:convert';

import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/widget/tab_bar_movie/showing_movie_widget.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class ShowingMovieProvider extends BaseProvider {
  ShowingMovieProvider(ShowingMovieState state) : super(state);

MovieShowingNotifier movieShowingNotifier = new MovieShowingNotifier([]);

MovieItem movieItem = MovieItem(Show(null, '', '' , [], '', 0, ''));

  @override
  List<BaseNotifier> initNotifiers() {
    return [movieShowingNotifier];
  }

getShowingMovieAPI() async {
    // showLoading();
    var url = 'http://api.tvmaze.com/search/shows?q=vietnam';
    var response = await http.get(url);
    // hiddenLoading();
    List<dynamic> data = json.decode(response.body);
    List<MovieItem> dataJson =
        data.map((e) => MovieItem.fromJson(e)).toList();
    movieShowingNotifier.value = dataJson;
  }

}

class MovieShowingNotifier extends BaseNotifier<List<MovieItem>>{
  MovieShowingNotifier(List<MovieItem> value) : super(value);

  @override
  SingleChildWidget provider() {
   return ChangeNotifierProvider<MovieShowingNotifier>(create: (_) => this);
  }
}