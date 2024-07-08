import 'dart:io';

import 'package:black_box/models/item.dart';
import 'package:black_box/providers/items_provider.dart';
import 'package:black_box/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

/// Service class for items
///
/// This class is responsible for handling all the business logic related to items
class ItemsService {
  static Future<void> _saveImage(Item item, XFile image) async {
    // Copy image to new path
    File(image.path).copySync(item.file.path);
  }

  static Future<void> saveItem(
    BuildContext context,
    Item item,
    XFile image,
    bool editMode,
  ) async {
    // Save to database
    await DbService().saveItem(item);

    // Save image
    await _saveImage(item, image);

    // Remove the image from cache
    // Source: https://github.com/flutter/flutter/issues/24858
    imageCache.evict(FileImage(item.file));

    // Add to provider
    final itemsProvider = context.read<ItemsProvider>();
    if (editMode) {
      itemsProvider.removeItem(item.id);
    }
    itemsProvider.addItem(item);
  }

  static Future<bool> isIdAvailable(String id) async {
    return await DbService().isIdAvailable(id);
  }
}
