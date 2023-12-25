import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/routes/routes_navigation.dart';

class RegisterViewModel extends ChangeNotifier {
  bool isLoading = false;

  bool _visiblePassword = true;
  bool get visiblePassword => _visiblePassword;
  bool _visibleConfirmPassword = true;
  bool get visibleConfirmPassword => _visibleConfirmPassword;

  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  final _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  String? errorMessage;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> register({required BuildContext context}) async {
    isLoading = true;
    notifyListeners();

    try {
      CollectionReference akunCollection = firestore.collection('akun');

      String name = _nameController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String password = _passwordController.text;

      bool isValid = valueValidator(
        name,
        phone,
        email,
        password,
      );

      if (isValid) {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final docId = akunCollection.doc().id;
        await akunCollection.doc(docId).set({
          'uid': auth.currentUser!.uid,
          'nama': name,
          'email': email,
          'noHP': phone,
          'docId': docId,
          'role': 'user',
        });

        clear(); // untuk mengosongkan input

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNavigation.login,
            (route) => false,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Register Gagal'),
          ),
        );
      }
      throw Exception("GAGAL MELAKUKAN REGISTER ${e.message}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool valueValidator(
    String name,
    String phone,
    String email,
    String password,
  ) {
    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage = 'Input Tidak Boleh Kosong';
      return false;
    } else {
      errorMessage = null;
      return true;
    }
  }

  void clear() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
    _nameController.text = "";
    _phoneController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
    notifyListeners();
  }

  void isVisiblePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  void isVisibleConfirmPassword() {
    _visibleConfirmPassword = !_visibleConfirmPassword;
    notifyListeners();
  }
}
