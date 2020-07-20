import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/screens/splash_screen/splash_screen.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/widgets/widgets.dart';

class ListViewBuilder extends StatefulWidget {
//  List<Facility> facList;
//
//  ListViewBuilder({
//    Key key,
//    this.facList,
//  }) : super(key: key);

  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FacilityListSet) {
          return ListView.builder(
            itemCount: state.facList.length,
            itemBuilder: (BuildContext context, int index) {
//        return Container();
        return Column(
          children: <Widget>[
            BlocProvider.value(
                      value: _homeBloc,
                      child: HomePageCard(facList: state.facList[index],),
                    ),
            SizedBox(height: height*0.017,),
            index == widget.facList.length -1
                ?ButtonCard()
                :Container(),
          ],
        );
//        if (index == widget.facList.length - 1) {
//          return Column(
//            children: [
//              HomePageCard(facList: widget.facList[index],),
//              SizedBox(
//                height: height * 0.017,
//              ),
//              ButtonCard(),
//              SizedBox(
//                height: height * 0.017,
//              ),
//            ],
//          );
//        } else {
//          return Column(
//            children: [
//              HomePageCard(facList: widget.facList[index],),
//              SizedBox(
//                height: height * 0.017,
//              ),
//            ],
//          );
//        }
//                    return HomePageCard();
      },
    );
  }
}
