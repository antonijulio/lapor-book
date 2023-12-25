import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lapor_book/components/styles.dart';
import 'package:lapor_book/components/input_widget.dart';
import 'package:lapor_book/components/button_widget.dart';

import 'package:lapor_book/routes/routes_navigation.dart';

import 'package:lapor_book/view/register/view_model/register_view_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RegisterViewModel>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    //* TITLE REGISTER
                    Text(
                      'Register',
                      style: headerStyle(level: 1),
                    ),
                    const SizedBox(height: 24),

                    //* INPUT NAMA LENGKAP
                    InputWidget(
                      hintText: 'Nama Lengkap',
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      errorText: controller.errorMessage,
                    ),
                    const SizedBox(height: 24),

                    //* INPUT EMAIL
                    InputWidget(
                      hintText: 'Email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      errorText: controller.errorMessage,
                    ),
                    const SizedBox(height: 24),

                    //* INPUT NOMOR HP
                    InputWidget(
                      hintText: 'No Handphone',
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      errorText: controller.errorMessage,
                    ),
                    const SizedBox(height: 24),

                    //* INPUT PASSWORD
                    InputWidget(
                      hintText: 'Password',
                      controller: controller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      errorText: controller.errorMessage,
                      obscureText: controller.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () => controller.isVisiblePassword(),
                        color: Colors.grey,
                        icon: controller.visiblePassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),

                    //* SUDAH PUNYA AKUN?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sudah Punya Akun? '),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            RoutesNavigation.login,
                          ),
                          child: const Text(
                            'Login Disini',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    //* BUTTON REGISTER
                    ButtonWidget(
                      label: controller.isLoading
                          ? const Center(
                              child: Flexible(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                      backgroundColor: controller.isLoading
                          ? Colors.grey.shade300
                          : Colors.amber,
                      onPressed: () {
                        // fungsi dijalankan ketika loading false
                        if (controller.isLoading == false) {
                          controller.register(context: context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
