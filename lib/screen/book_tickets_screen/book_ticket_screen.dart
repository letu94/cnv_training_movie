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
      backgroundColor: Colors.white,
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
          Text(
            'CGV Aeon Binh Tan',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Cinema 4, ngay 19/2/2020',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
    );
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
              'Màn hình'.toUpperCase(),
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),
          ),
          itemSeat('A', provider.listSeat,
              background: Color.fromRGBO(152, 141, 124, 1.0)),
          itemSeat('B', provider.listSeat,
              background: Color.fromRGBO(152, 141, 124, 1.0)),
          itemSeat('C', provider.listSeat,
              background: Color.fromRGBO(152, 141, 124, 1.0)),
          itemSeat('D', provider.listSeat,
              background: Color.fromRGBO(152, 141, 124, 1.0)),
          itemSeat('E', provider.listSeat),
          itemSeat('F', provider.listSeat),
          itemSeat('G', provider.listSeat),
          itemSeat('H', provider.listSeat),
          itemSeat('S', provider.listSeatFinal, background: Colors.pink),

          /// annotation
          itemAnotation(
              'Đã đặt',
              Colors.white,
              'Thường',
              Colors.grey,
              'Ghế đôi',
              Color.fromRGBO(97, 50, 123, 1.0),
              'Khuyết tật',
              Colors.green),
          itemAnotation(
              'Đang chọn',
              Colors.red,
              'VIP',
              Color.fromRGBO(124, 50, 68, 1.0),
              'Deluxe',
              Color.fromRGBO(49, 63, 136, 1.0),
              'Sweet box',
              Colors.pink),
          itemAnotation(
              '4DX',
              Color.fromRGBO(99, 98, 18, 1.0),
              'Lamour',
              Color.fromRGBO(57, 45, 37, 1.0),
              'Prenium',
              Color.fromRGBO(128, 150, 197, 1.0),
              'Gold class',
              Colors.brown[700]),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              children: [
                item('Khác', Color.fromRGBO(157, 138, 10, 1.0)),
                Expanded(child: SizedBox(), flex: 3),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          bookTicketMovie(context, args, Colors.black, provider.listSeatBooked,
              Colors.white),
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

  itemSeat(String string, List<int> seat,
      {Color background = const Color.fromRGBO(123, 50, 68, 1.0)}) {
    var _typeOfSeat;
    switch (string) {
      case ('A'):
      case ('B'):
      case ('C'):
      case ('D'):
        _typeOfSeat = 'Thường';
        break;
      case ('E'):
      case ('F'):
      case ('G'):
      case ('H'):
        _typeOfSeat = 'VIP';
        break;
      case ('S'):
        _typeOfSeat = 'Sweet box';
        break;
    }
    return Consumer<ColorSeatNotifier>(
      builder: (context, color, _) {
        return Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: seat.reversed
                    .map((e) => SeatView(
                          typeOfSeat: _typeOfSeat,
                          background: provider.selectedList
                                  .contains(string + e.toString())
                              ? Colors.white
                              : background,
                          string: string,
                          seatNumber: e,
                          onTapSeat: (string, seatNumber) {
                            var _item = string + e.toString();
                            var _hasItem = provider.bookList.contains(_item);
                            var item = SeatView(
                              typeOfSeat: _typeOfSeat,
                              string: string,
                              seatNumber: e,
                              // onTapSeat: (string, seatNumber) {}
                            );
                            // var _hasItemSeat =
                            //     provider.listSeatBooked.contains(item);

                            if (_hasItem) {
                              // provider.bookList.remove(_item);
                              // for (var index in provider.listSeatBooked) {
                              //   if (string == index.string && e == index.seatNumber) {
                              //     provider.listSeatBooked.remove(index);
                              //   }
                              // }
                              provider.listSeatBooked.removeWhere(
                                  (seatbooked) =>
                                      seatbooked.string == string &&
                                      e == seatbooked.seatNumber);
                            } else {
                              provider.bookList.add(_item);
                              provider.listSeatBooked.add(item);
                            }
                            // provider.bookList
                            //     .add(string + seatNumber.toString());
                            // provider.bookList =
                            //     provider.bookList.toSet().toList();
                            print(provider.listSeatBooked);
                            print(provider.bookList);
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
    List<SeatView> bookList, Color background) {
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
        InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => Container(
                        height: 400,
                        child: AlertDialog(
                          title: Text('Book vé xem phim'),
                          content: Container(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phim: ${movieItem.show.name}'),
                                Text(bookList.isEmpty
                                    ? 'Số ghế đã đặt: 0'
                                    : 'Số ghế đã đặt: ${bookList.length}'),
                                Text(bookList.isEmpty
                                    ? 'Bạn chưa đặt ghế'
                                    : 'Ghế đã đặt: ${bookList.map((e) => e.string + e.seatNumber.toString() + "-" + e.typeOfSeat.toString())}'),
                                // Text(bookList.isEmpty
                                // ? ''
                                // : 'Loại ghế: ${bookList.map((e) => e.toString())}'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Container(
                              child: FlatButton(
                                child: Text('Đóng'.toUpperCase()),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              color: Colors.blue,
                              child: FlatButton(
                                child: Text(
                                  'Xác nhận'.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'dashBoard');
                                },
                              ),
                            )
                          ],
                        ),
                      ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Text(
                'Đặt vé',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ))
      ],
    ),
  );
}
