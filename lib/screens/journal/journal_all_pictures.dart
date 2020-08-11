import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/journal/journal.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/loading/loading.dart';

class JournalAllPictures extends StatefulWidget {

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
    _journalMainBloc.add(PicturePageLoad());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocListener(
      bloc: _journalMainBloc,
      listener: (BuildContext context, JournalMainState state){
        if(state.isLoading==true&&state.isPicturePageLoading==true){
          LoadingDialog.onLoading(context);
          _journalMainBloc.add(GetAllPicture());
        }else if(state.isLoading==false && state.isPicturePageLoading==true){
          LoadingDialog.dismiss(context, (){
            _journalMainBloc.add(PageLoaded());
          });
        }
      },
      child: BlocBuilder<JournalMainBloc, JournalMainState>(
        bloc: _journalMainBloc,
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
              title: SizedBox(
                height: height * 0.054,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Column(
                    children: [
                      Text(
                        '일지 전체보기',
                        style: tabAppBarTitleStyle,
                      ),
                      Text(
                        state.facility.name,
                        style: tabAppBarSubtitleStyle,
                      ),
                    ],
                  ),
                ),
              ),
              centerTitle: true,
            ),
            body: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: state.allPictureList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildPhotoList(context, index, state);
                }),
          );
        },
      ),
    );
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
                transitionDuration: Duration(seconds: 5),
                pageBuilder: (_, __, ___) => JournalPictureDetail(
                  url: state.allPictureList[index].url,
                  ismain: false,
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
          tag: '${state.allPictureList[index].url}+all',
          child:

          Image.network(
            state.allPictureList[index].url,

//            state.pictureList[index].url,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
