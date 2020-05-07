import 'package:flutter/material.dart';
import 'package:oureschoolweb/ui/components/Resources.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/components/footer.dart';
import 'package:oureschoolweb/ui/components/MenuBar/menuBar.dart';
import 'package:oureschoolweb/ui/components/spacing.dart';
import 'package:oureschoolweb/ui/components/text.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              MenuBar(
                selectedPage: SelectedPage.NONE,
              ),
              Features(
                imagePath: ImageAssets.parents_welcome,
                backgroundColor: kmainColorParents,
                text: StringConstants.parent_welcome_text,
              ),
              divider,
              Features(
                imagePath: ImageAssets.student_welcome,
                backgroundColor: kmainColorStudents,
                text: StringConstants.student_welcome_text,
                reversed: true,
              ),
              divider,
              Features(
                imagePath: ImageAssets.teacher_welcome,
                backgroundColor: kmainColorTeacher,
                text: StringConstants.teacher_welcome_text,
              ),
              divider,
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  Features(
      {Key key,
      this.backgroundColor,
      this.imagePath,
      this.text,
      this.reversed = false})
      : super(key: key);

  @required
  final String text;
  @required
  final String imagePath;
  @required
  final Color backgroundColor;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = <Widget>[
      Container(
        margin: EdgeInsets.symmetric(vertical: 24),
        child: Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.width / 5,
          fit: BoxFit.cover,
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: TextHeadline(
            text: text,
            color: textWithTransparency,
          ),
        ),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: reversed ? [elements.last, elements.first] : elements,
      ),
    );
  }
}
