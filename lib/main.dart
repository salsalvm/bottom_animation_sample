import 'package:flutter/material.dart';
import 'package:smooth_carousel_slider_widget/smooth_carousel_slider_widget.dart';

void main() {
  runApp(const MyApp());
}

final List<IconData> weekDays = [
  Icons.home,
  Icons.wallet,
  Icons.heart_broken,
  Icons.badge,
  Icons.person,
];

final List<String> txt = [
'home',
'wallet',
'wishlist',
'badge',
'profile',
];

ValueNotifier<int> indexChangerNavigator = ValueNotifier<int>(3);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Example(),
    );
  }
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangerNavigator,
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Bottom navigation demo",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontStyle: FontStyle.italic),
          ),
        ),
        body: SafeArea(
          child: Builder(builder: (BuildContext context) =>  BodyPart(txt: txt[indexChangerNavigator.value],)),
        ),
        bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          child: Center(
            child: SmoothCarouselSlider(
              unSelectedWidget: (index) {
                return BottomIcon(
                  isCenter: false,
                  index: index,
                );
              },
              selectedWidget: (index) {
                return BottomIcon(
                  isCenter: true,
                  index: index,
                );
              },
              initialSelectedIndex: weekDays.length ~/ 2,
              itemCount: weekDays.length,
              itemExtent: 70,
              yOffset: 5,
              scale: 2,
              backgroundColor: Colors.white,
              onSelectedItemChanged: (index) {
                debugPrint(index.toString());
                indexChangerNavigator.value = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BodyPart extends StatelessWidget {
  const BodyPart({
    super.key, required this.txt,
  });
final String txt;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      width: double.infinity,
      child: Center(
          child: Text(
         txt,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      )),
    );
  }
}

//!=====================================================================
class BottomIcon extends StatelessWidget {
  final int index;
  final bool isCenter;

  const BottomIcon({Key? key, required this.index, required this.isCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = isCenter ? Colors.white : Colors.grey.shade200;
    var colorIcon = isCenter ? Colors.grey.shade400 : Colors.white;
    var colorCard = isCenter ? Colors.white : Colors.transparent;

    return CircleAvatar(
      backgroundColor: color,
      child: Card(
        elevation: isCenter ? 10 : 0,
        margin: EdgeInsets.zero,
        color: colorCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            weekDays[index],
            color: colorIcon,
          ),
        ),
      ),
    );
  }
}
