part of 'product_fav_bloc.dart';


abstract class ProductFavEvent {



}
class ShowFavorite extends ProductFavEvent {

  var userid;

  ShowFavorite(this.userid);
}
class AddFavorite extends ProductFavEvent {

  var userid;
  var pid;

  AddFavorite(this.userid,this.pid);
}
class RemoveFavorite extends ProductFavEvent {

  var userid;
  var pid;

  RemoveFavorite(this.userid,this.pid);
}
class ProductById extends ProductFavEvent {

  var userid;
  var pid;

  ProductById(this.userid,this.pid);
}