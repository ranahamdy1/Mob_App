import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/app_cubit/cubit/appshop_cubit.dart';
import 'package:shop_app/constants/shard.dart';
import 'package:shop_app/presentation/screens/search/search_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppshopCubit cubit = AppshopCubit.get(context);
    return BlocConsumer<AppshopCubit, AppshopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                navigateTo(context,  SearchScreen());
              }, icon: const Icon(Icons.search,color: Colors.black,))
            ],
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: const Text(
              'Phone',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "Cairo",
                  fontSize: 30),
                  
            ),
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed ,
            onTap: (index) {
              cubit.changeNavbar(index);
            },
            currentIndex: cubit.currentIndex,
           
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
