import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/style.dart';

class ButtonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('card tapped');
            Navigator.push(context, MaterialPageRoute (builder: (context) => BlocProvider<AddFacilityBloc>(
                    create: (BuildContext context)=>AddFacilityBloc(),
                    child: FacilityCreateScreen(),
                  ))).then((value) => BlocProvider.of<HomeBloc>(context).add(ListLoading()));
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Color.fromRGBO(0, 0, 0, 0.54),
                          size: 45.0,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: AutoSizeText(
                      '농사 프로젝트 추가하기',
                      style: cardWidgetAddProjButton,
                      minFontSize: 6,
                      stepGranularity: 2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
