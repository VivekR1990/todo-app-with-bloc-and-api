import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_bloc/home_bloc.dart';
import '../home/home_bloc/home_event.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    super.key,
    required this.id,
    required this.note,
  });

  final String id;
  final Map note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<HomeBloc>()
          .add(UpdateNavigationEvent(id: id, map: note)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.brown, width: 4),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      note['title'] ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(ShowDialogEvent());
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                      ))
                ],
              ),
              Flexible(
                  child: Text(note['description'] ?? '',
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14))),
            ],
          ),
        ),
      ),
    );
  }
}
