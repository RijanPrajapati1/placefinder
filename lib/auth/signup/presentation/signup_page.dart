import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placefinder/core/firebase_service.dart';
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
  bool _isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? nameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearErrors() {
    setState(() {
      nameError = null;
      emailError = null;
      phoneError = null;
      passwordError = null;
      confirmPasswordError = null;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

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
          children: [
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

            // Name Field
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              onChanged: (_) => _clearErrors(),
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: const TextStyle(color: AppColor.black),
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColor.black,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                errorText: nameError,
                errorStyle: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 20),

            // Email, Phone, Password, Confirm Password fields (same as before)
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => _clearErrors(),
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: const TextStyle(color: AppColor.black),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColor.black,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                errorText: emailError,
                errorStyle: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (_) => _clearErrors(),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: const TextStyle(color: AppColor.black),
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: AppColor.black,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                errorText: phoneError,
                errorStyle: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: !_passwordVisible,
              onChanged: (_) => _clearErrors(),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: AppColor.black),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColor.black,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColor.black,
                  ),
                  onPressed: () =>
                      setState(() => _passwordVisible = !_passwordVisible),
                ),
                errorText: passwordError,
                errorStyle: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: confirmPasswordController,
              obscureText: !_confirmPasswordVisible,
              onChanged: (_) => _clearErrors(),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: const TextStyle(color: AppColor.black),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColor.black,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black, width: 2),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColor.black,
                  ),
                  onPressed: () => setState(
                    () => _confirmPasswordVisible = !_confirmPasswordVisible,
                  ),
                ),
                errorText: confirmPasswordError,
                errorStyle: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final phone = phoneController.text.trim();
                        final password = passwordController.text.trim();
                        final confirmPassword = confirmPasswordController.text
                            .trim();

                        _clearErrors();
                        bool hasError = false;

                        if (name.isEmpty) {
                          setState(() => nameError = "Full name is required");
                          hasError = true;
                        }
                        if (email.isEmpty) {
                          setState(() => emailError = "Email is required");
                          hasError = true;
                        } else if (!_isValidEmail(email)) {
                          setState(
                            () => emailError =
                                "Please enter a valid email address",
                          );
                          hasError = true;
                        }
                        if (phone.isEmpty) {
                          setState(
                            () => phoneError = "Phone number is required",
                          );
                          hasError = true;
                        } else if (phone.length != 10 ||
                            !RegExp(r'^[0-9]+$').hasMatch(phone)) {
                          setState(
                            () => phoneError =
                                "Phone number must be exactly 10 digits",
                          );
                          hasError = true;
                        }
                        if (password.isEmpty) {
                          setState(
                            () => passwordError = "Password is required",
                          );
                          hasError = true;
                        } else if (password.length < 6) {
                          setState(
                            () => passwordError =
                                "Password must be at least 6 characters",
                          );
                          hasError = true;
                        }
                        if (confirmPassword.isEmpty) {
                          setState(
                            () => confirmPasswordError =
                                "Confirm password is required",
                          );
                          hasError = true;
                        } else if (password != confirmPassword) {
                          setState(
                            () =>
                                confirmPasswordError = "Passwords do not match",
                          );
                          hasError = true;
                        }

                        if (hasError) return;

                        setState(() => _isLoading = true);

                        try {
                          await _authService.signUp(
                            name: name,
                            email: email,
                            phone: phone,
                            password: password,
                          );

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Account created successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          context.goNamed(Routes.login);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "The email address is already in use by another account",
                                ),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 4),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error: ${e.message ?? e.code}"),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Something went wrong. Please try again",
                              ),
                            ),
                          );
                        } finally {
                          if (mounted) setState(() => _isLoading = false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text('SIGN UP', style: TextStyle(fontSize: 18)),
              ),
            ),

            // Rest of your UI (Or continue with, Already have account...) remains same
            SizedBox(height: deviceHeight * 0.01),
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
              children: [
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
