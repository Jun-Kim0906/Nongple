import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BgEvent extends Equatable{
  const BgEvent();

  @override
  List<Object> get props => [];
}

class UpdateBgUrl extends BgEvent{
  final String bgUrl;
  const UpdateBgUrl(this.bgUrl);

  @override
  List<Object> get props => [bgUrl];

  @override
  String toString()=>'UpdateBgUrl { bgUrl : $bgUrl }';
}