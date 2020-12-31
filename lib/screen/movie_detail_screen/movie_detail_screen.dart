import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:movie_application_cnv/base/base_page.dart';
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/screen/dash_board/dash_board_screen.dart';
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
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.brown),
      actions: [
        Icon(Icons.share),
        Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
        Icon(Icons.menu),
        Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
      ],
      title: Text('Phim'),
    );

    provider.controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=dSBRQUebo7g')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          provider.controller = VideoPlayerController.network(
              'https://www.youtube.com/watch?v=V89BOZhJFlI');
      });

//       TextSpan link = TextSpan(
//   text: provider.readMore ? "... read more" : " read less",
//   style: TextStyle(
//     color: colorClickableText,
//   ),
//   recognizer: TapGestureRecognizer()..onTap = provider.onTapLink
// );
  }

  @override
  void dispose() {
    super.dispose();
    provider.controller.dispose();
  }

  

  Widget _buildMainView(BuildContext context, MovieItem movieItem) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 200,
            child: provider.controller.value.initialized
                ? AspectRatio(
                    aspectRatio: provider.controller.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(provider.controller),
                        Center(
                          child: FloatingActionButton(
                            onPressed: () {
                              provider.playVideo();                            },
                            child: Icon(
                              provider.controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Container(),
                      Center(
                        child: FloatingActionButton(
                          onPressed: () {
                            provider.playVideo();
                          },
                          child: Icon(
                            provider.controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        movieItemSmall(context, movieItem, Colors.black, Colors.white),
        // iconRow(),
        moreInfomation(movieItem),
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
                style: TextStyle(fontWeight: FontWeight.bold),
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
    return Expanded(
      child: ListView(
        children: [
          Container(
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
                              data: movieItem.show.summary.length < 200
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
                              child: movieItem.show.summary.length < 200
                                  ? SizedBox()
                                  : InkWell(
                                      child: Text(
                                        'thu lai',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.brown,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onTap: () => provider
                                          .seeLess(movieItem.show.summary)))
                          : Positioned(
                              right: 8,
                              bottom: 8,
                              child: movieItem.show.summary.length < 200
                                  ? SizedBox()
                                  : InkWell(
                                      child: Text(
                                        '...xem them',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.brown,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onTap: () => provider
                                          .seeMore(movieItem.show.summary))),
                    ]);
                  },
                ),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        rowItem('Kiem duyet', 'Tre em duoi 13 tuoi'),
                        rowItem(
                            'Khoi chieu', 'Ngay ${movieItem.show.premiered}'),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'The loai',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                        rowItem('Dao dien', 'Jake Jason'),
                        rowItem('Dien vien', 'Tommy, JsckSon, Nick Jonash'),
                        rowItem('Thoi luong',
                            movieItem.show.runtime.toString() ?? ''),
                        rowItem('Ngon ngu',
                            '${movieItem.show.language} - Phu de tieng Viet'),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

iconRow() {
  return Container(
    height: 50,
    width: 50,
    // child: Image.assets(
    //   'assets/images/christmas-sock.png',
    //   fit: BoxFit.fill,
    // ),
  );
}

// iconRow() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Container(
//         height: 50,
//         width: 50,
//         child: Image.assets(
//           'assets/images/christmas-sock.png',
//           fit: BoxFit.fill,
//         ),
//       ),
//       Container(
//         height: 50,
//         width: 50,
//         child: Image.asset(
//           'assets/images/christmas-tree.png',
//           fit: BoxFit.fill,
//         ),
//       ),
//       Container(
//         height: 50,
//         width: 50,
//         child: Image.asset(
//           'assets/images/gift.png',
//           fit: BoxFit.fill,
//         ),
//       ),
//       Container(
//         height: 50,
//         width: 50,
//         child: Image.asset('assets/images/gingerbread-man.png',
//           fit: BoxFit.fill,
//         ),
//       ),
//       Container(
//         height: 50,
//         width: 50,
//         child: Image.asset(
//           'assets/images/star.png',
//           fit: BoxFit.fill,
//         ),
//       ),
//     ],
//   );
// }
