import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(DateTime?)? onDateSelected;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;

  const DatePickerFormField({
    super.key,
    required this.controller,
    this.hintText = 'Select a date',
    this.onDateSelected,
    this.decoration,
    this.validator,
  });

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.red,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      widget.onDateSelected?.call(picked);
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
      suffixIcon: const Icon(Icons.calendar_today, color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: _pickDate,
      decoration: widget.decoration ?? _inputDecoration(widget.hintText),
      validator: widget.validator,
    );
  }
}
