import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';

class HomePageCard extends StatefulWidget {
  final Facility facList;

  HomePageCard({
    Key key,
    this.facList,
  }) : super(key: key);

  @override
  _HomePageCardState createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  HomeBloc _homeBloc;
  String addr;
  String bgUrl;
  int category;
  String fid;
  String name;
  String temperature;
  String uid;

  @override
  void initState() {
    super.initState();
    addr = widget.facList.addr;
    bgUrl = widget.facList.bgUrl;
    category = widget.facList.category;
    fid = widget.facList.fid;
    name = widget.facList.name;
    temperature = widget.facList.temperature;
    uid = widget.facList.uid;
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('[Card] ${widget.facList.name} : ${widget.facList.bgUrl} }');
    print('[Card] ${name} : ${bgUrl} }');
    return Card(
      elevation: 4.0,
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: widget.facList.bgUrl.isNotEmpty
                  ? Image(
                      image: CachedNetworkImageProvider(widget.facList.bgUrl),
                      fit: BoxFit.cover,
                      color: Color.fromRGBO(255, 255, 255, 100),
                      colorBlendMode: BlendMode.modulate,
                    )
                  : Image.asset("assets/white.png"),
            ),
          ),
          InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('card tapped');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<TabBloc>(
                                create: (context) => TabBloc(),
                              ),
                              BlocProvider<JournalMainBloc>(
                                create: (context) => JournalMainBloc()
                                  ..add(GetJournalPictureList(fid: widget.facList.fid)),
                              ),
                              BlocProvider.value(
                                value: _homeBloc,
                              )
                            ],
                            child: TabScreen(facList: widget.facList),
                          )
//                      BlocProvider<TabBloc>(
//                        create: (context) => TabBloc(),
//                        child: TabScreen(),
//                      )
                      ));
            },
            child: Container(
              height: height / 5,
              width: width,
              padding: EdgeInsets.fromLTRB(
                  width / 25, height / 35, width / 25, height / 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.facList.name,
                                style: cardWidgetFacilityNameStyle,
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Text(
                                widget.facList.addr,
                                style: cardWidgetAddrStyle,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          widget.facList.temperature + degrees + 'C',
                          style: cardWidgetWeatherDataStyle,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: height / 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            backgroundColor: Colors.white,
                            elevation: 1.0,
                            label: Text(
                              ' 자세히보기 ',
                              style: cardWidgetDetailButtonStyle,
                            ),
                          ),
                          Container(
//                        width: width,
//                        height: height,
                            child: Card(
                              elevation: 2.0,
                              child: (widget.facList.category == 1 || widget.facList.category == 2)
                                  ? Icon(
                                      CustomIcons.tractor,
                                      color: Color(0xFF2F80ED),
                                      size: 25,
                                    )
                                  : (widget.facList.category == 3)
                                      ? Icon(
                                          CustomIcons.cow,
                                          color: Color(0xFF2F80ED),
                                          size: 25,
                                        )
                                      : Icon(
                                          CustomIcons.plant,
                                          color: Color(0xFF2F80ED),
                                          size: 25,
                                        ),
                              shape: CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
