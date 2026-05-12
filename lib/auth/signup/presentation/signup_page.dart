import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placefinder/resources/app_color.dart';
import 'package:placefinder/routes/routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(color: AppColor.white, fontSize: 20),
        ),
        backgroundColor: AppColor.primary,
        iconTheme: const IconThemeData(color: AppColor.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: deviceHeight * 0.03),

            const Text(
              'Create an account and start learning!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: deviceHeight * 0.02),

            const TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: AppColor.black),
                prefixIcon: Icon(Icons.person_outline, color: AppColor.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: AppColor.black),
                prefixIcon: Icon(Icons.email_outlined, color: AppColor.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: AppColor.black),
                prefixIcon: Icon(Icons.phone_outlined, color: AppColor.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: AppColor.black),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColor.black,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColor.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              obscureText: !_confirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: const TextStyle(color: AppColor.black),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColor.black,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColor.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('SIGN UP', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: deviceHeight * 0.01),

            // Divider with text
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: AppColor.textGrey),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
              ],
            ),

            SizedBox(height: deviceHeight * 0.04),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: AppColor.black),
                ),
                GestureDetector(
                  onTap: () => context.goNamed(Routes.login),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: Image.asset(assetPath, height: 20, width: 20),
      ),
    );
  }
}
