import 'package:flutter/material.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';

class SelectCategoryCard extends StatelessWidget {
  int index;
  int selected;
  double width;
  VoidCallback _onPressed;

  SelectCategoryCard({
    Key key,
    @required int selected,
    @required int index,
    @required double width,
    VoidCallback onPressed,
  })  : this.selected = selected,
        this.index = index,
        this.width = width,
        this._onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: index == selected
          ? RoundedRectangleBorder(
              side: new BorderSide(color: Color(0xFF2F80ED), width: 2.0),
              borderRadius: BorderRadius.circular(20.0))
          : RoundedRectangleBorder(
              side: new BorderSide(color: Color(0xFF828282), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: _onPressed,
        highlightColor: Colors.white,
        child: Container(
          height: width,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                index == 4
                    ? CustomIcons.plant
                    : index == 3 ? CustomIcons.cow : CustomIcons.tractor,
                size: width / 3,
                color: index == selected ? Color(0xFF2F80ED) : Color(0xFF828282),
              ),
              Text(
                index == 1
                    ? '노지 재배'
                    : index == 2 ? '시설 재배' : index == 3 ? '축산' : '화훼',
                style: TextStyle(
                    color: index == selected ? Color(0xFF2F80ED) : Color(0xFF828282),
                    fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
