import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String txt;
  final IconData icon;
  final VoidCallback onClicked;
  const ListTileWidget({Key? key,required this.txt,required this.icon,required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        txt,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
      ),
      leading: Icon(icon,size: 28,color: Colors.black,),
      onTap: onClicked,
    );
  }
}
