import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/Review/ResponseReview.dart';
import 'package:equatable/equatable.dart';

import '../../model/Review/ReviewModel.dart';
import '../../repository/Review/ReviewRepository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {

  ReviewRepository reviewRepository = ReviewRepository() ;
  ReviewBloc() : super(ReviewInitial()) {
    on<ReviewFetch>((event, emit)  async {
      // TODO: implement event handler
      try{
        emit(ReviewLoading());

        var res = await reviewRepository.FetchReviewUser(event.pid);
        emit(ReviewCompleted(review: res));

      }catch(error) {
        emit(ReviewError(error: error.toString()));
      }
    });

    on<ReviewPost>((event, emit)  async {
      // TODO: implement event handler
      try{
        emit(ReviewPostLoading());

        var res = await reviewRepository.PostReviewUser(event.pid,event.uid,event.desc,event.rating);
        print("Review in Bloc");
        print(res);

          emit(ReviewPostCompleted(responseReview: res));
        //
        // if(res != null) {
        //   print("true agai ");
        //
        //   emit(ReviewPostErrorMessage(res["message"]));
        //
        //   return res;
        // }
        // else{
        //   ResponseReview response = res;
        //   print(response.rating);
        //   emit(ReviewPostCompleted(responseReview: res));
        // }
        print("Make it");




      }catch(error) {
        print("Error here");
        print(error);
        emit(ReviewPostError(error.toString()));


      }
    });
  }
}
