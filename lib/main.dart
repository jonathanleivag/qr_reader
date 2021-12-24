import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/views/view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    // }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
      ],
      builder: (context, _) {
        final uiProvider = Provider.of<UiProvider>(context);

        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          initialRoute: 'home_view',
          routes: {
            'home_view': (_) => const HomeView(),
            'map_view': (_) => const MapView()
          },
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: uiProvider.theme,
        );
      },
    );
  }
}
