import 'package:flutter/material.dart';

Flexible buttons(BuildContext context, VoidCallback onpress, Widget title) {
    return Flexible(
      flex: 1,
        child: InkWell(
      onTap: () {
        onpress();
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.07,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xffbde0fe).withOpacity(.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xff507dbc), width: 3)),
        child: FittedBox(
            child: title),
      ),
    ));
  }