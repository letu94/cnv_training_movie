import 'dart:convert';

import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/widget/upcoming_movie/upcoming_movie_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class UpcomingMovieProvider extends BaseProvider {
  UpcomingMovieProvider(UpcomingMovieState state) : super(state);

UpcomingMovieNotifier movieShowingNotifier = new UpcomingMovieNotifier([]);

MovieItem movieItem = MovieItem(Show(null, '', '' , [], '', 0, ''));

  @override
  List<BaseNotifier> initNotifiers() {
    return [movieShowingNotifier];
  }

getUpcomingMovieAPI() async {
    // showLoading();
    var url = 'http://api.tvmaze.com/search/shows?q=funny';
    var response = await http.get(url);
    // hiddenLoading();
    List<dynamic> data = json.decode(response.body);
    List<MovieItem> dataJson =
        data.map((e) => MovieItem.fromJson(e)).toList();
    movieShowingNotifier.value = dataJson;
  }

}

class UpcomingMovieNotifier extends BaseNotifier<List<MovieItem>>{
  UpcomingMovieNotifier(List<MovieItem> value) : super(value);

  @override
  SingleChildWidget provider() {
   return ChangeNotifierProvider<UpcomingMovieNotifier>(create: (_) => this);
  }
}