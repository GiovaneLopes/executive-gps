import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  static const TextStyle _style = TextStyle(
    fontFamily: 'Jost',
  );

  static TextStyle title = _style.copyWith(
    fontFamily: _style.fontFamily,
    fontSize: 26.sp,
  );

  static TextStyle body = _style.copyWith(
    fontFamily: _style.fontFamily,
    fontSize: 18.sp,
  );

  static TextStyle bodyMedium = _style.copyWith(
    fontFamily: _style.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
  );

  static TextStyle bodyBold = _style.copyWith(
    fontFamily: _style.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
  );

  static TextStyle bodyLight = _style.copyWith(
    fontFamily: _style.fontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 18.sp,
  );

  static TextStyle bodySmall = _style.copyWith(
    fontFamily: _style.fontFamily,
    fontSize: 14.sp,
  );
}
