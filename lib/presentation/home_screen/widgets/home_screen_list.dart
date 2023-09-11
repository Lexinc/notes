// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes/presentation/note_screen/utilities/file_handing_hive.dart';

class HomeScreenList extends StatelessWidget {
  const HomeScreenList({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
        future: FileHandlingModel().read(index),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                child: LoadingAnimationWidget.waveDots(
                    color: Colors.white, size: 40),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String> errorValues = [
              'Data not found',
              'Data not found',
              'Data not found'
            ];
            List<String> values = snapshot.data ?? errorValues;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: Text(
                  values[0],
                  style: theme.textTheme.titleSmall,
                ),
                trailing: IconButton(
                    alignment: Alignment.center,
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      size: 28,
                    )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      values[1],
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      values[2],
                      style: theme.textTheme.labelSmall,
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
