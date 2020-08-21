import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:geocoder/geocoder.dart';
import 'package:nongple/blocs/add_facilitiy_bloc/bloc.dart';
import 'package:nongple/screens/facility_create/create_screen.dart';
import 'package:nongple/widgets/widgets.dart';
//import 'package:geocoder/geocoder.dart';

class FacilityCreateScreen2 extends StatefulWidget {
  String facilityName;

  FacilityCreateScreen2({Key key, String facilityName})
      : this.facilityName = facilityName,
        super(key: key);

  @override
  _FacilityCreateScreenState createState() => _FacilityCreateScreenState();
}

class _FacilityCreateScreenState extends State<FacilityCreateScreen2> {
  TextEditingController facilityAddrController = TextEditingController();
  AddFacilityBloc _addFacilityBloc;
  double height;
  double width;
  String address;
  bool enable=true;

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
              color: Color(0xFF2F80ED),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(width*0.05, 0.0, width*0.05, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: height * 0.06,
                ),
                SizedBox(
                  height: height*0.117,
                  width: width*0.778,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: widget.facilityName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F80ED))),
                      TextSpan(
                        text: ' 의\n위치를 설정해 주세요' + EmojiParser().emojify('📍'),
                        style:
                            TextStyle(fontWeight: FontWeight.bold),
                      )
                    ])),
                  ),
                ),
                SizedBox(
                  height: height*0.047,
                  width: width*0.667,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '시설 근방의 날씨 정보를 제공하기 위해 사용되며\n다른 사람에게 공개되지 않습니다.',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.0781,
                ),
                SizedBox(
                  width: width*0.131,
                  height: height*0.0233,
                  child: FittedBox(
                    child: Text(
                      '시설 주소',
                      style: TextStyle(fontSize: 14.4, color: Colors.grey[400]),
                    ),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: facilityAddrController..text = state.facilityAddr,
                  maxLines: null,
                  enabled: enable,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: '주소 검색하기',
                  ),
                  onTap: () async {
                    KopoModel model = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Kopo(),
                      ),
                    );
                    if (model != null) {
                      address = '${model.address} ${model.buildingName}${model.apartment == 'Y' ? '아파트' : ''}';
                      print(model);
                      try{
                        var addresses = await Geocoder.local.findAddressesFromQuery('${model.roadAddressEnglish}');
                        var first = addresses.first;
                        print("${first.featureName} : ${first.coordinates.toString()}");
                        _addFacilityBloc
                            .add(FacilityAddrChanged(facilityAddr: address, Addr: first.coordinates));
                      }catch(e){
                        print(e);
                      }
                    }
                  },
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationButton(
              title: '다음',
              onPressed: state.isAddrValid
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider<AddFacilityBloc>.value(
                                    value: _addFacilityBloc,
                                    child: FacilityCreateScreen3(),
                                  )));
                    }
                  : null));
    });
  }
}
