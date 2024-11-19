part of 'form_bloc.dart';

@immutable
abstract class FormStateAD {}

class FormInitial extends FormStateAD {}
class FormLoading extends FormStateAD {

}
class FormError extends FormStateAD {
  var iserror;

  FormError(this.iserror);
}
class FormValid extends FormStateAD {

}

