part of 'special_deal_bloc.dart';

@immutable
abstract class SpecialDealState {}

class SpecialDealInitial extends SpecialDealState {


}

class ResetState  extends SpecialDealState {

}
class SepcialDealLoading  extends SpecialDealState {

}
class SepcialDealCompleted  extends SpecialDealState {
SuperDealModel? superDealModel;

SepcialDealCompleted(this.superDealModel);
}

class SpecialDealError  extends SpecialDealState {
  var errormessage;

  SpecialDealError(this.errormessage);
}

class SepcialDealByIdLoading extends SpecialDealState {



}
class SepcialDealByIdCompleted extends SpecialDealState {

  SuperDealSingle? superDealSingle;

  SepcialDealByIdCompleted(this.superDealSingle);
}
class SepcialDealByIdError extends SpecialDealState {



}
