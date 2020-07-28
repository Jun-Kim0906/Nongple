import 'package:flutter/material.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryDetailScreen extends StatefulWidget {
  final String wordNm;
  final String wordNo;

  const DictionaryDetailScreen({Key key, @required this.wordNm, @required this.wordNo})
  :super(key: key);

  @override
  _DictionaryDetailScreenState createState() => _DictionaryDetailScreenState();
}

class _DictionaryDetailScreenState extends State<DictionaryDetailScreen> {
  DictionaryBloc _dictionaryBloc;
  String wordNo;
  String name;

  @override
  void initState() {
    _dictionaryBloc = BlocProvider.of<DictionaryBloc>(context);
    super.initState();
    wordNo = widget.wordNo;
    name = widget.wordNm;
//    _dictionaryBloc.add(DetailContentsLoaded(wordNo: wordNo));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _dictionaryBloc,
      builder: (BuildContext context, DictionaryState state){
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.clear),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: Colors.white,
            title: Text(
              "농업 용어사전",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Align(
                        child: title(name),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      _content(state),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget title(String name) {
    return Container(
      child: Text(
        name,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _content(DictionaryState state) {
    return Container(
        child: Text(
          state.detailContent,
        ));
  }
}
