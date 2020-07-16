import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:nongple/blocs/add_facilitiy_bloc/bloc.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/style.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:nongple/screens/screens.dart';

class FacilityCreateScreen extends StatefulWidget {
  @override
  _FacilityCreateScreenState createState() => _FacilityCreateScreenState();
}

class _FacilityCreateScreenState extends State<FacilityCreateScreen> {
  TextEditingController facilityNameController = TextEditingController();
  AddFacilityBloc _addFacilityBloc;

  bool get ispopulated => facilityNameController.text.isNotEmpty;

  bool isNextButtonEnabled() {
    return ispopulated;
  }

  @override
  void initState() {
    super.initState();
    _addFacilityBloc = BlocProvider.of<AddFacilityBloc>(context);
    facilityNameController.addListener(() {
      _addFacilityBloc
          .add(FacilityNameChanged(facilityname: facilityNameController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.blue[600],
          icon: Icon(Icons.close),
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
              height: MediaQuery.of(context).size.height / 11,
            ),
            Text(
              '시설 이름을 \n입력해 주세요 ' + EmojiParser().emojify('🙂'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33.6),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Text(
              '시설 이름',
              style: TextStyle(fontSize: 14.4, color: Colors.grey[400]),
            ),
            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              controller: facilityNameController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: '이름 입력하기',
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<AddFacilityBloc, AddFacilityState>(
          builder: (context, state) {
        return BottomNavigationButton(
            title: '다음',
            onPressed: state.isNameValid
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BlocProvider<AddFacilityBloc>.value(
                                  value: _addFacilityBloc,
                                  child: FacilityCreateScreen2(
                                    facilityName: state.facilityName,
                                  ),
                                )));
                  }
                : null);
      }),
    );
  }
}
