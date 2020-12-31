import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

abstract class BaseNotifier<T> extends ChangeNotifier {
  BaseNotifier(T value) {
    this._value = value;
  }

  T _value;

  T get value => _value;

  set value(T value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }

  SingleChildWidget provider();
}
