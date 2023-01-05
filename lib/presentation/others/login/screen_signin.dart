import 'package:flutter/material.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/presentation/others/login/screen_signup.dart';
import 'package:merchant_watches/presentation/widgets/bottom_navigation_bar.dart';

class ScreenSignIn extends StatelessWidget {
  const ScreenSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                right: 10,
                left: 10),
            children: [
              const Text(
                'SignIn',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              ksizedBoxheight20,
              const Text(
                'Please sign in to continue',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              ksizedBoxheight20,
              TextFormField(
                autocorrect: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'user name or mailId ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ksizedBoxheight20,
              TextFormField(
                autocorrect: true,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'password ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ksizedBoxheight50,
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBackgroundColor,
                      elevation: 5,
                      padding: const EdgeInsets.only(
                          left: 35, right: 35, top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CustomBNavBar(),
                  )),
                  child: const Text(
                    'SignIn',
                    style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ScreenSignUp(),
                    )),
                    child: const Text(
                      'SignUp',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
