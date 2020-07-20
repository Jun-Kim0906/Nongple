import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/widgets/widgets.dart';

class ListViewBuilder extends StatefulWidget {

  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
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
