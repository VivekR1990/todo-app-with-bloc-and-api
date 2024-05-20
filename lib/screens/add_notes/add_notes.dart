import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_bloc/home_bloc.dart';
import '../home/home_bloc/home_event.dart';
import 'add_note_bloc/add_bloc.dart';
import 'add_note_bloc/add_event.dart';
import 'add_note_bloc/add_state.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();
final formKey = GlobalKey<FormState>();

class ScreenAddForm extends StatelessWidget {
  const ScreenAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon:  Icon(
              Icons.arrow_back_ios,
              color: Colors.amber[100],
            )),
        title:  Text(
          'ADD NOTES',
          style: TextStyle(
              color: Colors.amber[100],
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: BlocConsumer<AddBloc, AddState>(
        buildWhen: (previous, current) => current is! AddActionState,
        listenWhen: (previous, current) => current is AddActionState,
        listener: (context, state) {
          if (state is AddNoteSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Text(
                  "Note Added Successfuly!!",
                  style: TextStyle(color: Colors.white),
                )));
            context.read<HomeBloc>().add(FatchSuccessEvent());
          } else if (state is AddNoteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
                content: Text(
                  "Cancelled !!",
                  style: TextStyle(color: Colors.white),
                )));
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Title',
                        hintStyle: TextStyle(fontSize: 18)),
                    validator: (value) => titleController.text.isEmpty
                        ? 'Please enter a title'
                        : null,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Description',
                        hintStyle: TextStyle(fontSize: 18)),
                    validator: (value) => descriptionController.text.isEmpty
                        ? 'Please enter a description'
                        : null,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10, backgroundColor: Colors.brown),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          submitData(context);
                        }
                      },
                      child:  Text('Submit',
                          style: TextStyle(
                              color: Colors.amber[100],
                              fontWeight: FontWeight.bold,
                              fontSize: 16))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void submitData(BuildContext context) {
  final title = titleController.text;
  final description = descriptionController.text;
  final map = {
    "title": title,
    "description": description,
    "is_completed": false
  };
  context.read<AddBloc>().add(AddNoteEvent(map: map));
  titleController.text = '';
  descriptionController.text = '';
}
