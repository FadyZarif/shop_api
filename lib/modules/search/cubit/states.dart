abstract class SearchStates  {}

class SearchInitialState extends SearchStates{}


class LoginChangeVisibilityState extends SearchStates{}


class SearchLoadingState extends SearchStates{}

class SearchSuccessState extends SearchStates{
  final searchModel;

  SearchSuccessState(this.searchModel);
}
class SearchErrorState extends SearchStates{}