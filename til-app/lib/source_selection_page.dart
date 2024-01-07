import 'package:flutter/material.dart';

import 'package:til_app/logic/logic_thing.dart';

class SourceSelectionPage extends StatefulWidget {
  const SourceSelectionPage({super.key});

  @override
  State<SourceSelectionPage> createState() => _SourceSelectionPageState();
}

class _SourceSelectionPageState extends State<SourceSelectionPage> {
  String _value = '';

  Future<void> addNewSource() async {
    await LogicThing.shared.openSources(Uri.parse(_value));
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new source'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                _value = value;
                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                border: InputBorder.none,
                hintText: 'URL',
              ),
            ),
            ElevatedButton(
              onPressed: _value.isNotEmpty ? addNewSource : null,
              child: const Text('Get fact!'),
            ),
          ],
        ),
      ),
    );
  }
}
