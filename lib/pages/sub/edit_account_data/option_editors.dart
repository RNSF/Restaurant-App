import "package:flutter/material.dart";
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../constants.dart';
import '../checklist_item.dart';

class PhoneOption extends StatelessWidget {

  final String optionName;
  final String optionValue;
  final Function onValueChanged;
  final bool editable;
  final TextEditingController controller = TextEditingController();

  PhoneOption({Key? key, this.optionName = "", this.optionValue = "", required this.onValueChanged, this.editable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          optionName + ":",
          style: const TextStyle(
            color: Palette.darkOne,
            fontSize: FontSize.smallHeader,
          ),
        ),
        const Expanded(child: SizedBox()),
        SizedBox(
          width: 220,
          child: IntlPhoneField(
            initialValue: optionValue,
            decoration: const InputDecoration(
              fillColor: Palette.lightTwo,
              filled: true,
            ),
            style: const TextStyle(
              color: Palette.darkOne,
            ),
            initialCountryCode: 'CA',
            onChanged: (phone) {
              onValueChanged(phone.completeNumber);
            },
            countries: const ["CA"],
          ),
        )
      ]
    );
  }
}

class EmailOption extends StatefulWidget {
  final String optionName;
  final String optionValue;
  final Function onValueChanged;
  final bool editable;

  const EmailOption({Key? key, this.optionName = "", this.optionValue = "", required this.onValueChanged, this.editable = true}) : super(key: key);

  @override
  State<EmailOption> createState() => _EmailOptionState();
}

class _EmailOptionState extends State<EmailOption> {

  late String optionValue = widget.optionValue;

  @override
  Widget build(BuildContext context) {
    // TODO: finish email is formatted properly
    return Row(
      children: [
        Text(
          widget.optionName + ":",
          style: const TextStyle(
            color: Palette.darkOne,
            fontSize: FontSize.smallHeader,
          ),
        ),
        const Expanded(child: SizedBox()),
        SizedBox(
          width: 220,
          child: TextField(
            controller: TextEditingController()..text = widget.optionValue,
            decoration: const InputDecoration(
              fillColor: Color(0x00000000),
              filled: true,
            ),
            style: const TextStyle(
              color: Palette.darkOne,
            ),
            readOnly: !widget.editable,
          ),
        )
      ]
    );
  }
}

class BoolOption extends StatefulWidget {
  final String optionName;
  final bool optionValue;
  final Function onValueChanged;
  final bool editable;

  const BoolOption({Key? key, this.optionName = "", this.optionValue = false, required this.onValueChanged, this.editable = true}) : super(key: key);

  @override
  State<BoolOption> createState() => _BoolOptionState();
}

class _BoolOptionState extends State<BoolOption> {

  late bool optionValue = widget.optionValue;

  @override
  Widget build(BuildContext context) {
    return ChecklistItem(
      body: Text(
        widget.optionName,
        style: const TextStyle(
          color: Palette.darkOne,
          fontSize: FontSize.smallHeader,
        ),
      ),
      selected: widget.optionValue,
      onTap: () {
        setState(() {
          optionValue = !optionValue;
          widget.onValueChanged(optionValue);
        });

      },
    );
  }
}