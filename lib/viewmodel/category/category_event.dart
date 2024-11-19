part of 'category_bloc.dart';

abstract class CategoryEvent {}

class FetchCategory extends CategoryEvent {}

class FetchCategoryProduct extends CategoryEvent {
  var categoryid;
  FetchCategoryProduct({this.categoryid});
}