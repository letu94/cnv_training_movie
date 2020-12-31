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
              height: 450,
              child: PageView.builder(
                  controller: provider.controllerPageView,
                  itemCount: provider.pages.length,
                  itemBuilder: (ctx, index) => provider.pages[index]),
            ),
            searchCinema(),
            Container(
              color: Colors.grey,
              height: 10,
            )
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
                        color: indexTab.value == 0 ? Colors.red : Colors.black),
                  ),
                  onPressed: () {
                    provider.onPageChange(0);
                  },
                ),
                FlatButton(
                  child: Text(
                    provider.tabMovie[1],
                    style: TextStyle(
                        color: indexTab.value == 1 ? Colors.red : Colors.black),
                  ),
                  onPressed: () {
                    provider.onPageChange(1);
                  },
                ),
                FlatButton(
                  child: Text(
                    provider.tabMovie[2],
                    style: TextStyle(
                        color: indexTab.value == 2 ? Colors.red : Colors.black),
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
  return Container(
      child: Row(
    children: [
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Tim rap gan ban',
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ),
      IconButton(icon: Icon(Icons.send_outlined), onPressed: () {})
    ],
  ));
}

movieItemSmall(BuildContext context, MovieItem movieItem, Color colorText, Color background) {
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
                  style:
                      TextStyle(fontSize: 18, fontFamily: 'Bold', color: colorText),
                  overflow: TextOverflow.ellipsis,
                ),
                (movieItem.show == null || movieItem.show.language == null)
                    ? SizedBox()
                    : Text(
                        movieItem.show.language,
                        style: TextStyle(color: colorText),
                      ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(10),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'bookTicket', arguments: movieItem);
              },
              child: Text(
                'Dat ve',
                style: TextStyle(color: Colors.white),
              )),
          decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.all(Radius.circular(20))),
        )
      ],
    ),
  );
}
