import 'package:flutter/material.dart';
import 'package:naemansan/tabs/tab_home.dart';
import 'package:naemansan/tabs/tab_mypage.dart';
<<<<<<< HEAD
import 'package:naemansan/tabs/map.dart';

class MapIndex extends StatefulWidget {
  const MapIndex({super.key});

  @override
  _MapIndexState createState() => _MapIndexState();
}

class _MapIndexState extends State<MapIndex> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const Home(),
    const Map(),
=======

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const Home(),
    //const Map()
>>>>>>> 0b3aef621885e355994d06106904f7569b163854
    const Mypage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
<<<<<<< HEAD
            icon: Icon(
              _currentIndex == 1
                  ? Icons.map
                  : Icons.map_outlined, //하트 아이콘 찾으면 변경 !!
            ),
=======
            icon: Icon(_currentIndex == 1
                    ? CustomIcons.heart
                    : CustomIcons.heart //하트 아이콘을 깨진 하트밖에 못 찾겠습니다 찾게 되면 수정해주세요!!
                ),
>>>>>>> 0b3aef621885e355994d06106904f7569b163854
            label: '나만의지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2 ? Icons.person : Icons.person_outlined,
            ),
            label: '마이페이지',
          ),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
<<<<<<< HEAD
=======

class CustomIcons {
  static const IconData heart = IconData(0xe800, fontFamily: 'CustomIcons');
}
>>>>>>> 0b3aef621885e355994d06106904f7569b163854
