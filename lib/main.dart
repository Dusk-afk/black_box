import 'package:black_box/data/custom_theme.dart';
import 'package:black_box/data/global.dart';
import 'package:black_box/providers/items_provider.dart';
import 'package:black_box/providers/theme_provider.dart';
import 'package:black_box/screens/add_item/add_item_screen.dart';
import 'package:black_box/screens/home/home_screen.dart';
import 'package:black_box/screens/settings/settings_screen.dart';
import 'package:black_box/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appDir = await getApplicationDocumentsDirectory();
  DbService();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ItemsProvider()..loadItems()),
      ],
      builder: (context, _) {
        return MaterialApp(
          themeMode: context.watch<ThemeProvider>().themeMode,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          routes: {
            '/': (context) => const HomeScreen(),
            '/add-item': (context) => const AddItemScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}
