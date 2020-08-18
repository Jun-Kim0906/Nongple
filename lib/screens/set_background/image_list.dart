import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/style.dart';

class BgImageList extends StatefulWidget {
  @override
  _BgImageListState createState() => _BgImageListState();
}

class _BgImageListState extends State<BgImageList> {
  double height;
  double width;
  BgBloc _bgBloc;
  bool test;

  @override
  void initState() {
    super.initState();
    _bgBloc = BlocProvider.of<BgBloc>(context);
    test = false;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocBuilder<BgBloc, BgState>(
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
            ) : IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFF2F80ED),
              ),
              onPressed: () {
                _bgBloc.add(RevertToInitialState());
                Navigator.pop(context);
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
                        _bgBloc.add(EditImageList());
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
              ? GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  children: List.generate(state.bg.length, (index) {
                    return InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        _bgBloc.add(PressCheckBox(bgid: state.bg[index].bgid));
                      },
                      child: Card(
                        margin: EdgeInsets.all(0.0),
                        child: (state.editState)
                            ? Stack(
                                children: [
                                  Image(
                                    image: CachedNetworkImageProvider(
                                        state.bg[index].bgUrl),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    height: height * 0.05,
                                      child: FittedBox(
                                          child: roundCheckBox(state)
                                      )
                                  ),
                                ],
                              )
                            : Image(
                                image: CachedNetworkImageProvider(
                                    state.bg[index].bgUrl),
                              ),
                      ),
                    );
                  }),
                )
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
    );
  }

  Widget roundCheckBox(BgState state) {
    return Center(
      child: InkWell(
        onTap: () {
          _bgBloc.add(PressCheckBox());
        },
        child: Container(
          decoration: state.checkBoxState
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
            child: state.checkBoxState
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
