
import 'package:toiletmap/app/models/toilet/toiletFacilities/toiletFacilities.dart';

class ToiletArgument {
  List<String> toiletImagesList;
  String time;
  String toiletName;
  String price;
  String address;
  double star;
  String? nearBy;
  int showerRoom;
  int normalRoom;
  int disabilityRoom;
  List<ToiletFacilities> facilities;

  ToiletArgument(
      this.toiletImagesList,
      this.time,
      this.toiletName,
      this.price,
      this.address,
      this.star,
      this.nearBy,
      this.showerRoom,
      this.normalRoom,
      this.disabilityRoom,
      this.facilities,
      );
}

