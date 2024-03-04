import 'package:flutter/material.dart';
import 'package:flutter_ar/data/models/parent_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/student_profile_cubit/student_profile_cubit.dart';
import '../bloc/parent_details_cubit/parent_details_cubit.dart';
import 'edit_parent_details_box.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Container();
        } else {
          return Padding(
            padding: EdgeInsets.fromLTRB(4.wp, 20.h, 4.wp, 0),
            child: Column(
              children: [
                studentProfile(),
                22.verticalSpacer,
                BlocBuilder<ParentDetailsCubit, ParentDetailsState>(
                  builder: (context, state) {
                    if (state.status == ParentDetailsStatus.loaded) {
                      return Column(
                        children: List.generate(
                          state.parentDetails.length,
                          (index) => Column(
                            children: [
                              ParentProfileCard(
                                parentDetails: state.parentDetails[index],
                                profileTitle:
                                    state.parentDetails[index].parentRelation,
                                name: state.parentDetails[index].parentName,
                                mobile: state
                                    .parentDetails[index].parentMobileNumber
                                    .toString()
                                    .substring(2)
                                    .split('.')
                                    .first,
                                email: state.parentDetails[index].parentEmail,
                              ),
                              22.verticalSpacer,
                            ],
                          ),
                        ),
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator.adaptive(
                            strokeCap: StrokeCap.round));
                  },
                ),
                // const ParentProfileCard(
                //   profileTitle: 'Fater',
                //   name: 'Shardul Gangal',
                //   mobile: '0123456789',
                //   email: 'shardulgangal@yahoo.com',
                // ),
                // 22.verticalSpacer,
                // const ParentProfileCard(
                //   profileTitle: 'Mother',
                //   name: 'Sneha Gangal',
                //   mobile: '0123456789',
                //   email: 'snehagangal@yahoo.com',
                // ),
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
                  child: BlocBuilder<StudentProfileCubit, StudentProfileState>(
                    builder: (context, state) {
                      return Text(
                        state.studentProfileModel?.studentName ?? '',
                        style: TextStyle(
                          color: const Color(0xFF212121),
                          fontSize: 128.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      );
                    },
                  ),
                ),
                8.verticalSpacer,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: BlocBuilder<StudentProfileCubit,
                            StudentProfileState>(
                          builder: (context, state) {
                            return Text(
                              'Grade: ${state.studentProfileModel?.grade}',
                              style: TextStyle(
                                color: const Color(0xFF212121),
                                fontSize: 95.sp,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child:
                          BlocBuilder<StudentProfileCubit, StudentProfileState>(
                        builder: (context, state) {
                          return Text(
                            'Division: ${state.studentProfileModel?.division}',
                            style: TextStyle(
                              color: const Color(0xFF212121),
                              fontSize: 95.sp,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                8.verticalSpacer,
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<StudentProfileCubit, StudentProfileState>(
                    builder: (context, state) {
                      return Text(
                        '${state.studentProfileModel?.schoolName}',
                        style: TextStyle(
                          color: const Color(0xFF212121),
                          fontSize: 95.sp,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      );
                    },
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
  final ParentDetails parentDetails;
  const ParentProfileCard({
    super.key,
    required this.profileTitle,
    required this.name,
    required this.mobile,
    required this.email,
    required this.parentDetails,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> _showAlertDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            child: EditParentDetailsBox(
              profileTitle: profileTitle,
              parentDetails: parentDetails,
            ),
          );
        },
      );
    }

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
                      onPressed: () => _showAlertDialog(),
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
