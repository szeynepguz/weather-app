import 'dart:ui';
import 'package:flutter/material.dart';
import '../model/weather_model.dart';

class WeatherDetailView extends StatefulWidget {
  final List<CurrentWeatherResponse> weatherList;
  final int initialIndex;

  const WeatherDetailView({
    super.key,
    required this.weatherList,
    this.initialIndex = 0,
  });

  @override
  State<WeatherDetailView> createState() => _WeatherDetailViewState();
}

class _WeatherDetailViewState extends State<WeatherDetailView> {
  int _currentIndex = 0;

  String _getWeatherIcon(String conditionText) {
    if (conditionText.toLowerCase().contains('rain')) {
      return 'assets/icons/rain.png';
    } else if (conditionText.toLowerCase().contains('sunny')) {
      return 'assets/icons/sunny.png';
    } else if (conditionText.toLowerCase().contains('partly cloudy')) {
      return 'assets/icons/cloudy.png';
    } else if (conditionText.toLowerCase().contains('thundery')) {
      return 'assets/icons/lightning.png';
    } else {
      return 'assets/icons/sun_cloud.png';
    }
  }

  String _formatApiDateToDay(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return "Bugün";
    }

    const days = ["Pzt", "Sal", "Çar", "Per", "Cum", "Cmt", "Paz"];
    return days[date.weekday - 1];
  }

  void _showCitySelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2E1A47),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Kayıtlı Konumlar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.weatherList.length,
                  separatorBuilder: (_, _) => Divider(
                    color: Colors.white.withValues(alpha: 0.1),
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = index == _currentIndex;

                    return ListTile(
                      title: Text(
                        widget.weatherList[index].location.name,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF9D84EA) : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        widget.weatherList[index].current.condition.text,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 13,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            _getWeatherIcon(widget.weatherList[index].current.condition.text),
                            width: 28,
                            height: 28,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${widget.weatherList[index].current.tempC.toInt()}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.weatherList.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF2E1A47),
        body: Center(child: Text("Hava durumu verisi bulunamadı.", style: TextStyle(color: Colors.white))),
      );
    }

    final weatherData = widget.weatherList[_currentIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF2E1A47),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 300,
            child: Image.asset(
              'assets/icons/House.png',
              width: MediaQuery.of(context).size.width * 0.95,
              fit: BoxFit.contain,
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    weatherData.location.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${weatherData.current.tempC.toInt()}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w200,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    weatherData.current.condition.text,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'H:${(weatherData.current.tempC + 2).toInt()}°   L:${(weatherData.current.tempC - 2).toInt()}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.35,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF48319D).withValues(alpha: 0.75),
                          const Color(0xFF1F1D47).withValues(alpha: 0.95),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: 48,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Hourly Forecast",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                Text(
                                  "Weekly Forecast",
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.white.withValues(alpha: 0.15), height: 24),
                          SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: 7,
                              separatorBuilder: (_, _) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                bool isSelected = index == 0;
                                final dateString = DateTime.now().add(Duration(days: index)).toIso8601String();
                                return Container(
                                  width: 65,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: isSelected ? const Color(0xFF48319D) : const Color(0xFF2E2B5C).withValues(alpha: 0.5),
                                    border: Border.all(
                                      color: isSelected ? Colors.white.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatApiDateToDay(dateString),
                                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                                      ),
                                      Image.asset(
                                        _getWeatherIcon(weatherData.current.condition.text),
                                        width: 32,
                                        height: 32,
                                        fit: BoxFit.contain,
                                      ),
                                      Text(
                                        '${weatherData.current.tempC.toInt()}°',
                                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomWeatherBottomBar(
              onLocationTap: () => _showCitySelectionModal(context),
              onAddTap: () {},
              onListTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class CustomWeatherBottomBar extends StatelessWidget {
  final VoidCallback? onLocationTap;
  final VoidCallback? onAddTap;
  final VoidCallback? onListTap;

  const CustomWeatherBottomBar({
    super.key,
    this.onLocationTap,
    this.onAddTap,
    this.onListTap,
  });

  @override
  Widget build(BuildContext context) {
    const double barHeight = 75.0;

    return SizedBox(
      height: barHeight + 25,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, barHeight),
            painter: BottomBarPainter(),
          ),
          SizedBox(
            height: barHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.location_on_outlined, color: Colors.white70, size: 28),
                  onPressed: onLocationTap,
                ),
                const SizedBox(width: 50),
                IconButton(
                  icon: const Icon(Icons.list, color: Colors.white70, size: 28),
                  onPressed: onListTap,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onAddTap,
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF48319D),
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF3A2D65),
          Color(0xFF21153B),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 15);

    path.lineTo(size.width * 0.32, 15);
    path.cubicTo(
      size.width * 0.40, 15,
      size.width * 0.38, 0,
      size.width * 0.50, 0,
    );
    path.cubicTo(
      size.width * 0.62, 0,
      size.width * 0.60, 15,
      size.width * 0.68, 15,
    );

    path.lineTo(size.width, 15);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    Paint borderPaint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.1),
          Colors.white.withValues(alpha: 0.35),
          Colors.white.withValues(alpha: 0.1),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}