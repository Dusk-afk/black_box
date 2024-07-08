import 'package:black_box/providers/theme_provider.dart';
import 'package:black_box/services/db_service.dart';
import 'package:black_box/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Export DB'),
            subtitle: const Text('Export the SQLite database to a file'),
            trailing: const Icon(Icons.ios_share),
            onTap: () => _handleExportDB(context),
          ),
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Change the theme of the app'),
            trailing: SizedBox(
              width: 150,
              child: DropdownButtonFormField<ThemeMode>(
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark'),
                  ),
                ],
                value: themeProvider.themeMode ?? ThemeMode.system,
                onChanged: (ThemeMode? value) {
                  themeProvider.themeMode = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleExportDB(BuildContext context) async {
    try {
      final db = await DbService().getDb();
      XFile file = XFile(db.path,
          mimeType: 'application/x-sqlite3', name: 'black_box.db');
      await Share.shareXFiles([file]);
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      DialogService.showErrorDialog(context, e);
    }
  }
}
