import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_application_cnv/base/base_provider.dart';
import 'package:provider/provider.dart';

abstract class BaseView<S extends StatefulWidget, T extends BaseProvider>
    extends State<S> {
      /// Class BaseView la 1 State co chua 2 kieu du lieu S, T
      /// T la 1 Kieu Provierder muc dich cua BaseProvider la tra ve 1 State
      /// Khai bao 1 doi tuong T, T nay la Class khac ben ngoai
  T _provider;
  /// tra ve list kieu T provider
  T initProverder();  

///  tra ve kieu T provider
  T get provider => _provider;

  @override
  void initState() {
    super.initState();
    /// gan gia tri cho bien _provider roi get no ra
    this._provider = initProverder();
  }
/// widet body nay de dua vao State. Ban chat cua no la 1 state
  Widget body();

  @override
  Widget build(BuildContext context) {
    /// do T _provider extend BaseProvider nen no co providers
    return MultiProvider(
        providers: _provider.providers,
        /// Stack de chong ghep v loading
        child: Stack(
          alignment: Alignment.center,
          children: [body(), buildLoading()],
        ));
  }

/// Consumer la gi?? Neu no dung thi tiep tuc _buildLoading: neu sai thi SizedBox
  Widget buildLoading() {
    return Consumer<LoadingNotifier>(builder: (context, notifier, _) {
      return notifier.value ? _buildLoading() : SizedBox();
    });
  }
/// _buildLoading check dieu kien fltform de tra ve, muc dich tach logic code gon hon
  Widget _buildLoading() {
    return Container(
              alignment: Alignment.center,
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            );
  }
}
