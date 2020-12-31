import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_application_cnv/base/base_view.dart';
import 'package:movie_application_cnv/screen/book_tickets_screen/seat_provider.dart';
import 'package:provider/provider.dart';

class SeatView extends StatefulWidget {
  final Color background;
  final String string;
  final int seatNumber;
  final Function(String, int) onTapSeat;

  const SeatView(
      {Key key, this.background, this.string, this.seatNumber, this.onTapSeat})
      : super(key: key);
  @override
  _SeatViewState createState() => _SeatViewState();
}

class _SeatViewState extends BaseView<SeatView, SeatProvider> {
  bool selected = false;
  Color original;
  @override
  void initState() {
    super.initState();
    original = widget.background;
  }
  @override
  Widget body() {
    return Consumer<ColorSeatNotifier>(
      builder: (context, color, _) {
        return InkWell(
          onTap: () {
            // selected = !selected;
            // if(selected){
// provider.bookSeat(widget.background);
            widget.onTapSeat(widget.string, widget.seatNumber);
  provider.setColor();
            // } else {
            //   // widget.background = original;
            // }
            
            
          },
          child: Row(
            children: [
              Container(
                  width: 21,
                  color: color.value == null ? widget.background : color.value,
                  child: Center(
                    child: Text(
                      widget.string + '${widget.seatNumber.toString()} ',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )),
              SizedBox(width: 1)
            ],
          ),
        );
      },
    );
  }

  @override
  SeatProvider initProverder() {
    return SeatProvider(this);
  }
}
