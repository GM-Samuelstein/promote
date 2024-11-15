import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.headerText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.hintText,
  });

  final String headerText;
  final String? hintText;
  final String? value;
  final void Function(String?)? onChanged;
  final List<String> items;
  final String? Function(String?)? validator;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Text(
                widget.headerText,
                style: const TextStyle(
                  color: Color(0xFF181818),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        DropdownButtonFormField<String>(
          style: const TextStyle(
            color: Color(0XFFB2B2B2),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            constraints: const BoxConstraints(maxHeight: 50),
            hintText: widget.hintText ?? 'Select Option',
            hintStyle: const TextStyle(
              color: Color(0XFFB2B2B2),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            focusColor: const Color(0xFF162D4C),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFA1A0BD)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFA1A0BD)),
            ),
          ),
          isExpanded: true,
          validator: widget.validator,
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
