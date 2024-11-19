part of 'special_deal_bloc.dart';


abstract class SpecialDealEvent {


}

class FetchDeal extends SpecialDealEvent{

}
class ClearState  extends SpecialDealEvent{

}

class FetchById extends SpecialDealEvent{
 var id;

 FetchById(this.id);
}



