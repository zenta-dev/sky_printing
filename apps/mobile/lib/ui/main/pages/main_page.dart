import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_printing/ui/main/cubit/main_cubit.dart';
import 'package:sky_printing/ui/main/widgets/bottom_nav_bar.dart';
import 'package:sky_printing_core/sky_printing_core.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MainCubit>().initMenu(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      scaffoldKey: _scaffoldKey,
      // appBar: _appBar(),
      extendBody: true,
      bottomNavigation: Container(
        margin: EdgeInsets.all(Dimens.space16),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: BottomNavBar(
            dataMenu: context.read<MainCubit>().dataMenus,
            currentIndex: (int index) {
              if (index != 2) {
                context.read<MainCubit>().updateIndex(index);
              }
            },
            child: widget.child,
          ),
        ),
      ),
      child: widget.child,
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: BlocBuilder<MainCubit, MainState>(
          builder: (_, state) {
            return Text(
              state.when(
                loading: () => "-",
                success: (data) => data?.title ?? "-",
              ),
              style: Theme.of(context).textTheme.titleLarge,
            );
          },
        ),
        actions: const [
          /// Notification on Dashboard
          ButtonNotification(),
        ],
      ),
    );
  }
}