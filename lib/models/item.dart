import 'dart:io';

import 'package:black_box/data/global.dart';
import 'package:path/path.dart';

class Item {
  final String id;
  final String itemClass;
  final String name;
  final int roomNo;
  final int cubicleNo;
  final int drawerNo;
  final String ownership;
  final String usageStatus;
  final String workingStatus;
  final double quantity;
  final double price;
  final File file;

  Item({
    required this.id,
    required this.itemClass,
    required this.name,
    required this.roomNo,
    required this.cubicleNo,
    required this.drawerNo,
    required this.ownership,
    required this.usageStatus,
    required this.workingStatus,
    required this.quantity,
    required this.price,
  }) : file = File(join(appDir.path, id));

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      itemClass: json['item_class'],
      name: json['name'],
      roomNo: json['room_no'],
      cubicleNo: json['cubicle_no'],
      drawerNo: json['drawer_no'],
      ownership: json['ownership'],
      usageStatus: json['usage_status'],
      workingStatus: json['working_status'],
      quantity: json['quantity'].toDouble(),
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_class': itemClass,
      'name': name,
      'room_no': roomNo,
      'cubicle_no': cubicleNo,
      'drawer_no': drawerNo,
      'ownership': ownership,
      'usage_status': usageStatus,
      'working_status': workingStatus,
      'quantity': quantity,
      'price': price,
    };
  }
}
