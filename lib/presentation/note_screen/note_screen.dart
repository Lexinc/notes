// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:notes/presentation/home_screen/home_screen.dart';
import 'package:notes/presentation/note_screen/utilities/file_handing_hive.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _noteTitleController = TextEditingController();
  TextEditingController _noteTextController = TextEditingController();
  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Note',
        style: theme.textTheme.headlineLarge,
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            EditTitle(controller: _noteTitleController),
            SizedBox(
              height: 20,
            ),
            EditText(controller: _noteTextController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FileHandlingModel().write(_noteTitleController.text.toString(),
              _noteTextController.text.toString());
          Navigator.of(context)
              .pop(MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

class EditTitle extends StatefulWidget {
  final TextEditingController _controller;

  const EditTitle({required TextEditingController controller})
      : _controller = controller;

  @override
  _EditTitleState createState() => _EditTitleState();
}

class _EditTitleState extends State<EditTitle> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(16.0),
        child: _isEditing
            ? TextField(
                maxLines: null,
                onTapOutside: (_) {
                  setState(() {
                    _isEditing = false;
                  });
                },
                style: TextStyle(
                  color: theme.textTheme.headlineLarge!.color,
                  fontSize: theme.textTheme.headlineLarge!.fontSize,
                ),
                controller: widget._controller,
                onEditingComplete: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
              )
            : Text(
                widget._controller.text.isNotEmpty
                    ? widget._controller.text
                    : 'Title',
                style: TextStyle(
                  fontSize: theme.textTheme.headlineLarge!.fontSize,
                  color: widget._controller.text.isNotEmpty
                      ? theme.textTheme.headlineLarge!.color
                      : theme.hintColor,
                ),
              ),
      ),
    );
  }
}

class EditText extends StatefulWidget {
  final TextEditingController _controller;

  const EditText({required TextEditingController controller})
      : _controller = controller;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(16.0),
        child: _isEditing
            ? TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: theme.textTheme.bodySmall!.color,
                  fontSize: theme.textTheme.bodySmall!.fontSize,
                ),
                maxLines: null,
                onTapOutside: (_) {
                  setState(() {
                    _isEditing = false;
                  });
                },
                controller: widget._controller,
                onEditingComplete: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
                onSubmitted: (_) {
                  setState(() {
                    _isEditing = false;
                  });
                },
              )
            : Text(
                widget._controller.text.isNotEmpty
                    ? widget._controller.text
                    : 'Text',
                style: TextStyle(
                  fontSize: theme.textTheme.bodySmall!.fontSize,
                  color: widget._controller.text.isNotEmpty
                      ? theme.textTheme.bodySmall!.color
                      : theme.hintColor,
                ),
              ),
      ),
    );
  }
}