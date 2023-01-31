import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/colors.dart';
import '../account/account_page.dart';
import '../auth/sign_in_page.dart';
import '../auth/sign_up_page.dart';
import '../cart/cart_history.dart';
import 'main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  // plug in
  late PersistentTabController _controller;



  /*List pages = [
    // all these are widgets
    MainFoodPage(),
    Container(child: Center(child: Text("Next page"))),
    CartHistory(),
    Container(child: Center(child: Text("Next next next page"))),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex=index;
    });
  }*/

  // plug in
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);

  }



  // plug in
  List<Widget> _buildScreens() {
    return [
      // SignInPage(),
      // Container(child: Center(child: Text("Next next next next page"))),
      CartHistory(),
      MainFoodPage(),

      AccountPage(),
      // Container(child: Center(child: Text("Next next next next page"))),
    ];
  }

  // plug in
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [



      // PersistentBottomNavBarItem(
      //   icon: Icon(CupertinoIcons.archivebox_fill),
      //   title: ("Archive"),
      //   activeColorPrimary: AppColors.mainColor,
      //
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        // activeColorSecondary: Colors.white,

        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),




      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.mainColor,

        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      // PersistentBottomNavBarItem(
      //   icon: Icon(CupertinoIcons.settings),
      //   title: ("Settings"),
      //   activeColorPrimary: AppColors.mainColor,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
    ];
  }

  // plug in
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }


/*
@override
  Widget build(BuildContext context) {
    return Scaffold(


      // PAGE SELECTED
      body: pages[_selectedIndex],

      // HOME BAR EDITING SECTION
      bottomNavigationBar: BottomNavigationBar(

        // supaya icon yangd dipilih keliatan sesuai warna
        selectedItemColor: AppColors.mainColor,

        // supaya icon yang tidak dipencet keliatan sesuai warna
        unselectedItemColor: Colors.amberAccent,

        // supaya text untuk icon yang dipilih supaya tidak kelihatan
        showSelectedLabels: false,

        // supaya text icon yang tidak dipilih tidak kelihatan
        showUnselectedLabels: false,

        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,

        // supaya ketika di klik, warnanya ikut berubah alias supaya keliatan icon yang di klik
        currentIndex: _selectedIndex,

        // function diatas
        onTap: onTapNav,

        // HOME BAR ICON SECTION
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "history",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "me",
          ),
        ],
      ),
    );
  }

*/



}


