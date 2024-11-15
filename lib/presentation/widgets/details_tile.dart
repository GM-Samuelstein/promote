import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    super.key,
    required this.header,
    required this.detail,
  });

  final String header;
  final String detail;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0XFFE9EAEC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0XFF162D4C),
            ),
          ),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0XFF898A8D),
            ),
          ),
        ],
      ),
    );
  }
}
