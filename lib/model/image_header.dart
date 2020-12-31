class ImageHeader {
  Show show;

  ImageHeader(this.show);

  ImageHeader.fromJson(Map<String, dynamic> json) {
    show = Show.fromJson(json['show']);
  }
}

class Show {
  Image urlList;
  Show.fromJson(Map<String, dynamic> json) {
    urlList = json['image'] == null ? null : Image.fromJson(json['image']);
  }
}

class Image {
  String urlMedium;
  String urlOriginal;

  Image.fromJson(Map<String, dynamic> json) {
    urlMedium = json['medium'];
    urlOriginal = json['original'];
  }
}
