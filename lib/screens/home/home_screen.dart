import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../add_notes/add_notes.dart';
import '../edit_screen/edit_screen.dart';
import '../widgets/dailogs_screen.dart';
import '../widgets/note_card_widget.dart';
import 'home_bloc/home_bloc.dart';
import 'home_bloc/home_event.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({
    super.key,
  });

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FatchSuccessEvent());
  }

  late String id;
  late Map note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTES',
          style: TextStyle(
              color: Colors.amber[100],
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,
        listener: (context, state) {
          if (state is FromNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenAddForm(),
                ));
          } else if (state is ShowPopupMessageState) {
            alertMessage(context, id);
          } else if (state is UpdateNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EDITSCREEN(id: state.id, map: state.map),
                ));
          }
        },
        builder: (context, state) {
          if (state is SuccessState) {
            return GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(state.notesList.length, (index) {
                note = state.notesList[index] as Map;
                id = note['_id'];
                return NoteCardWidget(id: id, note: note);
              }),
            );
          } else if (state is LoadingState) {
            return const SizedBox.expand(
                child: Center(child: CircularProgressIndicator()));
          } else {
            return const SizedBox.expand(
              child: Center(
                  child: Text(
                'empty notes',
                style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () => context.read<HomeBloc>().add(FromNavigationEvent()),
        elevation: 20,
        child: Icon(Icons.add, color: Colors.amber[100]),
      ),
    );
  }
}
