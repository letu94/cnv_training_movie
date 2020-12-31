import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/widget/special_movie/special_movie_widget.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class SpecialMovieProvider extends BaseProvider {
  SpecialMovieProvider(SpecialMovieState state) : super(state);

MovieShowingNotifier movieShowingNotifier = new MovieShowingNotifier([]);
MovieItem movieItem = MovieItem(Show(null, '', '' , [], '', 0, ''));


  @override
  List<BaseNotifier> initNotifiers() {
    return [movieShowingNotifier];
  }

getMovieSpecialAPI() async {
    // showLoading();
    var url = 'http://api.tvmaze.com/search/shows?q=cartoon';
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