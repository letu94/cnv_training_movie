import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_view.dart';
import 'package:movie_application_cnv/widget/header_image/header_image_provider.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HeaderImage extends StatefulWidget {
  @override
  HeaderImageState createState() => HeaderImageState();
}

class HeaderImageState extends BaseView<HeaderImage, HeaderImageProvider> {
  @override
  void initState() {
    super.initState();
    provider.getHeaderImageAPI();
  }

  @override
  HeaderImageProvider initProverder() {
    return HeaderImageProvider(this);
  }

  @override
  Widget body() {
    return Container(
        height: 250,
        child: Consumer<HeaderImageNotifier>(
            builder: (context, listHeaderImage, _) {
          return PageView.builder(
              itemCount: listHeaderImage.value.length,
              controller: provider.controllerPageView,
              itemBuilder: (context, index) {
                return headerImage(listHeaderImage.value == null
                    ? ''
                    : listHeaderImage
                        .value[index].show?.urlImageList?.urlOriginal);
              });
        }));
  }
}

headerImage(String url) {
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
          height: 250,
          child: (url.isEmpty || url == null)
              ? SizedBox()
              : FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  // placeholderScale: 0.1,
                  fit: BoxFit.fill,
                  image: url)),
    ],
  );
}
