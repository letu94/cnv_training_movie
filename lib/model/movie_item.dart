
class MovieItem {
  Show show;

  MovieItem(this.show);

  MovieItem.fromJson(Map<String, dynamic> json) {
    show = json['show'] == null ? Show(null, '', '' , [], '', 0, '') : Show.fromJson(json['show']);
  }
}

class Show {
  Image urlImageList;
  String name;
  String summary;
  List<String> genres;
  String language;
  int runtime;
  String premiered;

  Show(this.urlImageList, this.name, this.summary, this.genres, this.language,
      this.runtime, this.premiered);

  Show.fromJson(Map<String, dynamic> json) {
    urlImageList =
      json['image'] == null ? Image('', '') : Image.fromJson(json['image']);
    name = json['name'];
    summary = json['summary'];
    genres = List.from((json['genres'].map((e) => e.toString())));
    language = json['language'];
    premiered = json['premiered'];
    runtime = json['runtime'];
  }
}

class Image {
  String urlMedium;
  String urlOriginal;
  Image(this.urlMedium, this.urlOriginal);

  Image.fromJson(Map<String, dynamic> json) {
    urlMedium = json['medium'];
    urlOriginal = json['original'];
  }
}
