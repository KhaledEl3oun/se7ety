import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/functions/custom_error.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widget/custom_button.dart';
import 'package:se7ety/core/widget/navigatorReplace.dart';
import 'package:se7ety/features/auth/presentation/view/comSign.dart';
import 'package:se7ety/features/auth/presentation/view/loginView.dart';
import 'package:se7ety/features/auth/presentation/view_model/authCubit.dart';
import 'package:se7ety/features/auth/presentation/view_model/authState.dart';

class signUpView extends StatefulWidget {
  const signUpView({super.key, required this.index});
  final int index;
  @override
  State<signUpView> createState() => _signUpViewState();
}

class _signUpViewState extends State<signUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = true;
  String handleuesrType(int index) {
    return index == 0 ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<authCubit, authState>(
      listener: (context, state) {
        if (state is signUpsucssesState) {
          pushAndRemoveUntil(context, const comSign());
        } else if (state is signUpErrorState) {
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 65, 15, 0),
            child: Form(
              key: _formKey,
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
                    '"سجل حساب جديد ك "${handleuesrType(widget.index)}',
                    style: getTitleStyle(),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: _displayController,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.person,
                        color: appColors.bottonColor,
                      ),
                      hintText: 'الاسم',
                    ),
                  ),
                  const Gap(15),
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _emailController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.email,
                          color: appColors.bottonColor,
                        ),
                        hintText: 'ahmed@example.com'),
                  ),
                  const Gap(15),
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _passwordController,
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
                  const Gap(15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: customButton(
                        forGround: appColors.scaffColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.index == 0) {
                              context.read<authCubit>().signUpDoctor(
                                  _displayController.text,
                                  _emailController.text,
                                  _passwordController.text);
                            } else {
                              context.read<authCubit>().signUpSick(
                                  _displayController.text,
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          }
                        },
                        text: 'تسجيل الدخول'),
                  ),
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لدي حساب ؟',
                        style: getbodyStyle(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) =>
                                  loginView(index: widget.index),
                            ));
                          },
                          child: Text(
                            'سجل دخول',
                            style: getbodyStyle(color: appColors.bottonColor),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
