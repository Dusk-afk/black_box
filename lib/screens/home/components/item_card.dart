import 'package:black_box/models/item.dart';
import 'package:black_box/screens/view_item/view_item_screen.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewItemScreen(id: item.id),
          ),
        );
      },
      leading: _image(),
      title: Text(item.name),
      subtitle: Text(item.itemClass),
    );
  }

  Widget _image() {
    if (item.file.existsSync()) {
      return Hero(
        tag: item.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.file(
              item.file,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return const Icon(Icons.image);
  }
}
