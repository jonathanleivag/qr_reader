import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/widget.dart';

class MapsView extends StatelessWidget {
  const MapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomListWidget(
      icon: Icons.map_outlined,
      type: 'geo',
    );
  }
}
