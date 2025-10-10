import '../../domain/entities/celestial_body.dart';

/// Solar system data seeding
/// Contains comprehensive information about all planets, sun, and major moons
class SolarSystemData {
  SolarSystemData._();

  /// Get all solar system planets
  static List<Planet> getAllPlanets() {
    return [
      _mercury,
      _venus,
      _earth,
      _mars,
      _jupiter,
      _saturn,
      _uranus,
      _neptune,
    ];
  }

  // ========== Sun ==========
  // Note: Sun will be added as a separate CelestialBody type

  // ========== Mercury (수성) ==========
  static final Planet _mercury = Planet(
    id: 'mercury',
    name: '수성 (Mercury)',
    description: '태양에서 가장 가까운 행성으로, 낮에는 극도로 뜨겁고 밤에는 매우 춥습니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/2_feature_1600x900_mercury.jpg',
    modelUrl: null, // TODO: Add 3D model URL
    facts: {
      '표면 온도': '낮 430°C, 밤 -180°C',
      '대기': '거의 없음 (외기권)',
      '위성 수': '0개',
      '발견': '선사시대부터 알려짐',
      '특징': '태양계에서 가장 작은 행성',
    },
    episodes: [
      '수성의 극심한 온도차: 대기가 거의 없어 열을 보존하지 못해 낮과 밤의 온도차가 600도 이상 납니다.',
      '크레이터 천국: 소행성 충돌로 인한 수많은 크레이터가 있으며, 가장 큰 크레이터는 칼로리스 분지입니다.',
      'MESSENGER 탐사선: 2011년 수성 궤도에 진입한 최초의 탐사선으로 상세한 지형도를 작성했습니다.',
    ],
    diameter: 4879,
    distanceFromSun: 0.39,
    orbitalPeriod: 88,
    rotationPeriod: 1407.6,
    mass: 0.055,
    gravity: 3.7,
    moons: [],
    hasRings: false,
    composition: '암석형 행성 (철 핵심 70%)',
    createdAt: DateTime.now(),
  );

  // ========== Venus (금성) ==========
  static final Planet _venus = Planet(
    id: 'venus',
    name: '금성 (Venus)',
    description: '지구와 크기가 비슷하지만 두꺼운 이산화탄소 대기로 인해 태양계에서 가장 뜨거운 행성입니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/3_feature_1600x900_venus.jpg',
    modelUrl: null,
    facts: {
      '표면 온도': '평균 462°C',
      '대기압': '지구의 90배',
      '대기 구성': '96% 이산화탄소',
      '특징': '역행 자전 (동쪽에서 서쪽으로)',
      '밝기': '태양과 달 다음으로 밝음',
    },
    episodes: [
      '온실효과의 극한: 두꺼운 이산화탄소 대기로 인한 극심한 온실효과로 태양계에서 가장 뜨겁습니다.',
      '역행 자전의 미스터리: 대부분의 행성과 반대 방향으로 자전하는데, 과거 대규모 충돌의 결과로 추정됩니다.',
      '금성의 화산: 1,600개 이상의 주요 화산이 있으며, 일부는 여전히 활동 중일 가능성이 있습니다.',
      '소련 베네라 탐사: 금성 표면에 착륙한 최초의 탐사선으로 혹독한 환경을 견디며 사진을 전송했습니다.',
    ],
    diameter: 12104,
    distanceFromSun: 0.72,
    orbitalPeriod: 225,
    rotationPeriod: 5832.5,
    mass: 0.815,
    gravity: 8.9,
    moons: [],
    hasRings: false,
    composition: '암석형 행성 (철-니켈 핵심)',
    createdAt: DateTime.now(),
  );

  // ========== Earth (지구) ==========
  static final Planet _earth = Planet(
    id: 'earth',
    name: '지구 (Earth)',
    description: '우리의 고향 행성으로, 태양계에서 유일하게 생명체가 존재하는 것으로 알려진 곳입니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/4_feature_1600x900_earth.jpg',
    modelUrl: null,
    facts: {
      '나이': '약 45억 4천만 년',
      '표면': '71% 바다, 29% 육지',
      '대기': '78% 질소, 21% 산소',
      '생명체': '870만 종 이상 추정',
      '자기장': '우주 방사선으로부터 보호',
    },
    episodes: [
      '푸른 행성: 우주에서 본 지구는 대양의 물 때문에 푸르게 보입니다.',
      '달의 형성: 약 45억 년 전 화성 크기의 천체가 충돌하여 달이 형성되었다는 가설이 있습니다.',
      '판구조론: 지구의 지각은 여러 판으로 나뉘어 움직이며, 이것이 지진과 화산 활동의 원인입니다.',
      '오존층: 성층권의 오존층이 해로운 자외선을 차단하여 생명체를 보호합니다.',
    ],
    diameter: 12742,
    distanceFromSun: 1.0,
    orbitalPeriod: 365.25,
    rotationPeriod: 24.0,
    mass: 1.0,
    gravity: 9.8,
    moons: ['달 (Moon)'],
    hasRings: false,
    composition: '암석형 행성 (철-니켈 핵심)',
    createdAt: DateTime.now(),
  );

