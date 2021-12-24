import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigatorbarWidget extends StatelessWidget {
  const CustomNavigatorbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final int currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      onTap: (int index) => uiProvider.selectedMenuOpt = index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration_outlined),
          label: 'Direcciones',
        )
      ],
    );
  }
}
