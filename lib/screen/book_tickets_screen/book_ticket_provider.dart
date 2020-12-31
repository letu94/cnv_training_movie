

import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'book_ticket_screen.dart';

class BookTicketScreenProvider extends BaseProvider {
  BookTicketScreenProvider(State<BookTicketScreen> state) : super(state);

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ColorSeatNotifier colorSeatNotifier = new ColorSeatNotifier(null);
  // Color bookSeat = Colors.white;

  List<List<String>> seats = [];
  init(){

  }

  @override
  List<BaseNotifier> initNotifiers() {
    return [colorSeatNotifier];
  }

  bookSeat(Color color){
    colorSeatNotifier.value = Colors.white;
  }
}
class ColorSeatNotifier extends BaseNotifier <Color> {
  ColorSeatNotifier(Color value) : super(value);

  @override
  SingleChildWidget provider() {
    return ChangeNotifierProvider<ColorSeatNotifier>(create: (_) => this);
  }
  
}

