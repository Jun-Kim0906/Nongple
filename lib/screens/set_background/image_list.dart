import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/style.dart';

import 'image_detail.dart';

class BgImageList extends StatefulWidget {
  @override
  _BgImageListState createState() => _BgImageListState();
}

class _BgImageListState extends State<BgImageList> {
  HomeBloc _homeBloc;
  double height;
  double width;
  BgBloc _bgBloc;
  bool test;
  bool isChanged= false;

  @override
  void initState() {
    super.initState();
    _bgBloc = BlocProvider.of<BgBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    test = false;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _bgBloc,
      listener: (context, state){
        if(state.isCurrBgDeleted){
          isChanged = true;
          print('ㄴㅇㄹㄴㅇㄹ');
        }
      },
      child: BlocBuilder<BgBloc, BgState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bodyColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              leading: state.editState
                  ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Color(0xFF2F80ED),
                ),
                onPressed: () {
                  _bgBloc.add(RevertToInitialState());
                },
              )
                  : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF2F80ED),
                ),
                onPressed: () {
                  Navigator.pop(context, isChanged);
                  _bgBloc.add(RevertToInitialState());
                },
              ),
              title: SizedBox(
                height: height * 0.04,
                child: AutoSizeText(
                  '사진목록',
                  style: settingAppBarStyle,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              actions: [
                (state.editState)
                    ? FlatButton(
                  child: Text(
                    '삭제',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F80ED),
                    ),
                  ),
                  onPressed: () {
                    _bgBloc.add(DeleteSelectedImage());
//                    if(state.isCurrBgDeleted){
//                      isChanged = true;
//                    }
                  },
                )
                    : FlatButton(
                  child: Text(
                    '수정',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F80ED),
                    ),
                  ),
                  onPressed: () {
                    _bgBloc.add(EditImageList());
                  },
                ),
              ],
            ),
            body: (state.bg.isNotEmpty)
                ? GridView.builder(
                itemCount: state.bg.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return (state.editState)
                      ? InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      _bgBloc.add(PressCheckBox(
                          bgid: state.bg[index].bgid, bgUrl: state.bg[index].bgUrl));
                    },
                    child: Card(
                        margin: EdgeInsets.all(0.0),
                        child: Stack(
                          children: [
                            Image(
                              image: CachedNetworkImageProvider(
                                  state.bg[index].bgUrl),
                            ),
                            Container(
                                padding: EdgeInsets.all(4.0),
                                height: height * 0.05,
                                child: FittedBox(
                                    child: roundCheckBox(
                                        state: state, index: index))),
                          ],
                        )),
                  )
                      : InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageDetailScreen(
                                bgUrl: state.bg[index].bgUrl, bgid: state.bg[index].bgid,)));
                    },
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      child: Hero(
                        tag: state.bg[index].bgid,
                        child: Image(
                          image: CachedNetworkImageProvider(
                              state.bg[index].bgUrl),
                        ),
                      ),
                    ),
                  );
                })
                : Container(
              child: Center(
                child: SizedBox(
                  height: height * 0.2,
                  child: FittedBox(
                    child: Icon(
                      Icons.collections,
                      size: 300,
                      color: Color(0xFF2F80ED), // blue
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget roundCheckBox({BgState state, int index}) {
    return Center(
      child: InkWell(
        onTap: () {
          _bgBloc.add(PressCheckBox(bgid: state.bg[index].bgid, bgUrl: state.bg[index].bgUrl));
        },
        child: Container(
          decoration: (state.checkedListWithBgid.contains(state.bg[index].bgid) == true)
              ? BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                )
              : BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                  color: Color(0x50000000),
                ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: (state.checkedListWithBgid.contains(state.bg[index].bgid) == true)
                ? Icon(
                    Icons.check,
                    size: 30.0,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.check_box_outline_blank,
                    size: 30.0,
                    color: Color(0x00000000),
                  ),
          ),
        ),
      ),
    );
  }
}
