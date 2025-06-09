import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_folder_mobile_app/constants/app_routes.dart';
import 'package:smart_folder_mobile_app/constants/keys_constants.dart';
import 'package:smart_folder_mobile_app/core/utils/toaster.dart';
import 'package:smart_folder_mobile_app/features/auth/data/models/user.dart';
import 'package:smart_folder_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';

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
      appBar: AppBar(
        title: Text(
          'Hello, ${user.fullname}',
          style: TextStyle(fontSize: 26),
        ),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutSuccessState) {
                showToaster(context: context, message: state.message);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreen,
                  (route) => false,
                );
              }
              if (state is LogoutErrorState) {
                showToaster(
                  context: context,
                  message: state.message,
                  backgroundColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return IconButton.filledTonal(
                onPressed: state is LogoutLoadingState
                    ? null
                    : () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                icon: Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: InkWell(
        onTap: () {},
        onLongPress: () {},
        child: Container(
          // width: 40,
          // height: 30,
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              // CachedNetworkImage(
              //   imageUrl: '${ApiConstants.imageUrl}$photopath',
              //   placeholder: (context, url) =>
              //       Image.asset('assets/logo/logo.png'),
              //   errorWidget: (context, url, error) =>
              //       Image.asset('assets/logo/logo.png'),
              //   height: size.height * 0.14,
              //   width: double.infinity,
              //   fit: BoxFit.contain,
              // ),
              SizedBox(
                width: 120,
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "name",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
