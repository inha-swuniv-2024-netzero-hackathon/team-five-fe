import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proto_just_design/model/global/misiklist.dart';

class MisiklistAddButton extends StatefulWidget {
  final Misiklist misiklist;
  const MisiklistAddButton({required this.misiklist, super.key});

  @override
  State<MisiklistAddButton> createState() => _MisiklistAddButtonState();
}

class _MisiklistAddButtonState extends State<MisiklistAddButton> {
  @override
  Widget build(BuildContext context) {
    late Misiklist misiklist = widget.misiklist;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        print(1);
      },
      child: SizedBox(
        width: 82,
        child: Column(
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber,
                  image: DecorationImage(
                      image: NetworkImage(misiklist.profileImage),
                      fit: BoxFit.cover)),
            ),
            Text(
              misiklist.title,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(10)
          ],
        ),
      ),
    );
  }
}
