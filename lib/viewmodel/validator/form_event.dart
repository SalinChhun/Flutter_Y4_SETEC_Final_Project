part of 'form_bloc.dart';

@immutable
abstract class FormEvent {}

class CheckValidateevent extends FormEvent {
    var iserrorpass ;
    var iserroremail;

    CheckValidateevent({this.iserroremail,this.iserrorpass});
}
