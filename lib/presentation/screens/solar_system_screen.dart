import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/repositories/planet_repository.dart';
import '../../domain/entities/celestial_body.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/portfolio_card.dart';
import 'planet_detail_screen.dart';

class SolarSystemScreen extends StatelessWidget {
  const SolarSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final planetRepository = Provider.of<PlanetRepository>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Small header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Text(
                  '태양계',
                  style: AppTypography.headlineLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Horizontal scrolling cards
              Expanded(
                child: FutureBuilder<List<Planet>>(
                  future: planetRepository.getAllPlanets(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accent,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: AppTypography.bodyMedium,
                        ),
                      );
                    }

                    final planets = snapshot.data ?? [];

                    return PageView.builder(
                      controller: PageController(viewportFraction: 0.88),
                      itemCount: planets.length,
                      itemBuilder: (context, index) {
                        final planet = planets[index];
                        return Center(
                          child: _buildPlanetCard(context, planet),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanetCard(BuildContext context, Planet planet) {
    return PortfolioCard(
      tag: _getPlanetType(planet.name),
      icon: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: _getPlanetColor(planet.name),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.public,
          size: 40,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
      title: planet.name,
      subtitle: _getPlanetSubtitle(planet.name),
      description: _getPlanetDescription(planet.name),
      metrics: [
        MetricData(
          label: '지름',
          value: '${(planet.diameter / 1000).toStringAsFixed(1)}k km',
        ),
        MetricData(
          label: '거리',
          value: '${planet.distanceFromSun}AU',
        ),
        MetricData(
          label: '공전주기',
          value: _getOrbitalPeriod(planet.name),
        ),
        MetricData(
          label: '위성',
          value: _getMoons(planet.name),
        ),
        MetricData(
          label: '자전주기',
          value: _getRotationPeriod(planet.name),
        ),
        MetricData(
          label: '표면온도',
          value: _getTemperature(planet.name),
        ),
      ],
      accentColor: _getPlanetColor(planet.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanetDetailScreen(planet: planet),
          ),
        );
      },
    );
  }

  String _getPlanetType(String name) {
    switch (name) {
      case '수성 (Mercury)':
      case '금성 (Venus)':
      case '지구 (Earth)':
      case '화성 (Mars)':
        return 'Rocky Planet';
      case '목성 (Jupiter)':
      case '토성 (Saturn)':
      case '천왕성 (Uranus)':
      case '해왕성 (Neptune)':
        return 'Gas Giant';
      default:
        return 'Celestial Body';
    }
  }

  String _getPlanetSubtitle(String name) {
    switch (name) {
      case '수성 (Mercury)':
        return '태양에 가장 가까운 행성';
      case '금성 (Venus)':
        return '가장 뜨거운 행성';
      case '지구 (Earth)':
        return '우리의 고향';
      case '화성 (Mars)':
        return '붉은 행성';
      case '목성 (Jupiter)':
        return '가장 큰 행성';
      case '토성 (Saturn)':
        return '아름다운 고리';
      case '천왕성 (Uranus)':
        return '옆으로 누운 행성';
      case '해왕성 (Neptune)':
        return '가장 먼 행성';
      default:
        return '';
    }
  }

  String _getOrbitalPeriod(String name) {
    switch (name) {
      case '수성 (Mercury)':
        return '88일';
      case '금성 (Venus)':
        return '225일';
      case '지구 (Earth)':
        return '365일';
      case '화성 (Mars)':
        return '687일';
      case '목성 (Jupiter)':
        return '12년';
      case '토성 (Saturn)':
        return '29년';
      case '천왕성 (Uranus)':
        return '84년';
      case '해왕성 (Neptune)':
        return '165년';
      default:
        return 'N/A';
    }
  }

  String _getMoons(String name) {
    switch (name) {
      case '수성 (Mercury)':
      case '금성 (Venus)':
        return '0';
      case '지구 (Earth)':
        return '1';
      case '화성 (Mars)':
        return '2';
      case '목성 (Jupiter)':
        return '79';
      case '토성 (Saturn)':
        return '82';
      case '천왕성 (Uranus)':
        return '27';
      case '해왕성 (Neptune)':
        return '14';
      default:
        return '0';
    }
  }

  Color _getPlanetColor(String name) {
    switch (name) {
      case '수성 (Mercury)':
        return AppColors.mercuryGray;
      case '금성 (Venus)':
        return AppColors.venusYellow;
      case '지구 (Earth)':
        return AppColors.earthBlue;
      case '화성 (Mars)':
        return AppColors.marsRed;
      case '목성 (Jupiter)':
        return AppColors.jupiterOrange;
      case '토성 (Saturn)':
        return AppColors.saturnBeige;
      case '천왕성 (Uranus)':
        return AppColors.uranusCyan;
      case '해왕성 (Neptune)':
        return AppColors.neptuneBlue;
      default:
        return AppColors.accent;
    }
  }

  String _getPlanetDescription(String name) {
    switch (name) {
      case '수성 (Mercury)':
        return '태양계에서 가장 작고 태양에 가장 가까운 행성입니다. 대기가 거의 없어 낮과 밤의 온도 차이가 매우 큽니다.';
      case '금성 (Venus)':
        return '두꺼운 이산화탄소 대기로 인한 온실효과로 태양계에서 가장 뜨거운 행성입니다. 지구와 크기가 비슷합니다.';
      case '지구 (Earth)':
        return '생명체가 존재하는 유일한 행성으로, 액체 상태의 물과 산소가 풍부한 대기를 가지고 있습니다.';
      case '화성 (Mars)':
        return '붉은 산화철로 뒤덮여 있어 붉은 행성으로 불립니다. 과거에 물이 흘렀던 흔적이 발견되었습니다.';
      case '목성 (Jupiter)':
        return '태양계에서 가장 큰 행성으로 주로 수소와 헬륨으로 이루어져 있습니다. 대적점이라는 거대한 폭풍이 유명합니다.';
      case '토성 (Saturn)':
        return '아름다운 고리로 유명한 행성입니다. 고리는 얼음과 암석 조각들로 이루어져 있습니다.';
      case '천왕성 (Uranus)':
        return '자전축이 98도 기울어져 있어 마치 옆으로 누워서 공전하는 것처럼 보입니다. 메탄 대기로 푸른빛을 띱니다.';
      case '해왕성 (Neptune)':
        return '태양계에서 가장 먼 행성으로 강한 바람이 부는 것으로 알려져 있습니다. 아름다운 푸른색을 띱니다.';
      default:
        return '';
    }
  }

  String _getRotationPeriod(String name) {
    switch (name) {
      case '수성 (Mercury)':
        return '59일';
      case '금성 (Venus)':
        return '243일';
      case '지구 (Earth)':
        return '24시간';
      case '화성 (Mars)':
        return '24.6시간';
      case '목성 (Jupiter)':
        return '10시간';
      case '토성 (Saturn)':
        return '10.7시간';
      case '천왕성 (Uranus)':
        return '17시간';
      case '해왕성 (Neptune)':
        return '16시간';
      default:
        return 'N/A';
    }
  }

  String _getTemperature(String name) {
    switch (name) {
      case '수성 (Mercury)':
        return '430°C';
      case '금성 (Venus)':
        return '465°C';
      case '지구 (Earth)':
        return '15°C';
      case '화성 (Mars)':
        return '-63°C';
      case '목성 (Jupiter)':
        return '-108°C';
      case '토성 (Saturn)':
        return '-139°C';
      case '천왕성 (Uranus)':
        return '-197°C';
      case '해왕성 (Neptune)':
        return '-201°C';
      default:
        return 'N/A';
    }
  }
}
