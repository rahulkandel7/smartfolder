import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_folder_mobile_app/constants/keys_constants.dart';
import 'package:smart_folder_mobile_app/features/auth/data/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user = User();
  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(KeysConstants.kKeyForUserDetail)) {
      User userDetail =
          User.fromJson(prefs.getString(KeysConstants.kKeyForUserDetail)!);
      setState(() {
        user = userDetail;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hello, ${user.fullname}',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
