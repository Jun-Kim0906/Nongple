import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:nongple/blocs/add_facilitiy_bloc/bloc.dart';
import 'package:nongple/widgets/widgets.dart';

class FacilityCreateScreen4 extends StatefulWidget {
  @override
  _FacilityCreateScreenState createState() => _FacilityCreateScreenState();
}

class _FacilityCreateScreenState extends State<FacilityCreateScreen4> {
  AddFacilityBloc _addFacilityBloc;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _addFacilityBloc = BlocProvider.of<AddFacilityBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return BlocBuilder<AddFacilityBloc, AddFacilityState>(
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).primaryColorLight,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                leading: IconButton(
                  color: Colors.blue[600],
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.06,
                    ),
                    SizedBox(
                      height: height*0.0959,
                      width: width*0.786,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '축하합니다 ' + EmojiParser().emojify('🎉')+'\n시설 등록이 완료되었습니다.',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width*0.17, height*0.044, width*0.17, height*0.044),
                        width: width,
                        height: height/3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.14,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Icon(
                                  state.facilityCategory == 4
                                      ? CustomIcons.plant
                                      : state.facilityCategory == 3 ? CustomIcons.cow : CustomIcons.tractor,
                                  size: width/3,
                                  color: Color(0xFF2F80ED),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  state.facilityName,
                                  style: TextStyle(color: Colors.black, fontSize: 28.8, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                state.facilityAddr,
                                style: TextStyle(fontSize: 16.6),
                                textAlign: TextAlign.center,
                                minFontSize: 2,
                                stepGranularity: 2,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationButton(
                  title: '홈으로 돌아가기',
                  onPressed: state.facilityCategory!=0
                      ? () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                      : null));
        });
  }
}
