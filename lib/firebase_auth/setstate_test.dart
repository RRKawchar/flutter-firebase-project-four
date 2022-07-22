import 'package:flutter/material.dart';

class SetStateTest extends StatefulWidget {
  const SetStateTest({Key? key}) : super(key: key);

  @override
  State<SetStateTest> createState() => _SetStateTestState();
}

class _SetStateTestState extends State<SetStateTest> {
  String title = "My favorite fruit is ";
  String fruit = " unknown!";

  callBack(varFruit){
    setState((){
      fruit=varFruit;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title + fruit),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              FruitButton(fruit: "Orange", callback: callBack),
              FruitButton(fruit: "Apples", callback: callBack),
              FruitButton(fruit: "Bananas", callback: callBack),
              FruitButton(fruit: "Mango", callback: callBack),
              FruitButton(fruit: "JackFruit", callback: callBack),

            ],
          ),
        ),
      ),
    );
  }
}
class FruitButton extends StatelessWidget {
 String fruit;
 Function callback;
 FruitButton({super.key, required this.fruit,required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          callback(fruit);
        },
        child: Text(fruit)
    );
  }
}
