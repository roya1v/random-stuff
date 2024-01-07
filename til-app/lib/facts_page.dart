import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:til_app/logic/logic_thing.dart';
import 'package:til_app/source_selection_page.dart';

class FactsPage extends StatefulWidget {
  const FactsPage({super.key});

  @override
  State<FactsPage> createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  String? _name;
  String? _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name ?? ''),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SourceSelectionPage())),
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_downward),
        onPressed: () async {
          final til = await LogicThing.shared.getTil();
          _content = til.content;
          _name = til.category;
          setState(() {});
        },
      ),
      body: _content != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarkdownWidget(shrinkWrap: true, data: _content!),
            )
          : const Center(
              child: Text('Click the button to load a new fact!'),
            ),
    );
  }
}
