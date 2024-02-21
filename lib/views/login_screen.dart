import 'package:driver_app/components/login_form_field.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/services/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loadingFlag = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loadingFlag,
        blur: 2,
        progressIndicator: const SpinKitSpinningLines(
          color: Colors.black,
          size: 90.0,
        ),
        color: Colors.black12,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF0047FF), Color(0xFF00B3EC)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/login.svg',
                height: 160,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Please sign in to continue',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Form(
                        key: _formKey1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: LoginFormField(
                          hintText: "Username",
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is Required.';
                            } else if (!validateEmail(value)) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: _formKey2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: LoginFormField(
                          textInputAction: TextInputAction.done,
                          controller: _passwordController,
                          hintText: "Password",
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is Required.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          onPressed: () async {
                            bool validation1 =
                                _formKey1.currentState!.validate();
                            bool validation2 =
                                _formKey2.currentState!.validate();
                            if (validation1 && validation2) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _loadingFlag = true;
                              });
                              String response = await UserLogin.login(
                                _emailController.text,
                                _passwordController.text,
                              );
                              if (response != 'success') {
                                
                                setState(() {
                                  _loadingFlag = false;
                                });
                                Fluttertoast.showToast(
                                    msg: response.capitalize(),
                                    backgroundColor:
                                        Colors.blue[900]!.withOpacity(0.7),
                                    fontSize: 17);
                              } else {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("id", CurrentUser().id!);
                                prefs.setString("name", CurrentUser().name!);
                                prefs.setString("token", CurrentUser().token!);
                                prefs.setString("email", CurrentUser().email!);
                                prefs.setString(
                                    "username", CurrentUser().username!);
                                setState(() {
                                  _loadingFlag = false;
                                });
                                Navigator.pushReplacementNamed(context, kHomeScreen);
                              }
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
