import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onclicked;
  final FontWeight fontWeight;
  final double size;
  final Color color;
  const CustomButton({Key? key,
  required this.text,
    required this.icon,
    required this.onclicked,
    required this.fontWeight,
    required this.size,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal.shade700,
        onPrimary: Colors.white
      ),
      onPressed: onclicked, child: Row(
      children: [
        Icon(icon,size: 30,color: Colors.white,),
        const SizedBox(width: 20,),
        Text(text,style: TextStyle(fontWeight:fontWeight,color: color,fontSize: size ),)
      ],
    ),

    );
  }

}
