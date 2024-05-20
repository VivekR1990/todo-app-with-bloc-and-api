import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_bloc/home_bloc.dart';
import '../home/home_bloc/home_event.dart';
import 'edit_bloc/edit_bloc.dart';
import 'edit_bloc/edit_event.dart';
import 'edit_bloc/edit_state.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();
final formKey = GlobalKey<FormState>();

class EDITSCREEN extends StatefulWidget {
  const EDITSCREEN({super.key, required this.id, required this.map});

  final String id;
  final Map map;

  @override
  State<EDITSCREEN> createState() => _EDITSCREENState();
}

class _EDITSCREENState extends State<EDITSCREEN> {
  @override
  void initState() {
    super.initState();
    final note = widget.map;
    titleController.text = note['title'];
    descriptionController.text = note['description'];
  }

  @override
  void dispose() {
    super.dispose();
    titleController.text = '';
    descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.amber[100],
              )),
          title: Text(
            'EDIT SCREEN',
            style: TextStyle(
                color: Colors.amber[100],
                fontWeight: FontWeight.bold,
                letterSpacing: 5),
          ),
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body: BlocConsumer<EditBloc, EditState>(
          listener: (context, state) {
            if (state is EditSuccessState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Text(
                  'Update Successfull',
                  style: TextStyle(color: Colors.white),
                ),
              ));
              context.read<HomeBloc>().add(FatchSuccessEvent());
            } else if (state is EditFaildState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.red,
                  content: Text(
                    "did npt upate",
                    style: TextStyle(color: Colors.white),
                  )));
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        validator: (value) => titleController.text.isEmpty
                            ? 'please enter a title'
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 30),
                      child: SizedBox(
                        height: 220,
                        child: TextFormField(
                          controller: descriptionController,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Note',
                          ),
                          validator: (value) => titleController.text.isEmpty
                              ? 'please enter a note'
                              : null,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 20),
                              elevation: 10,
                              backgroundColor: Colors.brown),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              update(context, widget.id);
                            }
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.amber[100],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 20),
                                elevation: 10,
                                backgroundColor: Colors.brown),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                update(context, widget.id);
                              }
                            },
                            child: Text('Patch',
                                style: TextStyle(
                                    color: Colors.amber[100],
                                    fontWeight: FontWeight.bold))),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  void update(BuildContext context, String id) {
    final title = titleController.text;
    final description = descriptionController.text;

    final map = {
      'title': title,
      'description': description,
    };
    context.read<EditBloc>().add(EditNoteEvent(id: id, map: map));
  }
}
