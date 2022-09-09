import "package:flutter/material.dart";
import '../../constants.dart';

class ChecklistItem extends StatelessWidget {

  final Widget body;
  final bool selected;
  final Function onTap;
  final bool disabled;

  const ChecklistItem({Key? key, required this.body, required this.onTap, this.selected = false, this.disabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? () {} : () {onTap();},
      hoverColor: disabled ? const Color(0x00000000) : Palette.lightTwo.withOpacity(0.5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Transform.scale(
              scale: 2,
              child: Checkbox(
                value: selected,
                onChanged: (value) {onTap();},
                fillColor: MaterialStateProperty.all<Color>(Palette.accent),
                splashRadius: 0,
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}