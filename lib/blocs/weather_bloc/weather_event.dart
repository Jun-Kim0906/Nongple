

import 'package:equatable/equatable.dart';
import 'package:nongple/blocs/home_bloc/home_bloc.dart';

class WeatherEvent extends Equatable {
  const WeatherEvent();

  List<Object> get props => [];
}

class GetWeather extends WeatherEvent{
  final String fid;
  final String nx;
  final String ny;

  const GetWeather(this.fid, this.ny, this.nx);

  List<Object> get props => [fid, ny, nx];

  @override
  String toString() => 'GetWeather { fid : $fid, nx : $nx, ny : $ny }';
}