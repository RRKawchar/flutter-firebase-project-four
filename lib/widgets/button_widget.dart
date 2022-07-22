import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onclicked;
const ButtonWidget({
    Key?key,
  required this.icon,
  required this.text,
  required this.onclicked,
}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      primary:const Color.fromARGB(29, 194, 95, 1),
      minimumSize:const Size.fromHeight(50),
      ),
        onPressed: onclicked, child:buildContent()
    );
  }
  Widget buildContent(){

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,size: 30,),
        const SizedBox(width: 16,),
        Text(text,
        style:const TextStyle(fontSize: 22,color: Colors.white),
        )

      ],
    );
  }
}

