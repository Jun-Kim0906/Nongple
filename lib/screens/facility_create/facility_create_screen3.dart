import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:nongple/blocs/add_facilitiy_bloc/bloc.dart';
import 'package:nongple/widgets/widgets.dart';
import 'create_screen.dart';

class FacilityCreateScreen3 extends StatefulWidget {
  @override
  _FacilityCreateScreenState createState() => _FacilityCreateScreenState();
}

class _FacilityCreateScreenState extends State<FacilityCreateScreen3> {
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
                  width: width*0.533,
                  height: height*0.112,
                  child: FittedBox(
                    child: Text(
                      '영농 종류를\n선택해 주세요 ' + EmojiParser().emojify('🚜'),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33.6),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Expanded(
                  child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SelectCategoryCard(
                            width: width*0.327,
                            selected: state.facilityCategory,
                            index: index + 1,
                            onPressed: () {
                              _addFacilityBloc.add(FacilityCategoryChanged(
                                  facilityCategory: index + 1));
                            },
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationButton(
              title: '완료',
              onPressed: state.facilityCategory != 0
                  ? () {
                      _addFacilityBloc.add(FacilityUpload());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider<AddFacilityBloc>.value(
                                    value: _addFacilityBloc,
                                    child: FacilityCreateScreen4(),
                                  )));
//                      FacilityRepository().addNewFacility(Facility());
                    }
                  : null));
    });
  }
}
