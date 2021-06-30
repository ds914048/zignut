import 'dart:io';
import 'package:elememt3zignuts/common_widgets/custom_ink_button.dart';
import 'package:elememt3zignuts/common_widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(
      child: Text(
        "Login",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
    ),
    const Tab(
      child: Text(
        "Sign Up",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =  TabController(vsync: this, length: myTabs.length);
  }

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final customerSignInEmail = TextEditingController();
  final customerSignInPassword = TextEditingController();
  final customerSignupFName = TextEditingController();
  final customerSignupLName = TextEditingController();
  final customerSignupEmail = TextEditingController();
  final customerSignupPassword = TextEditingController();
  final customerSignupCPassword = TextEditingController();
  final _signInKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool agree = false;

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", true);
  }

  void httpLoginPost() async {
    const url =
        "https://e3-qkmountain.qkinnovations.com/element3-backend/api/user/appLogin";
    try {
      final response = await post(Uri.parse(url), body: {
        "email": customerSignInEmail.text,
        "password": customerSignInPassword.text,
        "device_token": "1322asda",
        "device_type": Platform.isAndroid ? "A" : "I",
        "category_id": "1",
      });
      if (response.statusCode == 200) {
        Navigator.pop(context); //pop dialog

        // ignore: avoid_print
        print(response.body);
        login();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.pop(context); //pop dialog

        var snackBar = SnackBar(
            content:
                Text(response.reasonPhrase.toString() + " ! SignIn falied."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void httpRegisPost() async {
    const url =
        "https://e3-qkmountain.qkinnovations.com/element3-backend/api/user/appRegistration";
    try {
      final response = await post(Uri.parse(url), body: {
        "first_name": customerSignupFName.text,
        "last_name": customerSignupLName.text,
        "email": customerSignupEmail.text,
        "password": customerSignupPassword.text,
        "password_confirmation": customerSignupCPassword.text,
        "device_token": "1",
        "device_type": Platform.isAndroid ? "A" : "I",
      });
      if (response.statusCode == 200) {
        Navigator.pop(context); //pop dialog

        // ignore: avoid_print
        print(response.body);
        login();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.pop(context); //pop dialog
        var snackBar = SnackBar(
            content:
                Text(response.reasonPhrase.toString() + " ! SignUp falied."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  int customerSelected = 0;

  SliverAppBar showSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.black,
      floating: true,
      pinned: true,
      snap: false,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset( "assets/images/ic_login_signup_hader.png",
              fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.all(85),
                child: Image.asset(
                  "assets/images/nameLogo.png",
                ),
              ),
            ],
          )),
      bottom:  TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 4,
        controller: _tabController,
        tabs: myTabs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: TabBarView(
          controller: _tabController,

          children: [
        // This CustomScrollView display the Home tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar(),

            // Anther sliver widget: SliverList
            SliverList(
              delegate: SliverChildListDelegate([
                // ignore: sized_box_for_whitespace
                Container(
                    height: deviceHeight * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: _signInKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: deviceHeight * 0.05,
                            ),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: deviceWidth * 0.8,
                              height: 50,
                              child: ToggleSwitch(
                                minWidth: deviceWidth * 0.398,
                                // ignore: prefer_const_literals_to_create_immutables
                                activeBgColors: [
                                  // ignore: prefer_const_literals_to_create_immutables
                                  [const Color(0xFF1669CB)],
                                  // ignore: prefer_const_literals_to_create_immutables
                                  [const Color(0xFF1669CB)]
                                ],
                                initialLabelIndex: 0,
                                totalSwitches: 2,
                                radiusStyle: true,
                                cornerRadius: 40.0,
                                inactiveBgColor: Colors.grey[100],
                                // ignore: prefer_const_literals_to_create_immutables
                                labels: [
                                  'Customer',
                                  'Instuctor',
                                ],
                                onToggle: (index) {
                                  // ignore: avoid_print
                                  print('switched to: $index');
                                },
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * 0.05,
                            ),
                            CustomTextFormField(
                              controller: customerSignInEmail,
                              prefix: Image.asset(
                                'assets/images/Mail.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fitWidth,
                              ),
                              hintText: "xyz@mail.com",
                              labelText: "Email",
                              validator: "Email Can't be empty",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextFormField(
                              obscureText: hidePassword,
                              controller: customerSignInPassword,
                              prefix: Image.asset(
                                'assets/images/Password.png',
                                width: 15,
                                height: 15,
                                fit: BoxFit.scaleDown,
                              ),
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                child: hidePassword
                                    ? Image.asset(
                                        'assets/images/Hide.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : Image.asset(
                                        'assets/images/UnHide.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.scaleDown,
                                      ),
                              ),
                              hintText: "* * * * * *",
                              labelText: "Password",
                              validator:
                                  "password must be longer than 7 characters",
                              minWord: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forget Password ?",
                                        style: TextStyle(
                                            color: Color(0xFF1669CB),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * 0.03,
                            ),
                            CustomInkButton(
                              onTap: () {
                                if (_signInKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        // ignore: sized_box_for_whitespace
                                        child: Container(
                                          height: deviceHeight * 0.1,
                                          width: deviceWidth * 0.5,
                                          child: Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const CircularProgressIndicator(),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              const Text("Loading..."),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  httpLoginPost();
                                }
                              },
                              text: "LOGIN",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {

                                  _tabController.animateTo((_tabController.index + 1) % 2);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: RichText(
                                        text: const TextSpan(
                                            text: 'Don\'t have an account?',
                                            style: TextStyle(
                                                color: Color(0xFF1669CB),
                                                fontSize: 16),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ' SIGN UP',
                                                style: TextStyle(
                                                    color: Color(0xFF1669CB),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )
                                            ]),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    )),
              ]),
            ),
          ],
        ),

        // This shows the Settings tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar(),

            // Show other sliver stuff
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                    height: deviceHeight * 0.8,
                    color: Colors.white,
                    child: Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: deviceHeight * 0.05,
                          ),
                          // ignore: sized_box_for_whitespace
                          Container(
                            width: deviceWidth * 0.8,
                            height: 50,
                            child: ToggleSwitch(
                              minWidth: deviceWidth * 0.398,
                              // ignore: prefer_const_literals_to_create_immutables
                              activeBgColors: [
                                // ignore: prefer_const_literals_to_create_immutables
                                [const Color(0xFF1669CB)],
                                // ignore: prefer_const_literals_to_create_immutables
                                [const Color(0xFF1669CB)]
                              ],
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              radiusStyle: true,
                              cornerRadius: 40.0,
                              inactiveBgColor: Colors.grey[100],
                              // ignore: prefer_const_literals_to_create_immutables
                              labels: [
                                'Customer',
                                'Instuctor',
                              ],
                              onToggle: (index) {
                                // ignore: avoid_print
                                print('switched to: $index');
                              },
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.03,
                          ),
                          CustomTextFormField(
                            controller: customerSignupFName,
                            validator: "First Name cannot be empty",
                            prefix: Image.asset(
                              'assets/images/FirstName.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.fitWidth,
                            ),
                            hintText: "First Name",
                            labelText: "First Name",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            controller: customerSignupLName,
                            validator: "Last Name cannot be empty",
                            prefix: Image.asset(
                              'assets/images/FirstName.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.fitWidth,
                            ),
                            hintText: "Last Name",
                            labelText: "Last Name",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            controller: customerSignupEmail,
                            prefix: Image.asset(
                              'assets/images/Mail.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.fitWidth,
                            ),
                            hintText: "xyz@mail.com",
                            labelText: "Email",
                            validator: "Email cannot be empty",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            controller: customerSignupPassword,
                            obscureText: true,
                            prefix: Image.asset(
                              'assets/images/Password.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.fitWidth,
                            ),
                            hintText: "* * * * * *",
                            labelText: "Password",
                            minWord: 8,
                            validator:
                                "Password must be longer than 7 characters",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            controller: customerSignupCPassword,
                            obscureText: true,
                            prefix: Image.asset(
                              'assets/images/Password.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.scaleDown,
                            ),
                            minWord: 8,
                            hintText: "* * * * * *",
                            labelText: "Confirm Password",
                            validator:
                                "Password must be longer than 7 characters",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: agree
                                    ? Image.asset(
                                        'assets/images/selected.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : Image.asset(
                                        'assets/images/Unselected.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.scaleDown,
                                      ),
                                onTap: () {
                                  setState(() {
                                    agree = !agree;
                                  });
                                },
                              ),
                              RichText(
                                text: const TextSpan(
                                  text: "   I hereby accept the",
                                  style: TextStyle(
                                      color: Color(0xFF1669CB),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Terms and Conditions.\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '   and have read the'),
                                    TextSpan(
                                        text: ' Privacy Policy.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: deviceHeight * 0.04,
                          ),
                          CustomInkButton(
                            condition: agree,
                            onTap: () {
                              if (agree) {
                                if (_signUpKey.currentState!.validate()) {
                                  // ignore: unrelated_type_equality_checks
                                  if (customerSignupPassword.text ==
                                      customerSignupCPassword.text) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          // ignore: sized_box_for_whitespace
                                          child: Container(
                                            height: deviceHeight * 0.1,
                                            width: deviceWidth * 0.5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                const CircularProgressIndicator(),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                const Text("Loading..."),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    httpRegisPost();
                                  } else {
                                    var snackBar = const SnackBar(
                                        content: Text('Password Mismatch'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              } else {
                                var snackBar = const SnackBar(
                                    content: Text(
                                        'accept terms and conditions checkbox'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            text: "SIGN UP",
                          ),
                        ],
                      ),
                    )),
              ]),
            ),
          ],
        )
      ]),
    ));
  }
}
