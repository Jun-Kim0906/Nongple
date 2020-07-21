import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/main.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class TabScreen extends StatefulWidget {
  final Facility facList;

  TabScreen({
    Key key,
    this.facList,
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
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          backgroundColor: bodyColor,
          appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: 0.0,
            leading: IconButton(
              color: journalGoBackArrowColor,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Column(
              children: [
                (activeTab == AppTab.weather)
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
                Text(
                  widget.facList.name,
                  style: tabAppBarSubtitleStyle,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: (activeTab == AppTab.weather)
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _homeBloc,
                    ),
                    BlocProvider<WeatherBloc>(
                      create: (BuildContext context) => WeatherBloc()..add(GetWeather()),
                    )
                  ],
                  child: WeatherScreen(),
                )
              : (activeTab == AppTab.journal) ? JournalMain(fid: widget.facList.fid) : Dictionary(),
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
