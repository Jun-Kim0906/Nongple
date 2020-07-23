
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
class BgState extends Equatable{
  const BgState();

  @override
  List<Object> get props => [];
}

class InitialBgUrl extends BgState{}

class BgUrlSet extends BgState{
  final String bgUrl;

  const BgUrlSet(this.bgUrl);

  List<Object> get props => [bgUrl];

  @override
  String toString()=>'BgUrlSet { BgUrl : $bgUrl }';
}