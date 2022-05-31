abstract class LoginStates {}
class LoginInitialState extends LoginStates {}
class RefreshScreenState extends LoginStates{}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  String uId ;
  LoginSuccessState (this.uId);
}
class LoginErrorState extends LoginStates {
  final String error ;
  LoginErrorState(this.error);
}

class PasswordIconChanged extends LoginStates{}

class LoadingForgetPasswordState extends LoginStates {}
class SuccessForgetPasswordState extends LoginStates {}
class ErrorForgetPasswordState extends LoginStates {}

class LoadingVerifyCodeState extends LoginStates {}
class SuccessVerifyCodeState extends LoginStates {}
class ErrorVerifyCodeState extends LoginStates {}

class LoadingResetPasswordState extends LoginStates {}
class SuccessResetPasswordState extends LoginStates {}
class ErrorResetPasswordState extends LoginStates {}