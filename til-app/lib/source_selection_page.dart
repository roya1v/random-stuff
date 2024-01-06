import 'package:flutter/material.dart';

import 'package:til_app/logic_thing.dart';

class SourceSelectionPage extends StatefulWidget {
  const SourceSelectionPage({super.key});

  @override
  State<SourceSelectionPage> createState() => _SourceSelectionPageState();
}

class _SourceSelectionPageState extends State<SourceSelectionPage> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => _value = value,
          ),
          ElevatedButton(
            onPressed: () async {
              await LogicThing.shared.openSources(Uri.parse(_value));
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Get fact!'),
          ),
        ],
      ),
    );
  }
}
