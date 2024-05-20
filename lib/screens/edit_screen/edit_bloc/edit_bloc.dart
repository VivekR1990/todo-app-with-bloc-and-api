import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../api_functions/api_function.dart';
import 'edit_event.dart';
import 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditInitial()) {
    on<EditNoteEvent>(editNoteEvent);
  }

  FutureOr<void> editNoteEvent(
      EditNoteEvent event, Emitter<EditState> emit) async {
    final isSuccess = await Api.updateNote(event.id, event.map);
    if (isSuccess) {
      emit(EditSuccessState());
    } else {
      emit(EditFaildState());
    }
  }
}
