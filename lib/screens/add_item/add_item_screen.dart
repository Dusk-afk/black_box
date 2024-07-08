import 'package:black_box/models/item.dart';
import 'package:black_box/screens/add_item/components/image_card.dart';
import 'package:black_box/services/dialog_service.dart';
import 'package:black_box/services/items_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  final Item? item;
  const AddItemScreen({super.key, this.item});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _idController = TextEditingController();
  String? _itemClass;
  final _nameController = TextEditingController();
  final _roomNoController = TextEditingController();
  int? _cubicleNo;
  int? _drawerNo;
  final _ownershipController = TextEditingController();
  final _usageStatusController = TextEditingController();
  String? _workingStatus;
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  XFile? _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _saving = false;

  bool get _editMode => widget.item != null;

  @override
  void initState() {
    super.initState();
    _setValues();
  }

  void _setValues() {
    if (!_editMode) return;

    final item = widget.item!;
    _idController.text = item.id;
    _itemClass = item.itemClass;
    _nameController.text = item.name;
    _roomNoController.text = item.roomNo.toString();
    _cubicleNo = item.cubicleNo;
    _drawerNo = item.drawerNo;
    _ownershipController.text = item.ownership;
    _usageStatusController.text = item.usageStatus;
    _workingStatus = item.workingStatus;
    _quantityController.text = item.quantity.toString();
    _priceController.text = item.price.toString();

    if (item.file.existsSync()) {
      _image = XFile(item.file.path);
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _roomNoController.dispose();
    _ownershipController.dispose();
    _usageStatusController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Item'),
        ),
        floatingActionButton: SizedBox(
          width: 150,
          child: FloatingActionButton(
            onPressed: _saving ? null : _handleSave,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.save),
                SizedBox(width: 10),
                Text('Save'),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              // Do not dispose any items in the list
              cacheExtent: 1000,
              children: [
                const SizedBox(height: 20),
                ImageCard(
                  image: _image,
                  onImageChanged: (image) {
                    setState(() {
                      _image = image;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  items: ["Consumable", "Equipment", "Sub-Equipment"]
                      .map((itemClass) {
                    return DropdownMenuItem<String>(
                      value: itemClass,
                      child: Text(itemClass),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _itemClass = value;
                    });
                  },
                  value: _itemClass,
                  decoration: const InputDecoration(labelText: 'Item Class'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Item Class';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _roomNoController,
                  decoration: const InputDecoration(labelText: 'Room No'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Room No';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  items: List.generate(8, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      _cubicleNo = value;
                    });
                  },
                  value: _cubicleNo,
                  decoration: const InputDecoration(labelText: 'Cubicle No'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Cubicle No';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  items: List.generate(3, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      _drawerNo = value;
                    });
                  },
                  value: _drawerNo,
                  decoration: const InputDecoration(labelText: 'Drawer No'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Drawer No';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ownershipController,
                  decoration: const InputDecoration(labelText: 'Ownership'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Ownership';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usageStatusController,
                  decoration: const InputDecoration(labelText: 'Usage Status'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Usage Status';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  items: ["Fully", "Partially", "Not Working"]
                      .map((workingStatus) {
                    return DropdownMenuItem<String>(
                      value: workingStatus,
                      child: Text(workingStatus),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _workingStatus = value;
                    });
                  },
                  value: _workingStatus,
                  decoration:
                      const InputDecoration(labelText: 'Working Status'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Working Status';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Quantity';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    if (_image == null) {
      DialogService.showErrorDialog(context, 'Please add an image');
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      if (!_editMode) {
        bool isIdAvailable =
            await ItemsService.isIdAvailable(_idController.text);
        if (!isIdAvailable) {
          throw 'ID already exists';
        }
      }

      final id = _idController.text;
      final itemClass = _itemClass!;
      final name = _nameController.text;
      final roomNo = int.parse(_roomNoController.text);
      final cubicleNo = _cubicleNo!;
      final drawerNo = _drawerNo!;
      final ownership = _ownershipController.text;
      final usageStatus = _usageStatusController.text;
      final workingStatus = _workingStatus!;
      final quantity = double.parse(_quantityController.text);
      final price = double.parse(_priceController.text);

      // Save the item to the database
      Item item = Item(
        id: id,
        itemClass: itemClass,
        name: name,
        roomNo: roomNo,
        cubicleNo: cubicleNo,
        drawerNo: drawerNo,
        ownership: ownership,
        usageStatus: usageStatus,
        workingStatus: workingStatus,
        quantity: quantity,
        price: price,
      );

      await ItemsService.saveItem(context, item, _image!, _editMode);
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      DialogService.showErrorDialog(context, e);
      return;
    } finally {
      setState(() {
        _saving = false;
      });
    }

    Navigator.pop(context);
  }
}
