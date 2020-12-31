import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:movie_application_cnv/base/base_page.dart';
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/screen/movie_detail_screen/movie_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MovieDeatailScreen extends StatefulWidget {
  @override
  MovieDeatailScreenState createState() => MovieDeatailScreenState();
}

class MovieDeatailScreenState
    extends BasePage<MovieDeatailScreen, MovieDetailScreenProvider> {
  final colorClickableText = Colors.blue;
  final widgetColor = Colors.black;

  @override
  Widget body() {
    final MovieItem args = ModalRoute.of(context).settings.arguments;
    // final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    // final colorClickableText = Colors.blue;
    // final widgetColor = Colors.black;

    return SafeArea(
      child: _buildMainView(context, args),
    );
  }

  @override
  MovieDetailScreenProvider initProverder() {
    return MovieDetailScreenProvider(this);
  }

  @override
  void initState() {
    super.initState();
    appBar = AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.brown),
      actions: [
        Icon(Icons.share),
        Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
        Icon(Icons.menu),
        Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
      ],
      title: Text(
        'Phim',
        style: TextStyle(color: Colors.black),
      ),
    );
    provider.init();
  }

    // provider.controller = VideoPlayerController.network(
    //     'https://www.youtube.com/watch?v=dSBRQUebo7g')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     provider.controller = VideoPlayerController.network(
    //         'https://www.youtube.com/watch?v=V89BOZhJFlI');
    //   });

//       TextSpan link = TextSpan(
//   text: provider.readMore ? "... read more" : " read less",
//   style: TextStyle(
//     color: colorClickableText,
//   ),
//   recognizer: TapGestureRecognizer()..onTap = provider.onTapLink
// );
  

  @override
  void dispose() {
    super.dispose();
    provider.controller.dispose();
  }

  Widget _buildMainView(BuildContext context, MovieItem movieItem) {
    return ListView(
      children: [
        Column(
          children: [
            FutureBuilder(
                future: provider.initializeVideo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                        aspectRatio: provider.controller.value.aspectRatio,
                        child: VideoPlayer(
                          provider.controller,
                        ));
                  } else
                    return CircularProgressIndicator();
                }),
            FloatingActionButton(
              onPressed: () {
                provider.playVideo();
              },
              child: provider.controller.value.isPlaying
                  ? Icon(Icons.pause)
                  : Icon(Icons.play_arrow)),
            
            movieItemSmallDetail(context, movieItem, Colors.black, Colors.white),
            iconRow(),
            moreInfomation(movieItem),
          ],
        ),
      ],
    );
  }

  rowItem(String text, String text2) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(109, 94, 79, 1.0)),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(text2),
          flex: 2,
        ),
      ],
    );
  }

  moreInfomation(MovieItem movieItem) {
    provider.cutString(movieItem.show.summary);
    return Container(
      child: Column(
        children: [
          Consumer<SeeMoreNotifier>(
            builder: (context, indexSubString, _) {
              return Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, left: 8, top: 8, bottom: 16),
                  child: Column(
                    children: [
                      Html(
                        data: movieItem.show.summary.length < 300
                            ? movieItem.show.summary
                            : '${movieItem.show.summary.substring(0, indexSubString.value)}',
                        defaultTextStyle: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                provider.isExpanded == true
                    ? Positioned(
                        right: 8,
                        bottom: 8,
                        child: movieItem.show.summary.length < 300
                            ? SizedBox()
                            : InkWell(
                                child: Text(
                                  'thu lại',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(
                                          159, 61, 70, 1.0),
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () => provider
                                    .seeLess(movieItem.show.summary)))
                    : Positioned(
                        right: 8,
                        bottom: 8,
                        child: movieItem.show.summary.length < 300
                            ? SizedBox()
                            : InkWell(
                                child: Text(
                                  '...xem thêm',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(
                                          159, 61, 70, 1.0),
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () => provider
                                    .seeMore(movieItem.show.summary))),
              ]);
            },
          ),
          Container(
            height: 10,
            color: Colors.grey[400],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  rowItem('Kiểm duyệt', 'Trẻ em dưới 13 tuổi'),
                  rowItem(
                      'Khởi chiếu', 'Ngày ${movieItem.show.premiered}'),
                  // rowItem('Thể loại', text2)
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Thể loại',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Color.fromRGBO(109, 94, 79, 1.0)),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: movieItem.show.genres
                              .map((e) => Text(e))
                              .toList(),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                  rowItem('Đạo diễn', 'Jake Jason'),
                  rowItem('Diễn viên', 'Tommy, JsckSon, Nick Jonash'),
                  rowItem('Thời lượng',
                      movieItem.show.runtime.toString() ?? ''),
                  rowItem('Ngôn ngữ',
                      '${movieItem.show.language} - Phụ đề tiếng Việt'),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}

iconRowItem(String string) {
  return Container(
    height: 50,
    width: 50,
    child: Image.asset(
      string,
      fit: BoxFit.fill,
    ),
  );
}

iconRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      iconRowItem('assets/images/christmas-sock.png'),
      iconRowItem('assets/images/christmas-tree.png'),
      iconRowItem('assets/images/gift.png'),
      iconRowItem('assets/images/gingerbread-man.png'),
      iconRowItem('assets/images/star.png'),
    ],
  );
}

movieItemSmallDetail(BuildContext context, MovieItem movieItem, Color colorText,
    Color background) {
  return Container(
    color: background,
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              movieItem.show == null ? '' : movieItem.show.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: colorText),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'bookTicket', arguments: movieItem);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Text(
              'Đặt vé',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Colors.red[900],
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        )
      ],
    ),
  );
}
