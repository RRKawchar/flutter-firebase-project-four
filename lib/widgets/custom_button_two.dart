import 'package:flutter/material.dart';

class CustomButtonTwo extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onclicked;

  const CustomButtonTwo({Key? key,
  required this.icon,
    required this.text,
    required this.onclicked

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.amber,

        ),
        onPressed: onclicked, child: Row(
      children: [
        Icon(icon,size: 28,),
        const SizedBox(width: 20,),
        Text(text),
      ],
    )
    );
  }
}
