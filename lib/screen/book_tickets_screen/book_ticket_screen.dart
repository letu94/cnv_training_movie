import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_page.dart';
import 'package:movie_application_cnv/model/movie_item.dart';
import 'package:movie_application_cnv/screen/book_tickets_screen/book_ticket_provider.dart';
import 'package:movie_application_cnv/screen/book_tickets_screen/seat_view.dart';
import 'package:provider/provider.dart';

class BookTicketScreen extends StatefulWidget {
  @override
  BookTicketScreenState createState() => BookTicketScreenState();
}

class BookTicketScreenState
    extends BasePage<BookTicketScreen, BookTicketScreenProvider> {
  List<int> listSeat = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
  List<int> listSeatFinal = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18
  ];

  List<String> bookList = [];

  @override
  Widget body() {
    final MovieItem args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: _buildMainView(context, args),
    );
  }

  @override
  BookTicketScreenProvider initProverder() {
    return BookTicketScreenProvider(this);
  }

  @override
  void initState() {
    super.initState();
    appBar = AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.brown),
      actions: [
        Icon(Icons.menu),
        Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
      ],
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CGV Aeon Binh Tan'),
          Text(
            'Cinema 4, ngay 19/2/2020',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
    );
    background = Colors.black;
  }

  Widget _buildMainView(BuildContext context, MovieItem args) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          Container(
            height: 200,
            child: Center(
                child: Text(
              'Man hinh'.toUpperCase(),
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),
          ),
          Container(
            color: Colors.amber,
            child: Center(child: Text('Ghe ngoi')),
          ),
          itemSeat('A', listSeat, background: Colors.grey),
          itemSeat('B', listSeat, background: Colors.grey),
          itemSeat('C', listSeat, background: Colors.grey),
          itemSeat('D', listSeat, background: Colors.grey),
          itemSeat(
            'E',
            listSeat,
          ),
          itemSeat(
            'F',
            listSeat,
          ),
          itemSeat(
            'G',
            listSeat,
          ),
          itemSeat(
            'H',
            listSeat,
          ),
          itemSeat('S', listSeatFinal, background: Colors.pink),

          /// annotation
          itemAnotation('Da dat', Colors.white, 'Thuong', Colors.grey,
              'Ghe doi', Colors.purple, 'Khuyet tat', Colors.green),
          itemAnotation('Dang chon', Colors.red, 'VIP', Colors.brown, 'Ghe doi',
              Colors.purple, 'Sweet box', Colors.pink),
          itemAnotation('4DX', Colors.amber, 'Lamour', Colors.brown[300],
              'Prenium', Colors.blueGrey, 'Gold class', Colors.brown[700]),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              children: [
                item('Khac', Colors.white),
                Expanded(child: SizedBox(), flex: 3),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          bookTicketMovie(context, args, Colors.black, bookList, Colors.white),
        ],
      ),
    );
  }

  itemAnotation(String string1, Color color1, String string2, Color color2,
      String string3, Color color3, String string4, Color color4) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: [
          item(string1, color1),
          item(string2, color2),
          item(string3, color3),
          item(string4, color4),
        ],
      ),
    );
  }

  item(String string, Color color) {
    return Expanded(
      flex: 1,
      child: Row(children: [
        Container(width: 15, height: 15, color: color),
        SizedBox(width: 2),
        Text(
          string,
          style: TextStyle(color: Colors.white),
        )
      ]),
    );
  }

  itemSeat(String string, List<int> seat, {Color background = Colors.brown}) {
    return Consumer<ColorSeatNotifier>(
      builder: (context, color, _) {
        return Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: seat.reversed
                    .map((e) => SeatView(
                          background: background,
                          string: string,
                          seatNumber: e,
                          onTapSeat: (string, seatNumber) {
                            var _item = string + seatNumber.toString();
                            var _hasItem = bookList.contains(_item);
                            print(_hasItem);
                            if (_hasItem) {
                              bookList.remove(_item);
                            } else {
                              bookList.add(_item);
                            }
                            // bookList.add(string + seatNumber.toString());
                            // bookList = bookList.toSet().toList();
                            print(bookList);
                          },
                        ))
                    .toList()),
            SizedBox(height: 1)
          ],
        );
      },
    );
  }
}

bookTicketMovie(BuildContext context, MovieItem movieItem, Color colorText,
    List<String> bookList, Color background) {
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
                print('object');
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Book ve xem phim'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phim: ${movieItem.show.name}'),
                              Text(bookList.isEmpty
                                  ? 'So ghe da dat: 0'
                                  : 'So ghe da dat: ${bookList.length}'),
                              Text(bookList.isEmpty
                                  ? 'Chua dat ghe'
                                  : 'Ghe da dat: ${bookList.map((e) => e.toString()).toList()}'),
                            ],
                          ),
                          actions: <Widget>[
                            Container(
                              child: FlatButton(
                                child: Text('Close'.toUpperCase()),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              child: FlatButton(
                                child: Text(
                                  'Confirm'.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'dashBoard');
                                },
                              ),
                            )
                          ],
                        ));
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
