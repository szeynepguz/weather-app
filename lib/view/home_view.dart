import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hava_durumu/controller/weather_controller.dart';
import 'package:hava_durumu/widgets/home_view_widgets.dart';
import 'package:hava_durumu/view/hava_durumu_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<WeatherController>(context, listen: false);
      provider.getWeather('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E1A47),
      body: SafeArea(
        child: Column(
          children: [
            const NavigationBarWidget(),
            Expanded(
              child: WeatherList(),
            ),
          ],
        ),
      ),
    );
  }
}