import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/splash_screen/splash_screen.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:nongple/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({Key key, @required String name})
      : this.name = name,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    this.name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FacilityListSet) {
          state.facList.forEach((list) {
//            print('[home screen] ${list.name} : ${list.temperature} }');
//            print('[home screen] ${list.name} : ${list.bgUrl} }');
          });
          return Scaffold(
            backgroundColor: bodyColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name 님\n오늘도 풍성한 하루 되세요',
//                style: Theme.of(context).textTheme.headline1,
                      style: homeMainTitle,
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                    Text(
                      '$year년 $month월 $day일 $weekday',
//                style: Theme.of(context).textTheme.headline2,
                      style: homeSubTitle,
                    ),
                    SizedBox(
                      height: height * 0.018,
                    ),
                    Container(
                      child: BlocProvider.value(
                        value: _homeBloc,
                        child: ChipButton(),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.016,
                    ),
                    (state.facList.length == 0)
                        ? ButtonCard()
                        : Expanded(
                            child: BlocProvider.value(
                              value: _homeBloc,
                              child: HomeScreenListViewBuilder(),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
