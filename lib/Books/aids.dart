import 'package:flutter/material.dart';
import 'package:study_material_app/Animation/CustomWidgets.dart';

class Aids extends StatelessWidget {
  static const String id = 'Aids';
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    String subject = args.subject;

    print(subject);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Background(
                height1: 280.0,
                height2: 150.0,
                height3: 100.0,
                height4: 100.0,
              ),
              CustomTileDesign(
                name: "VIDEO LINK",
              ),
              CustomTileDesign(
                name: "E-BOOK",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String subject;
  ScreenArguments(this.subject);
}
