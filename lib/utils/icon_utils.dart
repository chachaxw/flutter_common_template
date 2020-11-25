import 'package:flutter_svg/svg.dart';
import 'color_utils.dart';

class AppIcons {
  static SvgPicture homeIcon = SvgPicture.asset(
    'assets/icons/home.svg',
    color: AppColors.labelGreyColor,
  );

  static SvgPicture homeActiveIcon = SvgPicture.asset('assets/icons/home.svg');

  static SvgPicture discoverIcon = SvgPicture.asset(
    'assets/icons/discover.svg',
    color: AppColors.labelGreyColor,
  );

  static SvgPicture discoverActiveIcon = SvgPicture.asset('assets/icons/discover.svg');

  static SvgPicture userIcon = SvgPicture.asset(
    'assets/icons/user.svg',
    color: AppColors.labelGreyColor,
  );
  static SvgPicture userActiveIcon = SvgPicture.asset('assets/icons/user.svg');
}
