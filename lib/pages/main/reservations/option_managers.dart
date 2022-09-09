import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:intl/intl.dart";

abstract class OptionManager {
  TextFormField? textFormField = TextFormField();
  final BuildContext context;
  final Function onValueUpdated;
  OptionManager({required this.context, required this.onValueUpdated});
}

class IntOptionManager extends OptionManager {
  final int min;
  final int max;
  final TextEditingController textController = TextEditingController();
  int _value = 0;

  set value(int newValue) {
    _value = newValue;
    textController.text = _value.toString();
    onValueUpdated(_value);
  }

  int get value {
    return _value;
  }

  IntOptionManager({this.min = 0, this.max = 5, required textFormFieldStyle, required BuildContext context, required Function onValueUpdated, required int initialValue}) : super(context: context, onValueUpdated: onValueUpdated) {
    textFormField = TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r"[0-9]")) ],
      style: textFormFieldStyle,
      onEditingComplete: onEditingComplete,
      controller: textController,
      textAlign: TextAlign.center,
    );
    _value = initialValue;
    textController.text = initialValue.toString();
  }

  void onEditingComplete() {
    value = int.parse(textController.text).clamp(min, max);
  }
}

class TimeOptionManager extends OptionManager {
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController textController = TextEditingController();

  set selectedTime(TimeOfDay newSelectedTime) {
    _selectedTime = newSelectedTime;
    textController.text = _selectedTime.format(context);
    onValueUpdated(_selectedTime);
  }

  TimeOfDay get selectedTime {
    return _selectedTime;
  }

  TimeOptionManager({required BuildContext context, required TextStyle textFormFieldStyle, required Function onValueUpdated, required TimeOfDay initialValue}) : super(context: context, onValueUpdated: onValueUpdated) {
    textFormField = TextFormField(
      style: textFormFieldStyle,
      onTap: onTap,
      readOnly: true,
      controller: textController,
      textAlign: TextAlign.center,
    );
    _selectedTime = initialValue;
    textController.text = selectedTime.format(context);
  }

  void onTap() async {
    TimeOfDay? resultingTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    selectedTime = resultingTime ?? selectedTime;
  }
}

class DateOptionManager extends OptionManager {
  DateTime _selectedDate = DateTime.now();
  TextEditingController textController = TextEditingController();

  set selectedDate(newSelectedDate) {
    _selectedDate = newSelectedDate;
    textController.text = DateFormat("yyyy-MM-dd").format(_selectedDate);
    onValueUpdated(_selectedDate);
  }

  DateTime get selectedDate {
    return _selectedDate;
  }

  DateOptionManager({required BuildContext context, required TextStyle textFormFieldStyle, required Function onValueUpdated, required DateTime initialValue}) : super(context: context, onValueUpdated: onValueUpdated) {
    textFormField = TextFormField(
      style: textFormFieldStyle,
      onTap: onTap,
      readOnly: true,
      controller: textController,
      textAlign: TextAlign.center,
    );
    _selectedDate = initialValue;
    textController.text = DateFormat("yyyy-MM-dd").format(selectedDate);
  }

  void onTap() async {
    DateTime? resultingDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 100)),
    );
    selectedDate = resultingDate ?? selectedDate;
  }
}