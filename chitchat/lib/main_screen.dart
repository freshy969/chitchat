import "package:flutter/material.dart";
import "package:chitchat/chat/chat.dart";
import "package:chitchat/common/style.dart" as Style;
import "package:chitchat/common/common.dart";

class MainScreen extends StatefulWidget<_MainScreenState> {
	
	@override
	_MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{

	final List<String> _tabNames = ["Newsfeed", "Messages", "Notifications", "Me"];
	String _currentName;
	TabController _controller;

	@override
	void initState() {
		super.initState();
		_controller = new TabController(length: 4, vsync: this);
		_currentName = _tabNames[0];
		_controller.addListener(_handleChangeTab);
	}

	@override
	dispose() {
		_controller.removeListener(_handleChangeTab);
		super.dispose();
	}

	void _handleChangeTab() {
		setState(() {
			_currentName = _tabNames[_controller.index];
		});
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			backgroundColor: Colors.white,
			body: new NestedScrollView(
				headerSliverBuilder: (BuildContext context, bool isScrolled) {
					return [
						new SliverAppBar(
							elevation: 0.7,
							floating: true,
							pinned: true,
							forceElevated: true,
							snap: true,
							backgroundColor: Colors.white,
							title: new Padding(
								padding: const EdgeInsets.only(left: 5.0),
								child: new Text(
									_currentName,
									style: new TextStyle(
										fontWeight: FontWeight.w600,
									)
								)
							),
							bottom: new TabBar(
								controller: _controller,
								labelColor: Style.primary,
								unselectedLabelColor: Style.textLight,
								indicatorColor: Style.primary,
								indicatorPadding: const EdgeInsets.symmetric(horizontal: 10.0),
								tabs: [
									new Tab(
										icon: new Image.asset(
											_controller.index == 0 ? home_solid : home_outline,
											color: _controller.index == 0 ? Style.primary : Style.textLight,
											width: 35.0,
										)
									),
									new Tab(
										icon: new Image.asset(
											_controller.index == 1 ? chat_solid : chat_outline,
											color: _controller.index == 1 ? Style.primary : Style.textLight,
											width: 35.0,
										)
									),
									new Tab(
										icon: new Image.asset(
											_controller.index == 2 ? bell_solid : bell_outline,
											color: _controller.index == 2 ? Style.primary : Style.textLight,
											width: 35.0,
										)
									),
									new Tab(
										icon: new Image.asset(
											_controller.index == 3 ? person_solid : person_outline,
											color: _controller.index == 3 ? Style.primary : Style.textLight,
											width: 35.0,
										)
									),
								]
							)
						),
					];
				},
				body: new TabBarView(
					controller: _controller,
					children: [
						new Text("Newsfeed"),
						new ChatScreen(),
						new Text("Notifactions"),
						new Text("Me"),
					]
				)
			),
		);
	}
}
