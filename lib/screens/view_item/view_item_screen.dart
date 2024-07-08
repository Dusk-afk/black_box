import 'package:black_box/models/item.dart';
import 'package:black_box/providers/items_provider.dart';
import 'package:black_box/screens/add_item/add_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewItemScreen extends StatelessWidget {
  final String id;
  const ViewItemScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Item? item = context.watch<ItemsProvider>().getItemById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(item?.name ?? 'Item not found'),
        actions: [
          if (item != null)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(item: item),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
        ],
      ),
      body: item == null
          ? const Center(
              child: Text('Item not found'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  _image(item),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('ID'),
                    subtitle: Text(item.id),
                  ),
                  ListTile(
                    title: const Text('Name'),
                    subtitle: Text(item.name),
                  ),
                  ListTile(
                    title: const Text('Class'),
                    subtitle: Text(item.itemClass),
                  ),
                  ListTile(
                    title: const Text('Room No'),
                    subtitle: Text(item.roomNo.toString()),
                  ),
                  ListTile(
                    title: const Text('Cubic No'),
                    subtitle: Text(item.cubicleNo.toString()),
                  ),
                  ListTile(
                    title: const Text('Drawer No'),
                    subtitle: Text(item.drawerNo.toString()),
                  ),
                  ListTile(
                    title: const Text('Ownership'),
                    subtitle: Text(item.ownership),
                  ),
                  ListTile(
                    title: const Text('Usage Status'),
                    subtitle: Text(item.usageStatus),
                  ),
                  ListTile(
                    title: const Text('Working Status'),
                    subtitle: Text(item.workingStatus),
                  ),
                  ListTile(
                    title: const Text('Quantity'),
                    subtitle: Text(item.quantity.toString()),
                  ),
                  ListTile(
                    title: const Text('Price'),
                    subtitle: Text(item.price.toString()),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _image(Item item) {
    if (item.file.existsSync()) {
      return Hero(
        tag: item.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 300,
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
