import 'package:black_box/models/item.dart';
import 'package:black_box/providers/items_provider.dart';
import 'package:black_box/screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> items = context.watch<ItemsProvider>().items;
    items.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-item');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                'No items found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 100 : 0,
                ),
                child: ItemCard(item: items[index]),
              ),
            ),
    );
  }
}
