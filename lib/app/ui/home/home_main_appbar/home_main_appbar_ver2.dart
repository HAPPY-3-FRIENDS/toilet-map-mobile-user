import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver2/appbar_button_frame.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver2/appbar_info_frame.dart';

import '../../../utils/constants.dart';

class HomeMainAppbarVer2 extends StatelessWidget {
  const HomeMainAppbarVer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: const [
          AppbarInfoFrame(),
          AppbarButtonFrame(),
        ],
    );
  }
}
