import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:til_app/logic_thing.dart';
import 'package:til_app/source_selection_page.dart';

class FactsPage extends StatefulWidget {
  const FactsPage({super.key});

  @override
  State<FactsPage> createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  String? _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_content != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MarkdownWidget(shrinkWrap: true, data: _content!),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _content = await LogicThing.shared.getTil();
                    setState(() {});
                  },
                  child: const Text('Get fact!'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SourceSelectionPage()));
                  },
                  child: const Text('Add sources'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
