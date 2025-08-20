import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/custom_elevated_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<Widget>? actions;
  final Function(bool) onTap;

  const CustomDialog({
    super.key,
    required this.title,
    this.content,
    this.actions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Styles.body,
            ),
            SizedBox(height: 16.h),
            if (content != null) ...[
              Column(
                children: [
                  content!,
                  SizedBox(height: 16.h),
                  CustomElevatedButton(
                    onPressed: () => onTap(true),
                    label: 'Sim',
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52.h,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () => onTap(false),
                            child: Text(
                              'Não',
                              style: Styles.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            if (actions != null) ...[
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
