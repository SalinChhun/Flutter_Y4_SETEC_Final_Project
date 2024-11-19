part of 'user_bloc.dart';


abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class User extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class LoadingUser extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadingUserDone extends UserState {
  UserModel? user;

  LoadingUserDone({this.user });

  @override
  // TODO: implement props
  List<Object?> get props =>[user];
}
class LoadingUserError extends UserState {
  var error;
  LoadingUserError({this.error});
  @override
  // TODO: implement props
  List<Object?> get props =>[error];

}

class UserPatchLoading extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class UserPatchError extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];


}
class UserPatchComplete extends UserState {

  UserResponse? userResponse;

  UserPatchComplete({this.userResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [userResponse];

}

class UserMessageLoading extends UserState  {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UserMessageCompleted extends UserState  {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class UserMessageError extends UserState  {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UserMessageNoInternet extends UserState  {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}