  // ========== Mars (화성) ==========
  static final Planet _mars = Planet(
    id: 'mars',
    name: '화성 (Mars)',
    description: '붉은 행성으로 불리며, 인류의 다음 탐사 목표로 주목받고 있습니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/6_feature_1600x900_mars.jpg',
    modelUrl: null,
    facts: {
      '별명': '붉은 행성',
      '색상 이유': '철 산화물 (녹)',
      '대기': '95% 이산화탄소',
      '하루 길이': '24시간 37분',
      '계절': '지구와 유사한 사계절',
    },
    episodes: [
      '화성 운하 논란: 19세기 천문학자들이 관측한 "운하"는 실제로는 광학 착시였습니다.',
      '화성에 물의 증거: 과거에 액체 상태의 물이 흘렀던 흔적이 발견되었습니다.',
      '올림푸스 산: 태양계에서 가장 큰 화산으로 높이가 약 25km입니다.',
      '큐리오시티 로버: 2012년부터 화성을 탐사하며 과거 생명체 존재 가능성을 연구하고 있습니다.',
      '화성 이주 계획: SpaceX와 NASA는 2030년대 유인 화성 탐사를 계획 중입니다.',
    ],
    diameter: 6779,
    distanceFromSun: 1.52,
    orbitalPeriod: 687,
    rotationPeriod: 24.6,
    mass: 0.107,
    gravity: 3.7,
    moons: ['포보스 (Phobos)', '데이모스 (Deimos)'],
    hasRings: false,
    composition: '암석형 행성 (철 핵심)',
    createdAt: DateTime.now(),
  );

  // ========== Jupiter (목성) ==========
  static final Planet _jupiter = Planet(
    id: 'jupiter',
    name: '목성 (Jupiter)',
    description: '태양계에서 가장 큰 행성으로, 거대한 가스 행성입니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/7_feature_1600x900_jupiter.jpg',
    modelUrl: null,
    facts: {
      '크기': '지구의 11배',
      '질량': '태양계 행성 전체 질량의 2.5배',
      '대기': '90% 수소, 10% 헬륨',
      '자기장': '지구의 20,000배',
      '위성': '95개 (계속 발견 중)',
    },
    episodes: [
      '대적점: 지구보다 큰 거대한 폭풍으로 최소 350년 이상 지속되고 있습니다.',
      '슈메이커-레비 9 혜성 충돌: 1994년 목성과 충돌하여 관측된 최초의 행성 충돌 사건입니다.',
      '가니메데 위성: 태양계에서 가장 큰 위성으로 수성보다도 큽니다.',
      '목성의 보호자 역할: 강력한 중력으로 소행성을 끌어당겨 지구를 보호한다는 이론이 있습니다.',
      '주노 탐사선: 2016년부터 목성의 대기와 자기장을 연구하고 있습니다.',
    ],
    diameter: 139820,
    distanceFromSun: 5.20,
    orbitalPeriod: 4333,
    rotationPeriod: 9.9,
    mass: 317.8,
    gravity: 23.1,
    moons: [
      '이오 (Io)',
      '유로파 (Europa)',
      '가니메데 (Ganymede)',
      '칼리스토 (Callisto)',
      '기타 91개',
    ],
    hasRings: true,
    composition: '가스 행성 (수소, 헬륨)',
    createdAt: DateTime.now(),
  );

