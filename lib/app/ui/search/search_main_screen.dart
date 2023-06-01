import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/models/place/prediction/prediction.dart';
import 'package:toiletmap/app/models/placeDetail/place_detail.dart';
import 'package:toiletmap/app/repositories/place_repository.dart';
import 'package:toiletmap/app/utils/routes.dart';

import '../../models/place/place.dart';
import '../../utils/constants.dart';

class SearchMainScreen extends StatefulWidget {
  const SearchMainScreen({Key? key}) : super(key: key);

  @override
  State<SearchMainScreen> createState() => _SearchMainScreenState();
}

class _SearchMainScreenState extends State<SearchMainScreen> {

  List<Prediction> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateList(String value) async {
    Place? places = await PlaceRepository().getPlace(value);

    setState(() {
      data = places!.predictions!;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.h),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.h),
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor1,
                  ),
                ),
                leadingWidth: 30.w,

                title: TextField(
                  autofocus: true,
                  onChanged: (value) => updateList(value),
                  decoration: InputDecoration(
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(width: 1.w),
                      ),
                      hintText: "Tìm kiếm địa chỉ",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: AppColor.primaryColor2
                  ),
                ),
                toolbarHeight: 120.h,
                backgroundColor: Colors.white,
                elevation: 0,

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),
              ),
            ),
          ),
        body: Container(
          color: Colors.white,
          child: Expanded(
            child: ListView.builder(
              itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () async {
                    PlaceDetail? detail = await PlaceRepository().getPlaceDetail(data[index].place_id);
                    Navigator.pushNamed(context, Routes.searchMapScreen, arguments: detail);
                  },
                title: Text(data[index].description),
            )),
          ),
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> allData = [
    'American', 'Russia', 'Vietnam', 'China', 'Germany',
    'Italy', 'France', 'England'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
        itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
        }
    );
  }
}
