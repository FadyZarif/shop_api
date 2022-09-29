abstract class RegisterStates  {}

class RegisterInitialState extends RegisterStates{}


class LoginChangeVisibilityState extends RegisterStates{}


class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final registerModel;

  RegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends RegisterStates{}