import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:til_app/logic/model.dart';
import 'package:til_app/source_selection_page.dart';
import 'package:til_app/til_cubit.dart';

class FactsPage extends StatelessWidget {
  const FactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SourceSelectionPage())),
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_downward),
        onPressed: () => context.read<TilCubit>().loadNew(),
      ),
      body: BlocBuilder<TilCubit, Til?>(
        builder: (context, state) {
          if (state != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarkdownWidget(shrinkWrap: true, data: state.content),
            );
          } else {
            return const Center(
              child: Text('Click the button to load a new fact!'),
            );
          }
        },
      ),
    );
  }
}
