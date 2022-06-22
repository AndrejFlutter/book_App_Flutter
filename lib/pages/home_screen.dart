import 'package:flutter/material.dart';

import 'package:kniha_test_app/pages/navigation_home_screen.dart';
import 'package:kniha_test_app/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController? tabController;

  final PageController _pageController = PageController();

  List pages = [
    NavigationHomeScreen(),
  ];

  var currentIndex = 0;
  List<Tab> myTabs = [
    Tab(
      icon: Icon(Icons.home_outlined),
      text: "Home",
    ),
    Tab(
      icon: Icon(Icons.settings),
      text: "Profile",
    ),
  ];

  @override
  void initState() {
    tabController = TabController(
        length: myTabs.length, vsync: this, initialIndex: currentIndex);
    super.initState();
  }

  void onTap(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
    tabController!.animateTo(currentIndex);

    _pageController.jumpToPage(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 10, end: 10),
        child: Stack(
          children: [
            PositionedDirectional(
                top: 50,
                start: 5,
                end: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          padding: EdgeInsetsDirectional.all(3),
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            'assets/images/book.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Welcome in Book App",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            splashRadius: 1,
                            onPressed: () {},
                            icon: Icon(
                              Icons.ring_volume_rounded,
                              color: Colors.purple,
                            )),
                        IconButton(
                            splashRadius: 1,
                            onPressed: () {},
                            icon: Icon(Icons.favorite, color: Colors.purple))
                      ],
                    )
                  ],
                )),
            PositionedDirectional(
              top: 105,
              bottom: 5,
              start: 5,
              end: 5,
              child: PageView(
                allowImplicitScrolling: true,
                controller: _pageController,
                onPageChanged: (int index) {
                  onTap(index);
                },
                children: <Widget>[
                  NavigationHomeScreen(
                    tabController: tabController,
                    pageController: _pageController,
                  ),
                  ProfileScreen(),
                ],
              ),
            ),
            PositionedDirectional(
              bottom: 5,
              start: 5,
              end: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * .08,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 10,
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TabBar(
                    onTap: onTap,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Colors.purple,
                    ),
                    tabs: myTabs,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
