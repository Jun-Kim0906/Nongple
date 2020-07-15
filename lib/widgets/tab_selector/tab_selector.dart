import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nongple/models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            (tab == AppTab.weather) ? Icons.cloud_queue
                : (tab == AppTab.journal) ? Icons.date_range
                : Icons.import_contacts,
          ),
          title: Text(
            (tab == AppTab.weather) ? '날씨'
                : (tab == AppTab.journal) ? '일지'
                : '용어사전',
          ),
        );
      }).toList(),
    );
  }
}
