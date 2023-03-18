import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/panel_widget.dart';

import '../../../utils/constants.dart';

class HomeMainBottomPanel extends StatefulWidget {
  const HomeMainBottomPanel({Key? key}) : super(key: key);

  @override
  State<HomeMainBottomPanel> createState() => _HomeMainBottomPanelState();
}

class _HomeMainBottomPanelState extends State<HomeMainBottomPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlidingUpPanel(
        color: Colors.transparent,
        panelBuilder: (controller) =>
            PanelWidget(
                controller: controller
            ),
      ),
    );
  }
}
