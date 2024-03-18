import 'package:flutter/material.dart';
import 'package:proto_just_design/class/misiklist_class.dart';

class MisiklistAddButton extends StatefulWidget {
  final Misiklist misiklist;
  const MisiklistAddButton({required this.misiklist, super.key});

  @override
  State<MisiklistAddButton> createState() => _MisiklistAddButtonState();
}

class _MisiklistAddButtonState extends State<MisiklistAddButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        print(1);
      },
      child: Container(
        width: 82,
        height: 82,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.amber),
      ),
    );
  }
}
