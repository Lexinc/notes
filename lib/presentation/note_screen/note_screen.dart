import 'package:flutter/material.dart';
import 'package:notes/presentation/home_screen/home_screen.dart';
import 'package:notes/utilities/file_handing_hive.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen(
      {super.key,
      this.noteTitleControllerData,
      this.noteTextControllerData,
      this.boxKey});
  final String? noteTitleControllerData;
  final String? noteTextControllerData;
  final int? boxKey;
  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _noteTitleController.text = widget.noteTitleControllerData ?? '';
    _noteTextController.text = widget.noteTextControllerData ?? '';
  }

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
            const SizedBox(
              height: 20,
            ),
            EditTitle(controller: _noteTitleController),
            const SizedBox(
              height: 20,
            ),
            EditText(controller: _noteTextController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if ((widget.noteTextControllerData != null ||
                  widget.noteTitleControllerData != null) &&
              widget.boxKey != null) {
            FileHandlingModel().rewrite(_noteTitleController.text.toString(),
                _noteTextController.text.toString(), widget.boxKey!);
          } else {
            FileHandlingModel().write(_noteTitleController.text.toString(),
                _noteTextController.text.toString());
          }
          Navigator.of(context)
              .pop(MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class EditTitle extends StatefulWidget {
  final TextEditingController _controller;

  const EditTitle({super.key, required TextEditingController controller})
      : _controller = controller;

  @override
  State<EditTitle> createState() => _EditTitleState();
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
        padding: const EdgeInsets.all(16.0),
        child: _isEditing
            ? TextField(
                maxLines: null,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                autofocus: true,
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

  const EditText({super.key, required TextEditingController controller})
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
        padding: const EdgeInsets.all(16.0),
        child: _isEditing
            ? TextField(
                cursorColor: Colors.white,
                autofocus: true,
                decoration: const InputDecoration(
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
