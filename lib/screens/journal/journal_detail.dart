import 'package:flutter/material.dart';

class JournalDetail extends StatefulWidget {
  @override
  _JournalDetailState createState() => _JournalDetailState();
}

class _JournalDetailState extends State<JournalDetail> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('test1'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text('test1'),),
      ),
    );
  }
}
