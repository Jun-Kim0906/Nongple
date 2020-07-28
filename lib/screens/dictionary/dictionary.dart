import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/dictionary/dictionary_detail_screen.dart';
import 'package:nongple/utils/utils.dart';

class DictionaryScreen extends StatefulWidget {
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  DictionaryBloc _dictionaryBloc;

  @override
  void initState() {
    super.initState();
    _dictionaryBloc = BlocProvider.of<DictionaryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _dictionaryBloc,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              searchBar(),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _matchedList(context, state),
//              _totalList(context, state)
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            width: 65,
            child: Text(
              '용어',
              style: TextStyle(
                  color: Color(0xFF2F80ED),
                  fontWeight: FontWeight.w600,
                  fontSize: 21),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: TextField(
                autofocus: true,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2F80ED))),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onChanged: (value){
                  _dictionaryBloc
                      .add(SearchTextChanged(searchText: value));
                },
                onSubmitted: (value){
                  _dictionaryBloc.add(TextOnSubmitted(searchText: value));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _matchedList(BuildContext context, DictionaryState state) {
    return Column(
        children: List.generate(
            state.searchedItems.length,
            (index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider<DictionaryBloc>.value(
                                    value: _dictionaryBloc
                                      ..add(SearchedItemLoad(
                                          wordNo: state.searchedItems[index]
                                              .wordNumber)),
                                    child: DictionaryDetailScreen(
                                      wordNo:
                                          state.searchedItems[index].wordNumber,
                                      wordNm:
                                          state.searchedItems[index].wordName,
                                    ),
                                  ))).then((value) => _dictionaryBloc.add(DetailContentDelete()));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${state.searchedItems[index].wordName}",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )).toList());
  }

//  Widget _matchedList(BuildContext context, DictionaryState state) {
//    return ColumnBuilder(
//        itemBuilder: (context, index) {
//          return Padding(
//            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//            child: InkWell(
//              onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (BuildContext context) =>
//                        BlocProvider<DictionaryBloc>.value(
//                          value: _dictionaryBloc,
//                          child: DictionaryDetailPage(
//                            wordNo:
//                            state.matchDictionaryList[index].wordNumber,
//                            name: state.matchDictionaryList[index].wordName,
//                          ),
//                        )));
//              },
//              child: Container(
//                alignment: Alignment.centerLeft,
//                child: Text(
//                  "${state.matchDictionaryList[index].wordName}",
//                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//                ),
//              ),
//            ),
//          );
//        },
//        itemCount: state.matchDictionaryList.length);
//  }

}
