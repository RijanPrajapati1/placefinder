import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placefinder/resources/app_assets.dart';
import 'package:placefinder/resources/app_color.dart';
import 'package:placefinder/routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  void _startSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Safe navigation using GoRouter
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            Center(
              child: Image.asset(
                AppAssets.placeFinder,
                width: deviceWidth * 6,
                fit: BoxFit.contain,
              ),
            ),

            const Spacer(),

            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: CircularProgressIndicator(color: AppColor.primary),
            ),
          ],
        ),
      ),
    );
  }
}
