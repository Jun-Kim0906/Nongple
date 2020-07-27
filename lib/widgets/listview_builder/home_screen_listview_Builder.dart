import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/widgets/widgets.dart';

class HomeScreenListViewBuilder extends StatefulWidget {
  @override
  _HomeScreenListViewBuilderState createState() => _HomeScreenListViewBuilderState();
}

class _HomeScreenListViewBuilderState extends State<HomeScreenListViewBuilder> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is FacilityListSet) {
        state.facList.forEach((list) {
          print('[Home Screen ListView Builder] ${list.name} : ${list.temperature} }');
          print('[Home Screen ListView Builder] ${list.name} : ${list.bgUrl} }');
        });
        return ListView.builder(
          itemCount: state.facList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                BlocProvider.value(
                  value: _homeBloc,
                  child: HomePageCard(
                    facList: state.facList[index],
                  ),
                ),
                SizedBox(
                  height: height * 0.017,
                ),
                index == state.facList.length - 1 ? ButtonCard() : Container(),
              ],
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
