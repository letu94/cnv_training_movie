import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_application_cnv/screen/book_tickets_screen/book_ticket_screen.dart';
import 'package:movie_application_cnv/screen/dash_board/dash_board_screen.dart';
import 'package:movie_application_cnv/screen/movie_detail_screen/movie_detail_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: DashBoardScreen(),
      initialRoute: 'dashBoard',
      routes: {
        'dashBoard': (context) => DashBoardScreen(),
        'movieDetail': (context) => MovieDeatailScreen(),
        'bookTicket': (context) => BookTicketScreen(),

      },
    );
  }
}
