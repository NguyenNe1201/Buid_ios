import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buildContentDataCell extends StatelessWidget {
  final String content;
  const buildContentDataCell({
    super.key, required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(content));
  }
}
 class buildTitleDataColumn extends StatelessWidget {
  final String name_title1;
  final String name_title2;
  const buildTitleDataColumn({super.key, required this.name_title1,required this.name_title2});

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
     // child: Expanded(
        child: Center(
          child: Column(
            children: [
              Text(
                name_title1,
                style: TextStyle(
                 // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                  fontSize: 17,
                ),
              ),
               Text(
                name_title2,
                style: TextStyle(
                 // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
     // ),
    );
  }
}