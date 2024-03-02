class authState {}

class authInitState extends authState {}

//login
class loginLoadingState extends authState {}

class loginsucssesState extends authState {}

class loginErrorState extends authState {
  final String error;

  loginErrorState({required this.error});
}

//signUp
class signUpLoadingState extends authState {}

class signUpsucssesState extends authState {}

class signUpErrorState extends authState {
  final String error;

  signUpErrorState({required this.error});
}
class uploadDoctorLoadingState extends authState {}

class uploadDoctorsucssesState extends authState {}

class uploadDoctorErrorState extends authState {
  final String error;

 uploadDoctorErrorState({required this.error});
}
