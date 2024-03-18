import 'dart:io';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../core/util/styles.dart';
import '../bloc/category_new_cubit/category_new_cubit.dart';
import '../bloc/category_page_cubit/category_page_cubit.dart';
import '../widgets/category_page_view.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.parentZoneScaffoldColor,
        body: ConnectionNotifierToggler(
            loading: const SizedBox.shrink(),
            disconnected: const NetworkDisconnected(),
            connected: Stack(
              children: [
                BlocBuilder<CategoryNewCubit, CategoryNewState>(
                    builder: (context, state) {
                  if (state.status == CategoryStatus.loaded) {
                    return Padding(
                        padding: Platform.isIOS && shortestSide < 600
                            ? EdgeInsets.only(left: 6.wp)
                            : const EdgeInsets.all(0),
                        child: const CategoryPageView());
                  }
                  return const Center(
                      child: CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round,
                  ));
                }),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.wp, 4.wp, 4.wp, 4.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! Left Side back and User icon
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 75.h,
                            height: 75.h,
                            child: Image.asset(
                              'assets/ui/image 40.png', // User Icon
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: Platform.isIOS && shortestSide < 600
                                ? EdgeInsets.only(left: 12.wp)
                                : const EdgeInsets.all(0),
                            child: GestureDetector(
                              onTap: () => context
                                  .read<CategoryPageCubit>()
                                  .setPreviousPage(),
                              child: SizedBox(
                                height: 75.h,
                                width: 75.h,
                                child: UnconstrainedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/ui/Group.png', // left arrow
                                    fit: BoxFit.scaleDown,
                                    height: 45.h,
                                    width: 45.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 75.h,
                            width: 75.h,
                          ),
                        ],
                      ),
                      //! Right Side next and Home icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 75.h,
                            width: 75.h,
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.read<CategoryPageCubit>().setNextPage(),
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: SizedBox(
                                height: 75.h,
                                width: 75.h,
                                child: UnconstrainedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/ui/Group.png', // left arrow
                                    fit: BoxFit.scaleDown,
                                    height: 45.h,
                                    width: 45.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SizedBox(
                              width: 75.h,
                              height: 75.h,
                              child: Image.asset(
                                'assets/ui/Custom Buttons.002 1.png', // Home Icon
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
