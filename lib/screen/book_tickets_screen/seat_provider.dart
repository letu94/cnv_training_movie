import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SeatProvider extends BaseProvider {
  SeatProvider(State<StatefulWidget> state) : super(state);
  final ColorSeatNotifier _colorSeat = ColorSeatNotifier(null);

  @override
  List<BaseNotifier> initNotifiers() {
    return [_colorSeat];
  }

  void setColor() {
    if (_colorSeat.value != null) {
      _colorSeat.value = null;
    } else {
      _colorSeat.value = Colors.white;
    }
  }

  bookSeat() {}

  colorOriginal() {}
}

class ColorSeatNotifier extends BaseNotifier<Color> {
  ColorSeatNotifier(Color value) : super(value);

  @override
  SingleChildWidget provider() {
    return ChangeNotifierProvider<ColorSeatNotifier>(create: (_) => this);
  }
}
