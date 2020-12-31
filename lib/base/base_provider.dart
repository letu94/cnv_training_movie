import 'package:flutter/widgets.dart';
import 'package:movie_application_cnv/base/base_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class BaseProvider<T extends State> {
  /// T la 1 State duoc tao ra tu STF Widget
  final T _state;
  BuildContext get context => _state.context;

/// lay contex cua State T
 T get state => _state;
  
  /// constructor cua class
  BaseProvider(this._state);

///  method tra ve 1 list BaseNotifer voi kieu du lieu T
  List<BaseNotifier> initNotifiers();

/// loading khoi tao doi tuong
  final LoadingNotifier _loadingNotifier = LoadingNotifier(false);

/// neu initNotifier null thi no lay []. Tiep tuc lay va map sang kieu doi tuong 
/// SinggleChildWidget va provider no de no tra ve 1 list
  List<SingleChildWidget> get providers =>
      ((initNotifiers() ?? [])..add(_loadingNotifier))
          .map<SingleChildWidget>((n) => n.provider())
          .toList();
          // Iterable<T> map<T>(T f(E e)) => MappedIterable<E, T>(this, f);

/// method showLoading. Value la 1 bien duoc khai bao
  void showLoading(){
    _loadingNotifier.value = true;
  }

  void hiddenLoading(){
    _loadingNotifier.value = false;
  }
}


class LoadingNotifier extends BaseNotifier<bool> {
  LoadingNotifier(bool value) : super(value);

/// method nay tra ve 1 doi tuong la chinh no
  @override
  SingleChildWidget provider() {
    return ChangeNotifierProvider<LoadingNotifier>(create: (_) => this);
  }
}
