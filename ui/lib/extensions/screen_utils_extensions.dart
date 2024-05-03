import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

extension ScreenUtilsExt on num {
  double get wm {
    final half = this / 2;
    return half + half.w;
  }

  double get hm {
    final half = this / 2;
    return half + half.h;
  }

  double get rm {
    final half = this / 2;
    return half + half.r;
  }

  double get w75 => this * .25 + (this * .75).w;
  double get h75 => this * .25 + (this * .75).h;
  double get r75 => this * .25 + (this * .75).r;

  Gap get sizedBoxH => Gap(toDouble());

  Gap get sizedBoxW => Gap(toDouble());

  Gap get gapH => Gap(h);

  MaxGap get maxGapH => MaxGap(h);

  Gap get gapW => Gap(w);

  MaxGap get maxGapW => MaxGap(w);

  Gap get gapR => Gap(r);

  MaxGap get maxGapR => MaxGap(r);

  Gap get gapW75 => Gap(w75);

  Gap get gapH75 => Gap(h75);

  Gap get gapR75 => Gap(r75);

  Gap get gapWM => Gap(wm);

  Gap get gapHM => Gap(hm);

  Gap get gapRM => Gap(rm);

  BorderRadiusGeometry get borderRadiusGeometry =>
      BorderRadius.circular(toDouble());

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  Radius get radius => Radius.circular(toDouble());

  EdgeInsetsGeometry get paddingAll => EdgeInsets.all(toDouble());
}
