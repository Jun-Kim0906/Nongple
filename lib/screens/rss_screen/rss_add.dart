import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/widgets/widgets.dart';

class RssAdd extends StatefulWidget {
  @override
  _RssAddState createState() => _RssAddState();
}

class _RssAddState extends State<RssAdd> {
  RssMainBloc _rssMainBloc;
  TextEditingController _search = TextEditingController();
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _rssMainBloc = BlocProvider.of<RssMainBloc>(context);
    _rssMainBloc.add(MoveToAddPage());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocBuilder<RssMainBloc, RssMainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: bodyColor,
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFF979797),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            backgroundColor: appBarColor,
            title: Text(
                'RSS 기관 등록하기',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(width*0.05, height*0.03, width*0.05, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                  width: width,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '원하시는 지역 및 기관을 검색하세요',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height*0.04,),
                TextField(
                  autofocus: true,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2F80ED))
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF2F80ED),
                    ),
                    hintText: '입력하세요',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  controller: _search,
                  onChanged: (value) {
                    _rssMainBloc.add(SearchOnChanged(search: value));
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.suggestion.length,
                    itemBuilder: (context, index) {
                      return expansionList(state.suggestion[index], state);
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationButton(
              title: '완료',
              onPressed: (){
                Navigator.pop(context);
                _rssMainBloc.add(CompleteButtonPressed());
              }),
        );
      }
    );
  }

  Widget expansionList(Rss rss, RssMainState state) {
    return ExpansionTile(
      tilePadding: EdgeInsets.all(0.0),
      title: Text(rss.name, style: TextStyle(fontWeight: FontWeight.bold),),
      children: <Widget>[
        Container(
          height: (48 * rss.option.length).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rss.option.length,
            itemBuilder: (context, index) {
              bool abc = state.selectedList.contains(SearchRss(
                name: rss.name,
                option: rss.option[index],
                url: rss.url[index],
              ));
              return Column(
                children: <Widget>[
              Divider(
              height: 0,
                color: Color.fromRGBO(242, 242, 242, 1),
              ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: abc,
                          onChanged: (value) {
                            _rssMainBloc.add(SelectedRssChanged(
                              isChecked: value,
                                name: rss.name,
                                option: rss.option[index],
                                url: rss.url[index]));
                          }),
                      InkWell(
                        child: Container(
                          child: Text(
                            rss.option[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          height: 48,
                          width: width*0.7,
                          alignment: Alignment.centerLeft,
                        ),
                        onTap: () {
                          _rssMainBloc.add(SelectedRssChanged(
                            isChecked: !abc,
                              name: rss.name,
                              option: rss.option[index],
                              url: rss.url[index]));
                        },
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
