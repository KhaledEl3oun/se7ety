import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/patient/search/data/doctorModel.dart';
import 'package:se7ety/features/auth/presentation/view_model/authState.dart';

class authCubit extends Cubit<authState> {
  authCubit() : super(authInitState());

  //login

  //signUp as doctor
  signUpDoctor(String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('doctor').doc(user.uid).set({
        'name': name,
        'image': null,
        'specialization': null,
        'rating': null,
        'email': user.email,
        'phone1': null,
        'phone2': null,
        'bio': null,
        'openHour': null,
        'closeHour': null,
        'address': null,
      }, SetOptions(merge: true));

      emit(signUpsucssesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(signUpErrorState(error: 'كلمة السر ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(signUpErrorState(error: 'الحساب موجود بالفعل'));
      } else {
        emit(signUpErrorState(error: 'حدثت مشكله فالتسجيل حاول لاحقا'));
      }
    }
  }

  //signUp as sick
  signUpSick(String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = credential.user!;
      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('patient').doc(user.uid).set({
        'name': name,
        'image': '',
        'email': user.email,
        'bio': '',
        'city': '',
        'phone': '',
        'age': null,
      }, SetOptions(merge: true));

      emit(signUpLoadingState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(signUpErrorState(error: 'كلمة السر ضعيفه'));
      } else if (e.code == 'email-already-in-use') {
        emit(signUpErrorState(error: 'الحساب موجود بالفعل'));
      } else {
        emit(signUpErrorState(error: 'حدثت مشكله فالتسجيل حاول لاحقا'));
      }
    }
  }

  uploadDoctorData(doctorModel doctor) {
    emit(uploadDoctorLoadingState());

    try {
      FirebaseFirestore.instance.collection('doctor').doc(doctor.id).set({
        'image': doctor.image,
        'name':doctor.name,
         'email': doctor.email,
        'specialization': doctor.specialization,
        'rating': doctor.rating,
        'phone1': doctor.phone1,
        'phone2': doctor.phone2,
        'bio': doctor.bio,
        'openHour': doctor.openHour,
        'closeHour': doctor.closeHour,
        'address': doctor.address,
      });
      emit(uploadDoctorsucssesState());
    } catch (e) {
      emit(uploadDoctorErrorState(error: 'حدثت مشكله فالتسجيل حاول لاحقا'));
    }
  }
}
