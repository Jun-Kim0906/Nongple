import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/journal/journal.dart';
import 'package:nongple/utils/utils.dart';

class JournalAllPictures extends StatefulWidget {
  Facility facility;

  JournalAllPictures({@required this.facility});

  @override
  _JournalAllPicturesState createState() => _JournalAllPicturesState();
}

class _JournalAllPicturesState extends State<JournalAllPictures> {
  JournalMainBloc _journalMainBloc;
  double height;

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
  }

  Widget _buildPhotoList(
      BuildContext context, int index, JournalMainState state) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
//              _createRoute(state.pictureList[index].url)
              PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => JournalPictureDetail(
              url: state.pictureList[index].url,
            ),
            fullscreenDialog: true,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
              opacity: animation,
              child: child,
            ),
          ));
        },
        child: Hero(
          tag: state.pictureList[index].url,
          child:

          Image.network(
              state.pictureList[index].url,

//            state.pictureList[index].url,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

//  Route _createRoute(String url) {
//    return PageRouteBuilder(
//      pageBuilder: (context, animation, secondaryAnimation) => JournalPictureDetail(url: url,),
//      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        var begin = Offset(0.0, 1.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;
//
//        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//        return SlideTransition(
//          position: animation.drive(tween),
//          child: child,
//        );
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocBuilder<JournalMainBloc, JournalMainState>(
      builder: (context, state) {
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
                Text(
                  '일지 전체보기',
                  style: tabAppBarTitleStyle,
                ),
                Text(
                  widget.facility.name,
                  style: tabAppBarSubtitleStyle,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: state.pictureList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPhotoList(context, index, state);
              }),
        );
      },
    );
  }
}
