import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constants.dart';

class ToiletInformationFrame extends StatelessWidget {
  const ToiletInformationFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: AppSize.heightScreen / 2.8,
      padding: EdgeInsets.all(AppSize.widthScreen / 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 4,
                  child: Container(
                    padding: new EdgeInsets.only(right: AppNumber.w40),
                    child: Expanded(
                      child: Text(
                        'Nhà vệ sinh công cộng Nguyễn Huệ',
                        style: AppText.toiletInfoText1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                    ),
                  )
              ),
              Flexible(
                flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('4.8', style: AppText.detailText2,),
                      Icon(Icons.star, size: AppNumber.h60,),
                    ],
                  ),
              ),
            ],
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.locationDot, size: AppSize.heightScreen / 40,),
              SizedBox(width: AppSize.widthScreen / 20,),
              Expanded(
                child: Text(
                    '42 Đường Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh',
                    style: AppText.toiletInfoText2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.clock, size: AppSize.heightScreen / 40,),
              SizedBox(width: AppSize.widthScreen / 20,),
              Expanded(
                child: Text(
                  '8:00 - 22:00',
                  style: AppText.toiletInfoText2,
                  overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.moneyBill, size: AppSize.heightScreen / 40,),
              SizedBox(width: AppSize.widthScreen / 20,),
              Expanded(
                child: Text(
                  '2.000 - 8.000 VND/lượt',
                  style: AppText.toiletInfoText2,
                  overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.toilet, size: AppSize.heightScreen / 40),
                  SizedBox(width: AppSize.widthScreen / 20,),
                  Text('4 phòng', style: AppText.toiletInfoText2),
                ],
              ),

              Icon(Icons.circle, size: AppNumber.h200,),

              Row(
                children: [
                  FaIcon(FontAwesomeIcons.shower, size: AppSize.heightScreen / 40),
                  SizedBox(width: AppSize.widthScreen / 20,),
                  Text('2 phòng', style: AppText.toiletInfoText2),
                ],
              ),

              Icon(Icons.circle, size: AppNumber.h200,),

              Row(
                children: [
                  FaIcon(FontAwesomeIcons.wheelchair, size: AppSize.heightScreen / 40),
                  SizedBox(width: AppSize.widthScreen / 20,),
                  Text('Không có', style: AppText.toiletInfoText2),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(FontAwesomeIcons.toiletPaper, size: AppSize.heightScreen / 40),
              Text('Vòi xịch', style: AppText.toiletInfoText2),
              Icon(Icons.circle, size: AppNumber.h200,),
              Text('Thiết bị hong khô', style: AppText.toiletInfoText2),
              Icon(Icons.circle, size: AppNumber.h200,),
              Text('Máy lạnh', style: AppText.toiletInfoText2),
            ],
          ),
        ],
      ),
    );
  }
}
