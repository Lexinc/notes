// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes/presentation/home_screen/widgets/home_screen_list.dart';
import 'package:notes/presentation/note_screen/utilities/file_handing_hive.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: FileHandlingModel().length(), //
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
          final itemCount = snapshot.data ?? 0;
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                itemCount: itemCount,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return HomeScreenList(index: index);
                },
              ));
        }
      },
    );
  }
}

/* Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          SearchBar(
            hintText: 'Search...',
            constraints: BoxConstraints(maxHeight: 50),
            leading: Icon(
              Icons.search,
            ),
          ),
        ])); */

/* FutureBuilder(
        future: length,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            int snapshotLength = snapshot.data!;
            children = <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SearchBar(
                      hintText: 'Search...',
                      constraints: BoxConstraints(maxHeight: 50),
                      leading: Icon(
                        Icons.search,
                      ),
                    ),
                    ListView.builder(
                        itemBuilder: (BuildContext context, snapshotLength) {
                      return ListTile(
                        trailing: Icon(Icons.delete),
                      );
                    })
                  ],
                ),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Column(
                children: [
                  SearchBar(
                    hintText: 'Search...',
                    constraints: BoxConstraints(maxHeight: 50),
                    leading: Icon(
                      Icons.search,
                    ),
                  ),
                  Text('Somethink went wrong!'),
                ],
              )
            ];
          } else {
            children = <Widget>[
              Column(
                children: [
                  SearchBar(
                    hintText: 'Search...',
                    constraints: BoxConstraints(maxHeight: 50),
                    leading: Icon(
                      Icons.search,
                    ),
                  ),
                  Container(
                    child: LoadingAnimationWidget.waveDots(
                        color: Colors.white, size: 40),
                  ),
                ],
              )
            ];
          }
          return SingleChildScrollView(
            child: Column(
              children: children,
            ),
          );
        }); */
