import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shortest_route_map/theme/colors.dart';
import 'package:shortest_route_map/theme/theme.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppColors get colors => AppColors.light;
  ColorScheme get colorScheme => theme.colorScheme;
  NavigatorState get navigator => Navigator.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextTheme get textTheme => theme.textTheme;
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;

  TextDirection get direction => Directionality.of(this);
  bool get isRtl => direction == TextDirection.rtl;
  bool get isLtr => direction == TextDirection.ltr;

  FocusScopeNode get focusScope => FocusScope.of(this);
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsets get viewPaddingWithoutInsets => viewPadding - viewInsets;
  EdgeInsets get paddingWithoutViewInsets => padding - viewPadding;
  double get topInset => viewInsets.top;
  Locale get flutterLocale => Localizations.localeOf(this);
  String get localeLanguageCode => flutterLocale.languageCode;
  bool get isArabic => localeLanguageCode == 'ar';
  bool get isFrench => localeLanguageCode == 'fr';

  String formattedDate(DateTime date, [String? pattern]) {
    final locale = localeLanguageCode == 'ar' ? 'ar_DZ' : 'fr';
    return intl.DateFormat(pattern, locale).format(date);
  }

  String formattedCurrency(num amount) {
    return intl.NumberFormat.currency(
      locale: localeLanguageCode == 'ar' ? 'ar_DZ' : 'fr',
      symbol: localeLanguageCode == 'ar' ? 'دج' : 'DA',
    ).format(amount);
  }

  void closeKeyboard() {
    focusScope.unfocus();
  }

  AppTheme get appTheme => const AppTheme();
  ThemeData get currentTheme => appTheme.lightTheme;

  TextStyle? get textFieldHintStyle => textTheme.bodyMedium?.copyWith(
        color: colors.label,
      );
  TextStyle? get textFieldLabelStyle => textTheme.labelLarge?.copyWith(
        color: colors.textSecondary,
      );

  Offset directionOffset({
    double dx = 0,
    double dy = 0,
    double? dxLtr,
    double? dxRtl,
  }) {
    return Offset(
      isRtl ? -(dxRtl ?? dx) : (dxLtr ?? dx),
      dy,
    );
  }

  // snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? 3.seconds,
        action: action,
      ),
    );
  }

  // dialog
  Future<T?> customWidgetDialog<T>(
    Widget child, {
    bool barrierDismissible = true,
  }) {
    return showModal<T>(
      context: this,
      builder: (context) => child,
      configuration: FadeScaleTransitionConfiguration(
        transitionDuration: 300.ms,
        reverseTransitionDuration: 200.ms,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}
