import 'package:flutter/cupertino.dart';

class LoadingProvider with ChangeNotifier {
  int _loadingPercentage = 0;

  int get loadingPercentage {
    return _loadingPercentage;
  }

  void setLoadingPercentage(int percentage) {
    _loadingPercentage = percentage;
    notifyListeners();
  }
}
