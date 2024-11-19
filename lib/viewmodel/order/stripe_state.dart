part of 'stripe_bloc.dart';


abstract class StripeState {}

class StripeInitial extends StripeState {



}


class StripeLoading extends StripeState {

}

class StripeSuccess extends StripeState {

}
class StripeFail extends StripeState {

}