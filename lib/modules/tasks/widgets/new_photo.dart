import 'dart:io';

import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/ui/custom_dialog.dart';
import 'package:executive_gps/modules/shared/ui/new_photo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPhoto extends StatelessWidget {
  final ImageModel? image;
  final Function(ImageModel? image)? onImageSelected;
  const NewPhoto({
    super.key,
    this.image,
    this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image?.file != null
            ? Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onTap: () => Modular.to
                        .pushNamed('/image-details', arguments: image),
                    child: Container(
                      width: 125.w,
                      height: 125.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.grey, width: 1.w),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              image?.file?.path ?? '',
                            ),
                          ),
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                  ),
                  Positioned(
                      top: -10.w,
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.r),
                          color: Colors.red,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.w,
                          ),
                        ),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            color: Colors.red,
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14.w,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      title: 'Excluir imagem',
                                      content: Text(
                                        'Você tem certeza que deseja excluir esta imagem?',
                                        style: Styles.bodySmall,
                                      ),
                                      onTap: (confirm) {
                                        if (confirm) {
                                          onImageSelected?.call(
                                              const ImageModel(file: null));
                                        }
                                        Modular.to.pop();
                                      },
                                    );
                                  });
                            }),
                      )),
                ],
              )
            : InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return NewPhotoDialog(
                        onNewPhoto: (image) {
                          onImageSelected?.call(
                            ImageModel(file: image),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  width: 125.w,
                  height: 125.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.grey, width: 1.w),
                  ),
                  child: Icon(Icons.add_circle_outline_rounded,
                      color: AppColors.grey, size: 32.w),
                ),
              ),
      ],
    );
  }
}
