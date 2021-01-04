import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:movie_application_cnv/screen/book_tickets_screen/seat_view.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'book_ticket_screen.dart';

class BookTicketScreenProvider extends BaseProvider {
  BookTicketScreenProvider(State<BookTicketScreen> state) : super(state);

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ColorSeatNotifier colorSeatNotifier = new ColorSeatNotifier(null);
  // Color bookSeat = Colors.white;
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
  List<String> selectedList = ['C10', 'C11', 'G10', 'G11', 'S10', 'S11'];

  List<String> bookList = [];
  List<SeatView> listSeatBooked = [];

  init() {}

  @override
  List<BaseNotifier> initNotifiers() {
    return [colorSeatNotifier];
  }

  bookSeat(Color color) {
    colorSeatNotifier.value = Colors.white;
  }
}

class ColorSeatNotifier extends BaseNotifier<Color> {
  ColorSeatNotifier(Color value) : super(value);

  @override
  SingleChildWidget provider() {
    return ChangeNotifierProvider<ColorSeatNotifier>(create: (_) => this);
  }
}
