abstract class RegisterState {}
class RegisterInitialState extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}
class CreateUserSuccessState extends RegisterState {
  String uId ;
  CreateUserSuccessState (this.uId);
}
class CreateUserErrorState extends RegisterState {
  final String error;
  CreateUserErrorState(this.error);
}
class RegisterPasswordIconChanged extends RegisterState {}