  // ========== Saturn (토성) ==========
  static final Planet _saturn = Planet(
    id: 'saturn',
    name: '토성 (Saturn)',
    description: '아름다운 고리로 유명한 가스 행성으로 태양계에서 두 번째로 큽니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/8_feature_1600x900_saturn.jpg',
    modelUrl: null,
    facts: {
      '밀도': '물보다 가벼움 (0.687 g/cm³)',
      '고리': '얼음과 암석 조각으로 구성',
      '고리 두께': '10m-1km (매우 얇음)',
      '위성': '146개 확인',
      '바람 속도': '시속 1,800km',
    },
    episodes: [
      '고리의 형성: 달이나 혜성이 부서져 형성되었을 것으로 추정되며, 비교적 젊다고 여겨집니다.',
      '타이탄 위성: 두꺼운 대기를 가진 유일한 위성으로, 생명체 존재 가능성이 연구되고 있습니다.',
      '엔셀라두스 물 분출: 얼음 위성 엔셀라두스에서 물 간헐천이 발견되었습니다.',
      '카시니 탐사선: 20년간 토성을 탐사하며 놀라운 발견들을 했습니다.',
      '육각형 폭풍: 북극에 육각형 모양의 거대한 폭풍이 있습니다.',
    ],
    diameter: 116460,
    distanceFromSun: 9.54,
    orbitalPeriod: 10759,
    rotationPeriod: 10.7,
    mass: 95.2,
    gravity: 9.0,
    moons: [
      '타이탄 (Titan)',
      '엔셀라두스 (Enceladus)',
      '미마스 (Mimas)',
      '테티스 (Tethys)',
      '기타 142개',
    ],
    hasRings: true,
    composition: '가스 행성 (수소, 헬륨)',
    createdAt: DateTime.now(),
  );

  // ========== Uranus (천왕성) ==========
  static final Planet _uranus = Planet(
    id: 'uranus',
    name: '천왕성 (Uranus)',
    description: '옆으로 누운 채 자전하는 독특한 얼음 행성입니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/9_feature_1600x900_uranus.jpg',
    modelUrl: null,
    facts: {
      '자전축': '98도 기울어짐',
      '색상': '메탄 대기로 인한 청록색',
      '온도': '-224°C',
      '발견': '1781년 윌리엄 허셜',
      '고리': '13개의 어두운 고리',
    },
    episodes: [
      '옆으로 누운 행성: 거대한 충돌로 인해 자전축이 98도 기울어져 있습니다.',
      '극한의 계절: 한 극이 42년간 낮, 다른 극이 42년간 밤을 경험합니다.',
      '보이저 2호: 1986년 유일하게 천왕성을 방문한 탐사선입니다.',
      '다이아몬드 비: 극한의 압력으로 인해 다이아몬드 비가 내릴 수 있다는 이론이 있습니다.',
    ],
    diameter: 50724,
    distanceFromSun: 19.19,
    orbitalPeriod: 30687,
    rotationPeriod: 17.2,
    mass: 14.5,
    gravity: 8.7,
    moons: [
      '티타니아 (Titania)',
      '오베론 (Oberon)',
      '움브리엘 (Umbriel)',
      '아리엘 (Ariel)',
      '미란다 (Miranda)',
      '기타 22개',
    ],
    hasRings: true,
    composition: '얼음 행성 (물, 메탄, 암모니아)',
    createdAt: DateTime.now(),
  );

  // ========== Neptune (해왕성) ==========
  static final Planet _neptune = Planet(
    id: 'neptune',
    name: '해왕성 (Neptune)',
    description: '태양계에서 가장 먼 행성으로, 강력한 바람이 부는 푸른 얼음 행성입니다.',
    imageUrl: 'https://solarsystem.nasa.gov/system/stellar_items/image_files/10_feature_1600x900_neptune.jpg',
    modelUrl: null,
    facts: {
      '바람 속도': '시속 2,100km (태양계 최고)',
      '발견': '1846년 수학적 예측으로 발견',
      '색상': '메탄 대기로 인한 짙은 파란색',
      '온도': '-214°C',
      '위성': '16개',
    },
    episodes: [
      '수학으로 발견된 행성: 천왕성의 궤도 이상으로 존재를 예측하고 발견한 최초의 행성입니다.',
      '대흑점: 목성의 대적점과 유사한 거대한 폭풍이 있었으나 1994년 사라졌습니다.',
      '트리톤 위성: 역행 궤도를 도는 유일한 대형 위성으로, 포획된 카이퍼 벨트 천체로 추정됩니다.',
      '보이저 2호 방문: 1989년 유일하게 해왕성을 방문한 탐사선입니다.',
      '내부 열원: 태양으로부터 받는 에너지보다 2.5배 많은 열을 방출합니다.',
    ],
    diameter: 49244,
    distanceFromSun: 30.07,
    orbitalPeriod: 60190,
    rotationPeriod: 16.1,
    mass: 17.1,
    gravity: 11.0,
    moons: [
      '트리톤 (Triton)',
      '프로테우스 (Proteus)',
      '네레이드 (Nereid)',
      '기타 13개',
    ],
    hasRings: true,
    composition: '얼음 행성 (물, 메탄, 암모니아)',
    createdAt: DateTime.now(),
  );
}
