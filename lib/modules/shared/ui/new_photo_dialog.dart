import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/custom_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class NewPhotoDialog extends StatelessWidget {
  final Function(XFile)? onNewPhoto;
  const NewPhotoDialog({
    super.key,
    this.onNewPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Adicionar foto',
      actions: [
        TextButton(
          onPressed: () {
            ImagePicker()
                .pickImage(
              source: ImageSource.gallery,
            )
                .then((image) {
              if (image != null) {
                onNewPhoto?.call(image);
              }
            });
            Modular.to.pop();
          },
          child: Row(
            children: [
              Icon(
                FeatherIcons.image,
                color: AppColors.grey,
                size: 24.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Galeria',
                  style: Styles.body.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              Icon(
                FeatherIcons.chevronRight,
                color: AppColors.grey,
                size: 24.w,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        const Divider(),
        SizedBox(height: 8.h),
        TextButton(
          onPressed: () async {
            await ImagePicker()
                .pickImage(
              source: ImageSource.camera,
            )
                .then((image) {
              if (image != null) {
                onNewPhoto?.call(image);
              }
            });
            Modular.to.pop();
          },
          child: Row(
            children: [
              Icon(
                FeatherIcons.camera,
                color: AppColors.grey,
                size: 24.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Câmera',
                  style: Styles.body.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              Icon(
                FeatherIcons.chevronRight,
                color: AppColors.grey,
                size: 24.w,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
