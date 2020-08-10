import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/background_image_bloc/bloc.dart';
import 'package:nongple/blocs/home_bloc/home.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/screens/set_background/pick_image.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';

class FacilityListForBackground extends StatelessWidget {
  final Facility facList;

  FacilityListForBackground({
    Key key,
    this.facList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListTile(
      leading: SizedBox(
        height: height * 0.06,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Card(
            shape: CircleBorder(side: BorderSide(color: Colors.grey[200])),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: (facList.category == 1 || facList.category == 2)
                  ? Icon(CustomIcons.tractor, color: Color(0xFF2F80ED), size: 30,)
                  : (facList.category == 3)
                  ? Icon(CustomIcons.cow, color: Color(0xFF2F80ED), size: 30,)
                  : Icon(CustomIcons.plant, color: Color(0xFF2F80ED), size: 30,),
            ),
          ),
        ),
      ),
      title: SizedBox(
        height: height * 0.04,
        width: width * 0.644,
          child: AutoSizeText(
              facList.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            maxLines: 1,
          ),
      ),
//      trailing: Icon(CustomIcons.cow),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: _homeBloc,
                        ),
                        BlocProvider<BgBloc>(
                          create: (BuildContext context) =>
                              BgBloc()..add(UpdateBgUrl(null)),
                        )
                      ],
                      child: PickBackground(facList: facList),
                    )));
      },
    );
  }
}
