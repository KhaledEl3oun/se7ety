import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/functions/custom_error.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widget/navigatorReplace.dart';
import 'package:se7ety/features/patient/search/data/doctorModel.dart';
import 'package:se7ety/features/auth/data/specializations.dart';
import 'package:se7ety/features/patient/home/presentation/navBar.dart';
import 'package:se7ety/features/auth/presentation/view_model/authCubit.dart';
import 'package:se7ety/features/auth/presentation/view_model/authState.dart';

class comSign extends StatefulWidget {
  const comSign({super.key});

  @override
  State<comSign> createState() => _comSignState();
}

class _comSignState extends State<comSign> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone1 = TextEditingController();
  final TextEditingController _phone2 = TextEditingController();
  String _specialization = specialization[0];
  late String _startTime =
      DateFormat('hh').format(DateTime(2023, 9, 7, 10, 00));
  late String _endTime = DateFormat('hh').format(DateTime(2023, 9, 7, 22, 00));

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _imagePath;
  File? file;
  String? profileUrl;

  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  // 1) instance from FirebaseStorage with bucket Url..
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://se7ety-1ae1c.appspot.com');

  // method to upload and get link of image
  Future<String> uploadImageToFireStore(File image) async {
    //2) choose file location (path)
    var ref = _storage.ref().child('doctors/${_auth.currentUser!.uid}');
    //3) choose file type (image/jpeg)
    var metadata = SettableMetadata(contentType: 'image/jpeg');
    // 4) upload image to Firebase Storage
    await ref.putFile(image, metadata);
    // 5) get image url
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        // to upload the file (image) to firebase storage
        file = File(pickedFile.path);
      });
    }
    profileUrl = await uploadImageToFireStore(file!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<authCubit, authState>(
      listener: (context, state) {
        if (state is uploadDoctorsucssesState) {
          pushAndRemoveUntil(context, const navBar());
        } else if (state is uploadDoctorErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.abc,
            color: appColors.bottonColor,
          ),
          backgroundColor: appColors.bottonColor,
          title: Text(
            'اكمال عملية التسجيل',
            style: getTitleStyle(color: appColors.scaffColor),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: (_imagePath != null)
                              ? FileImage(File(_imagePath!)) as ImageProvider
                              : const AssetImage('assets/doc.png'),
                          radius: 65,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await _pickImage();
                            },
                            child: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.camera_alt,
                                color: appColors.bottonColor,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'التخصص',
                          style: getbodyStyle(),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 155, 210, 255)
                              .withOpacity(.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButton(
                          isExpanded: true,
                          iconEnabledColor:
                              const Color.fromARGB(255, 0, 140, 255)
                                  .withOpacity(.7),
                          icon: const Icon(Icons.expand_circle_down_outlined),
                          value: _specialization,
                          items: specialization.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _specialization = newValue ?? specialization[0];
                            });
                          }),
                    ),
                    const Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'نبدة تعريفيه',
                          style: getbodyStyle(),
                        ),
                      ],
                    ),
                    const Gap(10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل النبذة التعريفية';
                        } else {
                          return null;
                        }
                      },
                      controller: _bio,
                      textAlign: TextAlign.end,
                      maxLines: 6,
                      decoration: InputDecoration(
                          hintText:
                              'سجل المعلومات الطبيه العامه مثل تعليمك الاكاديمي وخبراتك السابقه',
                          hintStyle: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.grey)),
                    ),
                    const Gap(10),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'عنوان العياده',
                          style: getbodyStyle(),
                        ),
                      ],
                    ),
                    const Gap(10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل عنوان العيادة';
                        } else {
                          return null;
                        }
                      },
                      controller: _address,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                          hintText: 'شارع مصدق - الدقي - الجيزه',
                          hintStyle: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.grey)),
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    style: getbodyStyle(),
                                    'ساعات العمل من ',
                                  ),
                                ],
                              ),
                              const Gap(10),
                              TextFormField(
                                readOnly: true,
                                onTap: () async {
                                  await showStartTimePicker();
                                },
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.watch_later_outlined,
                                      color: appColors.bottonColor,
                                    ),
                                    hintText: _startTime,
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            GoogleFonts.cairo().fontFamily,
                                        color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'الي',
                                    style: getbodyStyle(),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              TextFormField(
                                readOnly: true,
                                onTap: () async {
                                  await showEndTimePicker();
                                },
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.watch_later_outlined,
                                      color: appColors.bottonColor,
                                    ),
                                    hintText: _endTime,
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            GoogleFonts.cairo().fontFamily,
                                        color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'رقم الهاتف 1',
                          style: getbodyStyle(),
                        ),
                      ],
                    ),
                    const Gap(10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الرقم';
                        } else {
                          return null;
                        }
                      },
                      controller: _phone1,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                          hintText: '20xxxxxxxxxx +',
                          hintStyle: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.grey)),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'رقم الهاتف 2 (اختياري)',
                          style: getbodyStyle(),
                        ),
                      ],
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: _phone2,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                          hintText: '20xxxxxxxxxx +',
                          hintStyle: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              color: Colors.grey)),
                    ),
                    const Gap(70),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<authCubit>().uploadDoctorData(
                              doctorModel(
                                  id: user!.uid,
                                  name: user?.displayName ?? '',
                                  image: profileUrl ?? '',
                                  specialization: _specialization,
                                  rating: '3',
                                  email: user!.email!,
                                  phone1: _phone1.text,
                                  phone2: _phone2.text,
                                  bio: _bio.text,
                                  openHour: _startTime,
                                  closeHour: _endTime,
                                  address: _address.text));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: appColors.bottonColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'التسجيل',
                            style: getTitleStyle(color: appColors.scaffColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showStartTimePicker() async {
    final datePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      // builder: (context, child) {
      //   return Theme(
      //     data: ThemeData(
      //       timePickerTheme: TimePickerThemeData(
      //           helpTextStyle: TextStyle(color: AppColors.color1),
      //           backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      //       colorScheme: ColorScheme.light(
      //         background: Theme.of(context).scaffoldBackgroundColor,
      //         primary: AppColors.color1, // header background color
      //         secondary: AppColors.black,
      //         onSecondary: AppColors.black,
      //         onPrimary: AppColors.black, // header text color
      //         onSurface: AppColors.black, // body text color
      //         surface: AppColors.black, // body text color
      //       ),
      //       textButtonTheme: TextButtonThemeData(
      //         style: TextButton.styleFrom(
      //           foregroundColor: AppColors.color1, // button text color
      //         ),
      //       ),
      //     ),
      //     child: child!,
      //   );
      // },
    );

    if (datePicked != null) {
      setState(() {
        _startTime = datePicked.hour.toString();
      });
    }
  }

  showEndTimePicker() async {
    final timePicker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),
    );

    if (timePicker != null) {
      setState(() {
        _endTime = timePicker.hour.toString();
      });
    }
  }
}
