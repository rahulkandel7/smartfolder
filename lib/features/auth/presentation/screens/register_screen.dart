import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_folder_mobile_app/core/utils/toaster.dart';
import 'package:smart_folder_mobile_app/features/auth/data/models/user.dart';
import 'package:smart_folder_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../constants/app_routes.dart';
import '../widgets/input_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerKey = GlobalKey();

  User? user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Smart \n  Organizer",
                  style: TextStyle(
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 10,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Register Now,",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _registerKey,
                      child: Column(
                        spacing: 20,
                        children: [
                          inputFields(
                            context: context,
                            icon: Icons.person_2_outlined,
                            hintText: "Full Name",
                            labelText: "Full Name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Provide full name";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              user!.fullname = value;
                            },
                          ),
                          inputFields(
                            context: context,
                            icon: Icons.email_outlined,
                            hintText: "Email address",
                            labelText: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Provide email address";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              user!.email = value;
                            },
                          ),
                          inputFields(
                            context: context,
                            icon: Icons.lock_outline_rounded,
                            hintText: "Password",
                            labelText: "Password",
                            obscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Provide password";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              user!.password = value;
                            },
                          ),
                          inputFields(
                            context: context,
                            icon: Icons.lock_outline_rounded,
                            hintText: "Confirm Password",
                            labelText: "Confirm Password",
                            obscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Provide confirm password";
                              } else {
                                return null;
                              }
                            },
                          ),
                          inputFields(
                            context: context,
                            icon: Icons.location_city,
                            hintText: "Address",
                            labelText: "Address",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Provide address";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              user!.address = value;
                            },
                          ),
                          inputFields(
                            context: context,
                            icon: Icons.phone_android_outlined,
                            hintText: "Phone Number",
                            labelText: "Phone",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Provide phone number";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              user!.phoneNumber = value;
                            },
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is RegisterErrorState) {
                                showToaster(
                                  context: context,
                                  message: state.message,
                                  backgroundColor: Colors.red,
                                );
                              }
                              if (state is RegisterSuccessState) {
                                showToaster(
                                  context: context,
                                  message: state.message,
                                );
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.homeScreen);
                              }
                            },
                            builder: (context, state) {
                              return FilledButton.tonal(
                                onPressed: () {
                                  if (!_registerKey.currentState!.validate()) {
                                    return;
                                  }
                                  _registerKey.currentState!.save();
                                  context.read<AuthBloc>().add(
                                      RegisterEvent(userData: user!.toMap()));
                                },
                                child: Text(
                                  "Register",
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text("Login"),
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(AppRoutes.loginScreen),
                              ),
                            ],
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
      ),
    );
  }
}
