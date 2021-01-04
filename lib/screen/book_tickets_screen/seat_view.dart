import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_application_cnv/base/base_view.dart';
import 'package:movie_application_cnv/screen/book_tickets_screen/seat_provider.dart';
import 'package:provider/provider.dart';

class SeatView extends StatefulWidget {
  final Color background;
  final String string;
  final int seatNumber;
  final String typeOfSeat;
  final Function(String, int) onTapSeat;

  const SeatView(
      {Key key,
      this.background,
      this.string,
      this.seatNumber,
      this.onTapSeat,
      this.typeOfSeat})
      : super(key: key);
  @override
  _SeatViewState createState() => _SeatViewState();
}

class _SeatViewState extends BaseView<SeatView, SeatProvider> {
  String typeOfSeat;
  @override
  void initState() {
    super.initState();
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
            if (provider.selectedList
                .contains(widget.string + widget.seatNumber.toString())) {
              showDialog(
                  context: context,
                  builder: (_) => Container(
                        height: 400,
                        child: AlertDialog(
                          title: Text('Chỗ ngồi đã được đặt'),
                          content: Text('Vui lòng chọn vị trí khác'),
                          actions: <Widget>[
                            Container(
                              child: FlatButton(
                                child: Text('Đóng'.toUpperCase()),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ));
            } else {
              widget.onTapSeat(widget.string, widget.seatNumber);
              provider.setColor();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 15,
                  alignment: Alignment.center,
                  width: 15,
                  color: color.value == null ? widget.background : color.value,
                  child: Text(
                    widget.string + '${widget.seatNumber.toString()} ',
                    style: TextStyle(color: Colors.white, fontSize: 6),
                    textAlign: TextAlign.center,
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
