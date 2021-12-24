import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/utils/utils.dart';

class CustomListWidget extends StatelessWidget {
  final IconData icon;
  final String type;
  const CustomListWidget({Key? key, required this.icon, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    final scans = scanProvider.scans;

    ListTile _list(BuildContext context, List<ScanModel> scans, int index) {
      return ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scans[index].valor),
        subtitle: Text('ID: ${scans[index].id}'),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => launchUrl(context, scans[index]),
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) => _ActionDelete(
        id: scans[index].id!,
        type: type,
        valor: scans[index].valor,
        child: _list(context, scans, index),
      ),
      itemCount: scans.length,
    );
  }
}

class _ActionDelete extends StatelessWidget {
  final Widget child;
  final String valor;
  final String type;
  final int id;

  const _ActionDelete({
    Key? key,
    required this.child,
    required this.valor,
    required this.type,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('Eliminar'),
            Icon(Icons.delete_forever_outlined),
            SizedBox(width: 20)
          ],
        ),
      ),
      onDismissed: (direction) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('¿Quiere eliminar $valor?'),
            actions: [
              TextButton(
                onPressed: () {
                  scanProvider.loadForTypeScans(type);
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  scanProvider.deleteScan(id);
                },
                child: const Text('Eliminar'),
              ),
            ],
          ),
        );
      },
      child: child,
    );
  }
}
