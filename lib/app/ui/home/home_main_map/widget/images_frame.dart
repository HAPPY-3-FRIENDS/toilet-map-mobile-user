import 'package:flutter/material.dart';
import 'package:toiletmap/app/utils/constants.dart';

class ImagesFrame extends StatelessWidget {
  List<String> imageSource;

  ImagesFrame({required this.imageSource, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (imageSource.length) {
      case 0:
        return Container(
          height: AppSize.heightScreen / 4.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://static.asianpaints.com/content/dam/asianpaintsbeautifulhomes/spaces/bathrooms/modern-toilet-design-ideas-for-contemporary-homes/Title-modern-toile-design-idea.jpg"),
            ),
          ),
        );
      case 1:
        return Container(
          height: AppSize.heightScreen / 4.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageSource[0]),
            ),
          ),
        );
      case 2:
        return Container(
          height: AppSize.heightScreen / 4.5,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageSource[0])
                      ),
                    ),
                  )
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(imageSource[1])
                      ),
                    ),
                  )
              ),
            ],
          ),
        );
      case 3:
        return Container(
          height: AppSize.heightScreen / 4.5,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(imageSource[0])
                      ),
                    ),
                  )
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[1])
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[2])
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 4:
        return Container(
          height: AppSize.heightScreen / 4.5,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(imageSource[0])
                      ),
                    ),
                  )
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[1])
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[2])
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[3])
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          height: AppSize.heightScreen / 4.5,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(imageSource[0])
                      ),
                    ),
                  )
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[1])
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[2])
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSource[3])
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black38,
                          child: Text(
                            '+ ' + (imageSource.length - 4).toString(),
                            style: TextStyle(fontSize: AppNumber.h35, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }
}
