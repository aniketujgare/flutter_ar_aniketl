import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../bloc/navbar_cubit/app_navigator_cubit.dart';
import '../pages/parent_zone_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape)
          return Container();
        else {
          return Padding(
            padding: EdgeInsets.fromLTRB(4.wp, 20.h, 4.wp, 0),
            child: Column(
              children: [
                studentProfile(),
                22.verticalSpacer,
                const ParentProfileCard(
                  profileTitle: 'Fater',
                  name: 'Shardul Gangal',
                  mobile: '0123456789',
                  email: 'shardulgangal@yahoo.com',
                ),
                22.verticalSpacer,
                const ParentProfileCard(
                  profileTitle: 'Mother',
                  name: 'Sneha Gangal',
                  mobile: '0123456789',
                  email: 'snehagangal@yahoo.com',
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Container studentProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.wp, vertical: 3.wp),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.wp),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 110.h,
            height: 110.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ui/image 40.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 4.wp),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Student Profile',
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 95.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                12.verticalSpacer,
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Shardul Gangal',
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 128.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                8.verticalSpacer,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          'Grade: 1',
                          style: TextStyle(
                            color: const Color(0xFF212121),
                            fontSize: 95.sp,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Division: A',
                        style: TextStyle(
                          color: const Color(0xFF212121),
                          fontSize: 95.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                8.verticalSpacer,
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'SmartXR School',
                    style: TextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 95.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 0,
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

class ParentProfileCard extends StatelessWidget {
  final String profileTitle;
  final String name;
  final String mobile;
  final String email;
  const ParentProfileCard({
    super.key,
    required this.profileTitle,
    required this.name,
    required this.mobile,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 2.wp, vertical: 3.wp),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.wp),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '$profileTitle\'s Profile',
                style: TextStyle(
                  color: const Color(0xFF212121),
                  fontSize: 95.sp,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 40.h,
                  width: 40.h,
                  child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/reusable_icons/edit.png',
                        fit: BoxFit.cover,
                      )),
                ),
              )
            ],
          ),
          12.verticalSpacer,
          Text(
            name,
            style: TextStyle(
              color: const Color(0xFF212121),
              fontSize: 128.sp,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          8.verticalSpacer,
          Text(
            'Mobile: +91 $mobile',
            style: TextStyle(
              color: const Color(0xFF212121),
              fontSize: 95.sp,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          8.verticalSpacer,
          Text(
            'Email: $email',
            style: TextStyle(
              color: const Color(0xFF212121),
              fontSize: 95.sp,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
