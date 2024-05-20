import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../api_functions/api_function.dart';
part 'patch_event.dart';
part 'patch_state.dart';

class PatchBloc extends Bloc<PatchEvent, PatchState> {
  PatchBloc() : super(PatchInitial()) {
    on<PatchEvent>((event, emit) {});
  }
  FutureOr<void> editPatchEvent(
      EditPatchEvent event, Emitter<PatchState> emit) async {
    final isSuccessful = await Api.patchUpdate(event.id, event.map);
    if (isSuccessful) {
      emit(EditFaildState());
    } else {
      emit(EditFaildState());
    }
  }
}
