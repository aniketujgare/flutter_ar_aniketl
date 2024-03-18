import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/constants.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../bloc/navbar_cubit/app_navigator_cubit.dart';
import '../pages/parent_zone_screen.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _receiveEmails = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Notifications',
            style: AppTextStyles.nunito105w700Text,
          ),
          trailing: Switch(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text(
            'Enable Sound',
            style: AppTextStyles.nunito105w700Text,
          ),
          trailing: Switch(
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text(
            'Receive Emails',
            style: AppTextStyles.nunito105w700Text,
          ),
          trailing: Switch(
            value: _receiveEmails,
            onChanged: (value) {
              setState(() {
                _receiveEmails = value;
              });
            },
          ),
        ),
        // 56.verticalSpacer,
        // ReusableButton(
        //   onPressed: () {
        //     Constants().showAppSnackbar(context, 'Saved succesfully!');
        //   },
        //   buttonColor: AppColors.primaryColor,
        //   text: 'Save Settings',
        //   textColor: Colors.white,
        // ),
      ],
    );
  }
}
