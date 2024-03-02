import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/email_validate.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widget/custom_button.dart';
import 'package:se7ety/core/widget/navigator.dart';
import 'package:se7ety/features/auth/presentation/view/introViews/signUpView.dart';

class loginView extends StatefulWidget {
  const loginView({super.key, required this.index});
  final int index;
  @override
  State<loginView> createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  bool isVisible = true;
  String handleuesrType() {
    return widget.index == 0 ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/splash.png',
                  height: 230,
                  width: 230,
                ),
                const Gap(20),
                Text(
                  '"سجل الدخول الان ك "${handleuesrType()}',
                  style: getTitleStyle(),
                ),
                const Gap(20),
                TextFormField(
                  textAlign: TextAlign.left,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'من فضلك ادخل الايميل';
                    } else if (!emailValidate(value)) {
                      return 'من فضلك ادخل الايميل صحيحا';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.email,
                        color: appColors.bottonColor,
                      ),
                      hintText: 'ahmed@example.com'),
                ),
                const Gap(20),
                TextFormField(
                  textAlign: TextAlign.left,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isVisible,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          (isVisible)
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: appColors.bottonColor,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: appColors.bottonColor,
                      ),
                      hintText: 'enter your password'),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'نسيت كلمه السر؟',
                      style: getbodyStyle(fontSize: 13),
                    ),
                  ],
                ),
                const Gap(25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: customButton(
                      forGround: appColors.scaffColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      text: 'تسجيل الدخول'),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(5),
                    Text(
                      'ليس لدي حساب؟',
                      style: getbodyStyle(),
                    ),
                    InkWell(
                      onTap: () {
                        routing(
                            context,
                            signUpView(
                              index: widget.index,
                            ));
                      },
                      child: Text(
                        'سجل الان',
                        style: getbodyStyle(color: appColors.bottonColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
