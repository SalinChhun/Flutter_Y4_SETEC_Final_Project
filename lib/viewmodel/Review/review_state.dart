part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}
class ReviewLoading extends ReviewState {
  @override
  // TODO: implement props
  List<Object> get props => [];


}
class ReviewCompleted extends ReviewState {
  ReviewModel?  review;
  ReviewCompleted({this.review});
  @override
  // TODO: implement props
  List<Object> get props => [];


}


class ReviewError extends ReviewState {
  var error;
  ReviewError({this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];


}
class ReviewPostLoading extends ReviewState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ReviewPostCompleted extends ReviewState {

  ResponseReview?  responseReview;


  ReviewPostCompleted( {this.responseReview });

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ReviewPostErrorMessage extends ReviewState {

  var message;


  ReviewPostErrorMessage(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ReviewPostError extends ReviewState {
  var error;


  ReviewPostError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}