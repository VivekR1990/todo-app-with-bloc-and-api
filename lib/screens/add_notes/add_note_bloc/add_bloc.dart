import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../api_functions/api_function.dart';
import 'add_event.dart';
import 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddNoteEvent>(addNote);
  }
  FutureOr<void> addNote(AddNoteEvent event, Emitter<AddState> emit) async {
    final isSuccess = await Api.addNote(event.map);

    if (isSuccess) {
      emit(AddNoteSuccessState());
    } else {
      emit(AddNoteErrorState());
    }
  }
}
