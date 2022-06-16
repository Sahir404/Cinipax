import 'package:cinepax_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class UserAuthScreen extends StatefulWidget {
  const UserAuthScreen({Key? key}) : super(key: key);

  @override
  State<UserAuthScreen> createState() => _UserAuthScreenState();
}

class _UserAuthScreenState extends State<UserAuthScreen> {
  // final _form = GlobalKey<FormState>();
  final _userNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _createAccount = false;
  // var _submitted = false;
  var _showPassword = false;
  // String _username = '';
  // String _email = '';
  // String _password = '';

  @override
  void initState() {
    _userNameFocusNode.addListener(_updateLabelTextColor);
    _emailFocusNode.addListener(_updateLabelTextColor);
    _passwordFocusNode.addListener(_updateLabelTextColor);
    super.initState();
  }

  @override
  void dispose() {
    _userNameFocusNode.removeListener(_updateLabelTextColor);
    _emailFocusNode.removeListener(_updateLabelTextColor);
    _passwordFocusNode.removeListener(_updateLabelTextColor);
    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _scrollController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Image.asset('assets/images/auth_screen_background.png'),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 260,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: -245,
                        child: Container(
                          height: 488,
                          width: 488,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(110),
                            border: Border.all(color: Colors.black),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            child: Opacity(
                              opacity: 0.7,
                              child: Image.asset(
                                'assets/images/auth_screen_logo_background.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/cinepax_logo.png',
                        width: 236,
                        height: 216,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Welcome Back!',
                      style: kUserAuthTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Please login to your account.',
                      style: kUserAuthSubTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      height: _createAccount ? 170 : 140,
                      child: Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 6),
                          child: SingleChildScrollView(
                            physics: _createAccount
                                ? const AlwaysScrollableScrollPhysics()
                                : null,
                            controller: _scrollController,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: 270,
                                  height: 56,
                                  child: TextFormField(
                                    controller: _userNameController,
                                    style: kTextFormFieldStyle,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Username',
                                      alignLabelWithHint: true,
                                      hintStyle: kTextFormFieldStyle.copyWith(
                                        color: _userNameFocusNode.hasFocus
                                            ? kTextFormFieldColor
                                            : kHintTextColor,
                                      ),
                                      contentPadding: const EdgeInsets.all(18),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: kPrimaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: kPrimaryColor,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.verified_user,
                                            color: kPrimaryColor),
                                        onPressed: () {},
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                      ),
                                    ),
                                    focusNode: _userNameFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    onFieldSubmitted: (_) {
                                      _scrollController.animateTo(
                                        40,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.ease,
                                      );
                                      FocusScope.of(context).requestFocus(
                                          _createAccount
                                              ? _emailFocusNode
                                              : _passwordFocusNode);
                                    },
                                    onSaved: (userName) {
                                      if (userName == null) return;
                                      // _username = userName;
                                    },
                                    validator: (userName) {
                                      if (userName == null ||
                                          userName.isEmpty) {
                                        return 'Please provide username';
                                      } else if (userName.length <= 2) {
                                        return 'Too short, can be b/w 2 to 7 characters';
                                      } else if (userName.length >= 7) {
                                        return 'Too long, can be b/w 2 to 7 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                if (_createAccount)
                                  Column(
                                    children: [
                                      TextFormField(
                                        style: kTextFormFieldStyle,
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintStyle:
                                              kTextFormFieldStyle.copyWith(
                                            color: _passwordFocusNode.hasFocus
                                                ? kTextFormFieldColor
                                                : kHintTextColor,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(18),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: kPrimaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: kPrimaryColor,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          prefixIcon: IconButton(
                                            icon: const Icon(Icons.email,
                                                color: kPrimaryColor),
                                            onPressed: () {},
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                          ),
                                        ),
                                        focusNode: _emailFocusNode,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        onTap: () {
                                          _scrollController.animateTo(
                                            40,
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.ease,
                                          );
                                        },
                                        onFieldSubmitted: (_) {
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.ease,
                                          );
                                          FocusScope.of(context)
                                              .requestFocus(_passwordFocusNode);
                                        },
                                        onSaved: (email) {
                                          if (email == null) return;
                                          // _email = email;
                                        },
                                        validator: (email) {
                                          if (email == null || email.isEmpty) {
                                            return 'Please provide email address';
                                          } else if (!email
                                              .endsWith('@gmail.com')) {
                                            return 'Badly formatted';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                SizedBox(
                                  width: 270,
                                  height: 56,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    style: kTextFormFieldStyle,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: kTextFormFieldStyle.copyWith(
                                        color: _passwordFocusNode.hasFocus
                                            ? kTextFormFieldColor
                                            : kHintTextColor,
                                      ),
                                      contentPadding: const EdgeInsets.all(18),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: kPrimaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: kPrimaryColor,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.lock,
                                            color: kPrimaryColor),
                                        onPressed: () {},
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: _showPassword
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        color: kPrimaryColor,
                                        onPressed: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                      ),
                                    ),
                                    focusNode: _passwordFocusNode,
                                    textInputAction: TextInputAction.done,
                                    obscureText: !_showPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    onTap: () {
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.ease,
                                      );
                                    },
                                    onSaved: (password) {
                                      if (password == null) return;
                                      // _password = password;
                                    },
                                    validator: (password) {
                                      if (password == null ||
                                          password.isEmpty) {
                                        return 'Please provide password';
                                      } else if (password.length <= 5) {
                                        return 'Too short, type at least 6 character';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                if (_createAccount) const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!_createAccount)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 50),
                        child: Text(
                          'Forgot password ?',
                          textAlign: TextAlign.right,
                          style: kUserAuthSubTitle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 30),
                  ],
                ),
                SizedBox(
                  width: 184,
                  height: 47,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kButtonBackgroundColor),
                      alignment: Alignment.center,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(6),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                    child: Text(_createAccount ? 'Register' : 'Login'),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Text(
                    !_createAccount
                        ? 'Create New Account'
                        : 'Already have an account ?',
                    style: kUserAuthSubTitle.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    setState(() {
                      // _submitted = false;
                      _userNameController.clear();
                      _passwordController.clear();
                      _userNameFocusNode.unfocus();
                      _passwordFocusNode.unfocus();
                      _createAccount = !_createAccount;
                    });
                  },
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        left: -16,
                        child: Image.asset(
                          'assets/images/auth_screen_bottom_left_image.png',
                          // alignment: Alignment.bottomLeft,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Positioned(
                        right: 6,
                        bottom: -10,
                        child: Image.asset(
                          'assets/images/auth_screen_bottom_right_image.png',
                          // alignment: Alignment.bottomLeft,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateLabelTextColor() {
    setState(() {});
  }
}
