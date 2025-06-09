import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_folder_mobile_app/constants/app_routes.dart';
import 'package:smart_folder_mobile_app/core/utils/toaster.dart';
import 'package:smart_folder_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../widgets/input_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginKey = GlobalKey();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              SizedBox(
                height: 10,
              ),
              Form(
                key: _loginKey,
                child: Column(
                  spacing: 20,
                  children: [
                    inputFields(
                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide email';
                        } else {
                          return null;
                        }
                      },
                      context: context,
                      icon: Icons.email_outlined,
                      hintText: "Email address",
                      labelText: "Email",
                    ),
                    inputFields(
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide password';
                        } else {
                          return null;
                        }
                      },
                      context: context,
                      icon: Icons.lock_outline_rounded,
                      hintText: "Password",
                      labelText: "Password",
                      obscure: true,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          showToaster(context: context, message: state.message);
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.homeScreen);
                        }
                        if (state is LoginErrorState) {
                          showToaster(
                            context: context,
                            message: state.message,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        return FilledButton.tonal(
                          onPressed: state is LoginLoadingState
                              ? null
                              : () {
                                  if (!_loginKey.currentState!.validate()) {
                                    return;
                                  }
                                  _loginKey.currentState!.save();
                                  final Map<String, dynamic> loginData = {
                                    'email': email,
                                    'password': password
                                  };
                                  context.read<AuthBloc>().add(
                                        LoginEvent(loginData: loginData),
                                      );
                                },
                          child: Text(
                            "Login",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text("Sign up"),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.registerScreen),
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
