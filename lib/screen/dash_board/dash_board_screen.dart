import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_page.dart';
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/screen/dash_board/dash_board_provider.dart';
import 'package:movie_application_cnv/widget/header_image/header_image_widget.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState
    extends BasePage<DashBoardScreen, DashBoardScreenProvider> {
  @override
  DashBoardScreenProvider initProverder() {
    return DashBoardScreenProvider(this);
  }

  int indexButton = 0;
  @override
  void initState() {
    super.initState();
    appBar = null;
  }

  @override
  Widget body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeaderImage(),
            rowButton(),
            Container(
              height: 430,
              child: PageView.builder(
                  controller: provider.controllerPageView,
                  itemCount: provider.pages.length,
                  itemBuilder: (ctx, index) => provider.pages[index]),
            ),
            searchCinema(),
          ],
        ),
      ),
    );
  }

  rowButton() {
    return Consumer<TabIndexNotifier>(
      builder: (context, indexTab, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  child: Text(
                    provider.tabMovie[0],
                    style: TextStyle(
                        color: indexTab.value == 0
                            ? Colors.black
                            : Colors.grey[400]),
                  ),
                  onPressed: () {
                    provider.onPageChange(0);
                  },
                ),
                FlatButton(
                  child: Text(
                    provider.tabMovie[1],
                    style: TextStyle(
                        color: indexTab.value == 1
                            ? Colors.black
                            : Colors.grey[400]),
                  ),
                  onPressed: () {
                    provider.onPageChange(1);
                  },
                ),
                FlatButton(
                  child: Text(
                    provider.tabMovie[2],
                    style: TextStyle(
                        color: indexTab.value == 2
                            ? Colors.black
                            : Colors.grey[400]),
                  ),
                  onPressed: () {
                    provider.onPageChange(2);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

searchCinema() {
  return Column(
    children: [
      Container(
          child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Tìm rạp gần bạn...',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
          IconButton(icon: Icon(Icons.send_outlined), onPressed: () {})
        ],
      )),
      Container(
        color: Colors.grey[400],
        height: 10,
      )
    ],
  );
}

movieItemSmall(BuildContext context, MovieItem movieItem, Color colorText,
    Color background) {
  return Container(
    color: background,
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieItem.show == null ? '' : movieItem.show.name,
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'Bold', color: colorText),
                  overflow: TextOverflow.ellipsis,
                ),
                (movieItem.show == null || movieItem.show.language == null)
                    ? SizedBox()
                    : Text(
                        movieItem.show.runtime.toString() +
                            'mins ' +
                            movieItem.show.premiered.toString(),
                        style: TextStyle(color: colorText),
                      ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'bookTicket',
                    arguments: movieItem);
              },
              child: Text(
                'Đặt vé',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.all(Radius.circular(20))),
        )
      ],
    ),
  );
}
