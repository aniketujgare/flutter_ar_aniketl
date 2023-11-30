import 'package:flutter/material.dart';
import 'package:flutter_ar/api/api.dart';
import 'package:flutter_ar/category_page_view.dart';

import 'package:flutter_ar/model_3d_view.dart';

import 'model/ar_category.dart';

class HomeView extends StatelessWidget {
  final bool isMobile;
  const HomeView({
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFF4F2FE),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 110 / 4 : 110 / 2,
              vertical: isMobile ? 0 : 40 / 2),
          child: Stack(
            children: [
              Positioned(
                left: isMobile ? 95 : 120,
                top: isMobile ? 35 : 42,
                child: Text(
                  'shardul',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: isMobile ? 18 : 24,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Positioned(
                right: 25,
                top: -10,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/ui_new/Rectangle 19.png',
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        top: -1,
                        left: 0,
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: Image.asset(
                            'assets/ui_new/Ellipse 8.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        top: 4,
                        child: SizedBox(
                          height: 21,
                          width: 21,
                          child: Image.asset(
                            'assets/ui_new/star cliche 1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 38,
                        top: 7,
                        child: Text(
                          '999',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 115,
                top: -10,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 78,
                        child: Image.asset(
                          'assets/ui_new/Rectangle 19.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: -1,
                        left: 0,
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: Image.asset(
                            'assets/ui_new/Ellipse 8.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        top: 4,
                        child: SizedBox(
                          height: 21,
                          width: 21,
                          child: Image.asset(
                            'assets/ui_new/coin 1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 38,
                        top: 7,
                        child: Text(
                          '999',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   right: 115,
              //   top: -15,
              //   child: Container(
              //     width: isMobile ? 78 : 120,
              //     height: isMobile ? 78 : 120,
              //     padding: const EdgeInsets.only(top: 20),
              //     child: Image.asset(
              //       'assets/ui_new/Rectangle 19.png',
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          left: isMobile ? 20 : 10,
                          child: Container(
                            width: isMobile ? 75 : 100,
                            height: isMobile ? 75 : 100,
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              'assets/ui_new/image 8.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: isMobile ? 32 : 20,
                                right: isMobile ? 32 : 20),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                'assets/ui_new/fi-br-caret-square-left 1.png',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: isMobile ? 25 : 10,
                          bottom: 10,
                          child: Container(
                            width: isMobile ? 75 : 100,
                            height: isMobile ? 75 : 100,
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              'assets/ui_new/Home Button.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Positioned(
                          left: isMobile ? 35 : 25,
                          bottom: isMobile ? 20 : 25,
                          child: Container(
                            width: isMobile ? 55 : 70,
                            height: isMobile ? 55 : 70,
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              'assets/ui_new/home (1) 1.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 14 / 2,
                              right: 14 / 2,
                              top: isMobile
                                  ? MediaQuery.of(context).size.height * 0.12
                                  : 54,
                              bottom: isMobile
                                  ? MediaQuery.of(context).size.height * 0.08
                                  : 54),
                          child:
                              // Column(
                              //   children: [
                              //     Expanded(
                              //       child: Flex(
                              //           direction: Axis.horizontal, // this is unique
                              //           mainAxisAlignment: MainAxisAlignment.start,
                              //           mainAxisSize: MainAxisSize.max,
                              //           verticalDirection: VerticalDirection.down,
                              //           crossAxisAlignment: CrossAxisAlignment.center,
                              //           // verticalDirection: VerticalDirection.down,
                              //           // textDirection: TextDirection.rtl,
                              //           children: <Widget>[
                              //             Expanded(
                              //               flex: 1,
                              //               child: Container(
                              //                 padding: const EdgeInsets.all(8),
                              //                 color: Colors.red,
                              //                 // height: 55,
                              //                 // width: 50,
                              //               ),
                              //             ),
                              //             Expanded(
                              //               flex: 1,
                              //               child: Container(
                              //                 padding: const EdgeInsets.all(8),
                              //                 // height: 55,
                              //                 // width: 50,
                              //                 color: Colors.green,
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: Container(
                              //                 padding: const EdgeInsets.all(8),
                              //                 // height: 55,
                              //                 // width: 50,
                              //                 color: Colors.blue,
                              //               ),
                              //             ),
                              //           ]),
                              //     ),
                              //     Expanded(
                              //       child: Flex(
                              //           direction: Axis.horizontal, // this is unique
                              //           mainAxisAlignment: MainAxisAlignment.start,
                              //           mainAxisSize: MainAxisSize.max,
                              //           crossAxisAlignment: CrossAxisAlignment.center,
                              //           // verticalDirection: VerticalDirection.down,
                              //           // textDirection: TextDirection.rtl,
                              //           children: <Widget>[
                              //             Expanded(
                              //               flex: 1,
                              //               child: Container(
                              //                 padding: const EdgeInsets.all(8),
                              //                 // height: 55,
                              //                 // width: 50,
                              //                 color: Colors.green,
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: Container(
                              //                 padding: const EdgeInsets.all(8),
                              //                 // height: 55,
                              //                 // width: 50,
                              //                 color: Colors.blue,
                              //               ),
                              //             ),
                              //             Expanded(
                              //               flex: 1,
                              //               child: Container(
                              //                 padding: const EdgeInsets.all(8),
                              //                 color: Colors.red,
                              //                 // height: 55,
                              //                 // width: 50,
                              //               ),
                              //             ),
                              //           ]),
                              //     ),
                              //   ],
                              // )
                              //     FutureBuilder(
                              //   future: API().getModel(),
                              //   builder: (BuildContext context,
                              //       AsyncSnapshot<List<ArModel>?> snapshot) {
                              //     if (snapshot.hasData) {
                              //       return ContainerPageView(
                              //         isMobile: isMobile,
                              //         arModels: snapshot.data!,
                              //       );
                              //     }
                              //     return const Center(child: CircularProgressIndicator());
                              //   },
                              // )
                              FutureBuilder(
                            future: API().getCategories(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ArCategory>?> snapshot) {
                              if (snapshot.hasData) {
                                return CategoryPageView(
                                    isMobile: isMobile,
                                    arCategoryies: snapshot.data!);
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          )
                          // : GridView.builder(
                          //     shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     gridDelegate:
                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 3,
                          //       crossAxisSpacing: 28.0,
                          //       mainAxisSpacing: 28.0,
                          //       childAspectRatio: 443 / 371,
                          //     ),
                          //     itemCount: 6,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return RoundedBox(
                          //         image: models[index]['image']!,
                          //         name: models[index]['name']!,
                          //         model: models[index]['model']!,
                          //         isMobile: isMobile,
                          //       );
                          //     },
                          //   ),
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: isMobile ? 32 : 20,
                                right: isMobile ? 32 : 20),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                'assets/ui_new/fi-br-caret-circle-right 1.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedBox extends StatelessWidget {
  final String image;
  final String name;
  final String model;
  final bool isMobile;
  const RoundedBox({
    super.key,
    required this.image,
    required this.name,
    required this.model,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ModelView(modelUrl: model, modelName: name),
      )),
      child: Container(
        height: 155,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes the position of the shadow
            ),
          ],
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0XFF4F3A9C)],
            tileMode: TileMode.decal,
            stops: [0.7, 0.3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(isMobile ? 20 : 40.0),
          border: Border.all(
            color: Colors.grey.shade100,
            width: 0.5,
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.65,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 18 : 24,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
