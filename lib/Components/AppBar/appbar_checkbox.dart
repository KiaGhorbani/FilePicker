import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ABcheckbox extends StatefulWidget {
  final String label;
  final RxBool ischecked;


  const ABcheckbox({
    super.key,
    required this.label,
    required this.ischecked,

  });

  @override
  State<ABcheckbox> createState() => _ABcheckboxState();
}

class _ABcheckboxState extends State<ABcheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.label),
        Obx(() => Checkbox(
          value: widget.ischecked.value,
          onChanged: (newvalue) {
            widget.ischecked.value = newvalue!;
            debugPrint(widget.ischecked.toString());
          },
        )),
      ],
    );
  }
}
