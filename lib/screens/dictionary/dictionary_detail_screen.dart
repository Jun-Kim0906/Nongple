import 'package:flutter/material.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/widgets/widgets.dart';

class DictionaryDetailScreen extends StatefulWidget {
  final String wordNm;
  final String wordNo;

  const DictionaryDetailScreen(
      {Key key, @required this.wordNm, @required this.wordNo})
      : super(key: key);

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
    _dictionaryBloc.add(DetailLoading());
    wordNo = widget.wordNo;
    name = widget.wordNm;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _dictionaryBloc,
      listener: (BuildContext context, DictionaryState state) {
        if (state.detailLoading == true) {
          _dictionaryBloc.add(SearchedItemLoad(wordNo: widget.wordNo));
          LoadingDialog.onLoading(context);
        } else if(state.detailContent!=''){
          print('여기 몇번 실행되나');
          LoadingDialog.dismiss(context, () => null);
        }
      },
      child: BlocBuilder(
        bloc: _dictionaryBloc,
        builder: (BuildContext context, DictionaryState state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(Icons.clear),
                  color: Colors.black,
                  onPressed: () {
                    _dictionaryBloc.add(DetailContentDelete());
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
      ),
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
