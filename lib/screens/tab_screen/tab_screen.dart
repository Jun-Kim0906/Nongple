import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class TabScreen extends StatefulWidget {
  final Facility facility;

  TabScreen({
    Key key,
    this.facility,
  }) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          backgroundColor: bodyColor,
          appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: 0.0,
            leading: IconButton(
              color: goBackArrowColor,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Column(
              children: [
                SizedBox(
                  width: width*0.0833,
                  height: height*0.0329,
                  child: FittedBox(
                    child: (activeTab == AppTab.weather)
                        ? Text(
                            '날씨',
                            style: tabAppBarTitleStyle,
                          )
                        : (activeTab == AppTab.journal)
                            ? Text(
                                '일지',
                                style: tabAppBarTitleStyle,
                              )
                            : Text(
                                '용어사전',
                                style: tabAppBarTitleStyle,
                              ),
                  ),
                ),
                Text(
                  widget.facility.name,
                  style: tabAppBarSubtitleStyle,
                ),
              ],
            ),

            centerTitle: true,
          ),
          body: (activeTab == AppTab.weather)
              ? BlocProvider<WeatherBloc>(
                  create: (BuildContext context) => WeatherBloc(),
                  child: WeatherScreen(
                    facility: widget.facility,
                  ),
                )
              : (activeTab == AppTab.journal)
                  ? BlocProvider<JournalMainBloc>(
                      create: (BuildContext context) => JournalMainBloc()
                        ..add(
                            PassFacility(facility: widget.facility)),
                      child: JournalMain())
                  : BlocProvider<DictionaryBloc>(
                      create: (BuildContext context) => DictionaryBloc(),
                      child: DictionaryScreen(),
                    ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
