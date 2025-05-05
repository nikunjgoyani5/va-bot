import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import '../../theme/colors.dart';

class CommonSwitchButton extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final Color? activeTrackColor;
  final Color? thumbColor;
  const CommonSwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.thumbColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 2.5.sp,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeTrackColor ?? AppColors.primaryColor,
        thumbColor: thumbColor ?? AppColors.whiteFFFFFF,
      ),
    );
  }
}
