import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/blocs/blocs.dart';

class ButtonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: FlatButton(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 35.0,
                ),
                onPressed: (){
//                  return BlocProvider<AddFacilityBloc>(
//                    create: (BuildContext context) =>
//                      AddFacilityBloc(),
//                    child:,
//                  );
                  Navigator.push(context, MaterialPageRoute (builder: (context) => BlocProvider<AddFacilityBloc>(
                    create: (BuildContext context)=>AddFacilityBloc(),
                    child: FacilityCreateScreen(),
                  )));
                },
              ),
              Text(
                '농사 프로젝트 추가하기',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
