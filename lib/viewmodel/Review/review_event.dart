part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
}
class ReviewFetch extends ReviewEvent {

  var pid;

  ReviewFetch({this.pid});
  @override
  // TODO: implement props
  List<Object?> get props => [pid];



}
class ReviewPost extends ReviewEvent {
  var uid;
  var desc;
  var rating;
  var pid;


  ReviewPost( {this.uid, this.desc, this.rating, this.pid });

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
