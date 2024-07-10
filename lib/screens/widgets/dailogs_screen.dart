import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_bloc/home_bloc.dart';
import '../home/home_bloc/home_event.dart';

Future<void> alertMessage(BuildContext context, String id) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do you want to delete'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () => delete(context, id),
                child: const Text('Delete')),
          ],
        );
      });
}

void delete(BuildContext context, String id) {
  context.read<HomeBloc>().add(DeleteNoteEvent(id: id));
  Navigator.of(context).pop();
  context.read<HomeBloc>().add(FetchSuccessEvent());
}
