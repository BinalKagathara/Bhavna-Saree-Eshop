import 'package:flutter/foundation.dart';

class ItemQuantity with ChangeNotifier
{
  int _numberOfItem = 0;

  int get numberOfItem => _numberOfItem;

  display(int no)
  {
    _numberOfItem = no;
    notifyListeners();
  }

}
