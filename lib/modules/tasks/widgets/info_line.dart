import 'package:flutter/material.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';

class InfoLine extends StatelessWidget {
  final String? label;
  final String value;
  const InfoLine({super.key, this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: label != null && label?.isNotEmpty == true,
          child: Text(
            label ?? '',
            textAlign: TextAlign.start,
            style: Styles.bodySmall,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: label != null ? TextAlign.end : TextAlign.start,
            style: Styles.bodySmall,
          ),
        ),
      ],
    );
  }
}
