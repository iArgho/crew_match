import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(DateTime?)? onDateSelected;

  const DatePickerFormField({
    Key? key,
    required this.controller,
    this.hintText = 'Select a date',
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: _pickDate,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFD30579)),
      ),
    );
  }
}
