import 'package:black_box/models/item.dart';
import 'package:black_box/services/db_service.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class ItemsProvider with ChangeNotifier {
  List<Item> _items = [];
  List<Item> get items => _items;

  Future<void> loadItems() async {
    print('Loading items');
    _items = await DbService().loadItems();
    print('Loaded items');
    notifyListeners();
  }

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Item? getItemById(String id) {
    return _items.firstWhereOrNull((item) => item.id == id);
  }
}
