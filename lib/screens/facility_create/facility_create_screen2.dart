import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:nongple/blocs/add_facilitiy_bloc/bloc.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:nongple/testPage.dart';
import 'package:nongple/widgets/widgets.dart';

class FacilityCreateScreen2 extends StatefulWidget {
  String facilityName;
  FacilityCreateScreen2({Key key, String facilityName})
      : this.facilityName=facilityName,
        super(key: key);

  @override
  _FacilityCreateScreenState createState() => _FacilityCreateScreenState();
}

class _FacilityCreateScreenState extends State<FacilityCreateScreen2> {
  TextEditingController facilityAddrController = TextEditingController();
  AddFacilityBloc _addFacilityBloc;
  double height;
  String address;


  @override
  void initState() {
    super.initState();
    _addFacilityBloc = BlocProvider.of<AddFacilityBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocListener(
      bloc: _addFacilityBloc,
      listener: (BuildContext context, AddFacilityState state) {
        if (state.secondPageButtonPressed == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                  BlocProvider<AddFacilityBloc>.value(
                    value: _addFacilityBloc,
                    child: TestPage(),
                  )));
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            color: Colors.blue[600],
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
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
                height: height *0.06,
              ),
            Text.rich(TextSpan(
              children: <TextSpan>[
                TextSpan(text: widget.facilityName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33.6,color: Color(0xFF2F80ED))),
                TextSpan(text: ' 의\n위치를 설정해 주세요' + EmojiParser().emojify('📍'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33.6),)
                ]
            )),
              Text(
                '시설 근방의 날씨 정보를 제공하기 위해 사용되며\n다른 사람에게 공개되지 않습니다.',
                style: TextStyle(fontSize: 14.4, color: Colors.grey[400]),
              ),
              SizedBox(
                height: height *0.06,
              ),
              Text(
                '시설 주소',
                style: TextStyle(fontSize: 14.4, color: Colors.grey[400]),
              ),
              TextFormField(
                style: TextStyle(fontWeight: FontWeight.bold),
                controller: facilityAddrController..text = address,
                maxLines: null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: address ?? '주소 검색하기',
                ),
                onTap: ()async{
                  KopoModel model = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Kopo(),
                    ),
                  );
                  setState(() {
                    address = '${model.address} ${model.buildingName}${model.apartment == 'Y' ? '아파트' : ''} ${model.zonecode} ';
                  });
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<AddFacilityBloc, AddFacilityState>(
            builder: (context, state) {
              return BottomNavigationButton(
                  title: '다음',
                  onPressed: state.isAddrValid
                      ? () {
                    _addFacilityBloc.add(SecondPageButtonPressed(facilityAddr: facilityAddrController.text));
                  }
                      : null
              );
            }
        ),
      ),
    );
  }
}
