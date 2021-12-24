import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/widget.dart';

class DirectionsView extends StatelessWidget {
  const DirectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomListWidget(
      icon: Icons.location_on_outlined,
      type: 'http',
    );
  }
}
