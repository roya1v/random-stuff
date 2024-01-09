import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:til_app/logic/logic_thing.dart';
import 'package:til_app/logic/model.dart';

class TilCubit extends Cubit<Til?> {
  TilCubit() : super(null);

  void loadNew() async {
    final til = await LogicThing.shared.getTil();
    emit(til);
  }
}
