import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:sticker_view/stickerview.dart';

import '../view/Home.dart';

class HomeViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  double fontSize = 100.0;
  Color selectedColor = Colors.blue;

  List<Text> textList = [
    Text("Prathamesh"),
    Text("suraj")
  ];

  List<Sticker> generateStickers() {
    return textList.map((textWidget) {
      return Sticker(
        child: Text(
         textWidget.data!,
         style: TextStyle(
           fontSize: fontSize,
           color: selectedColor
         ),
        ),
        id:textWidget.data!.toString(),
      );
    }).toList();
  }

  void ondelete(Widget text) {

    textList.remove(text);
    notifyListeners();
  }

  void state() {
    notifyListeners();
  }

  void onlayeredTap(Sticker sticker) {
    var listLength = textList.length;
    var ind = textList.indexOf(sticker.child as Text);

    textList.remove(sticker.child);

    if (ind == listLength - 1) {
      textList.insert(0, sticker.child as Text);
    } else {
      textList.insert(listLength - 1, sticker.child as Text);
    }
    selectedAssetId = sticker.id;
    notifyListeners();
  }

  void decreaseFontSize() {
    fontSize = (fontSize - 2.0).clamp(10.0, 100.0);
    notifyListeners();
  }
  void increaseFontSize() {
    fontSize = (fontSize + 2.0).clamp(10.0, 100.0);
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  List<Widget> buildColorOptions() {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
    ];

    return colors.map((color) {
      return GestureDetector(
        onTap: () {
          setSelectedColor(color);
        },
        child: Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: selectedColor == color
              ? Icon(
            Icons.check,
            color: Colors.white,
          )
              : Container(),
        ),
      );
    }).toList();
  }

  void showPopup(BuildContext context, String key) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: key=='update'?Text("Edit"): Text('Add Text'),
          content: Container(
            height: 78.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
               if(key=='update'){
                 textList[0] = Text(titleController.text);
                   Navigator.of(context).pop();
                   titleController.clear();
               }
               else{
                 textList.add(Text(titleController.text));
                Navigator.of(context).pop();
                titleController.clear();
               }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
