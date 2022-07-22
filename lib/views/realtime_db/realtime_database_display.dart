import 'package:flutter/material.dart';

class RealTimeDatabaseDisplay extends StatefulWidget {
  const RealTimeDatabaseDisplay({Key? key}) : super(key: key);

  @override
  State<RealTimeDatabaseDisplay> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<RealTimeDatabaseDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Text("")
      ),
    );
  }
}
