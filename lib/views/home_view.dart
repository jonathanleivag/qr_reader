import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/views/view.dart';
import 'package:qr_reader/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return uiProvider.isReady
        ? const Scaffold(
            appBar: _AppBar(),
            body: _HomeBody(),
            bottomNavigationBar: CustomNavigatorbarWidget(),
            floatingActionButton: ScanButtonWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          )
        : Container();
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);

    void _deleteAllScan(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¿Quiere eliminar todo los scaner?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                scanProvider.deleteAllScan();
              },
              child: const Text('Eliminar'),
            ),
          ],
        ),
      );
    }

    Widget _buttomDelete() => scanProvider.scans.isNotEmpty
        ? IconButton(
            onPressed: () => _deleteAllScan(context),
            icon: const Icon(Icons.delete_forever_outlined))
        : Container();

    Future<void> _changeTheme(ThemeMode theme) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      switch (theme) {
        case ThemeMode.dark:
          uiProvider.changeTheme(ThemeMode.light);
          prefs.setString('theme', 'light');
          break;
        case ThemeMode.light:
          uiProvider.changeTheme(ThemeMode.system);
          prefs.setString('theme', 'system');
          break;
        case ThemeMode.system:
          uiProvider.changeTheme(ThemeMode.dark);
          prefs.setString('theme', 'dark');

          break;
        default:
          uiProvider.changeTheme(ThemeMode.light);
          prefs.setString('theme', 'light');
      }
    }

    IconData _iconTheme(ThemeMode theme) {
      IconData icon = Icons.light;
      switch (theme) {
        case ThemeMode.dark:
          icon = Icons.dark_mode;
          break;
        case ThemeMode.light:
          icon = Icons.light_mode;
          break;
        case ThemeMode.system:
          icon = Icons.auto_awesome;
          break;
        default:
          icon = Icons.light_mode;
      }
      return icon;
    }

    IconButton _buttonChangeTheme(UiProvider uiProvider) {
      return IconButton(
        onPressed: () {
          _changeTheme(uiProvider.theme!);
          print(uiProvider.theme);
        },
        icon: Icon(_iconTheme(uiProvider.theme!)),
      );
    }

    return AppBar(
      title: const Text('Historial'),
      elevation: 0,
      actions: [
        _buttomDelete(),
        const SizedBox(
          width: 10,
        ),
        _buttonChangeTheme(uiProvider),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    Widget view = const MapsView();
    final int currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        scanProvider.loadForTypeScans('geo');
        view = const MapsView();
        break;
      case 1:
        scanProvider.loadForTypeScans('http');
        view = const DirectionsView();
        break;
      default:
        scanProvider.loadForTypeScans('geo');
        view = const MapView();
    }
    return view;
  }
}
