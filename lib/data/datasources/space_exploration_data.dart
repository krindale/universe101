import '../../domain/entities/space_exploration.dart';

/// Comprehensive space exploration mission data
/// Includes major missions with historical context and achievements
class SpaceExplorationData {
  /// Get all space exploration missions
  static List<SpaceExploration> getAllExplorations() {
    return [
      _sputnik1,
      _apollo11,
      _voyager1,
      _voyager2,
      _hubbleSpaceTelescope,
      _internationalSpaceStation,
      _curiosity,
      _newHorizons,
      _perseverance,
      _jamesWebbSpaceTelescope,
      _artemisI,
    ];
  }

  // Sputnik 1 - First artificial satellite
  static final SpaceExploration _sputnik1 = SpaceExploration(
    id: 'sputnik-1',
    name: '스푸트니크 1호 (Sputnik 1)',
    description: '인류 최초의 인공위성으로 우주 시대의 시작을 알렸습니다.',
    type: ExplorationType.satellite,
    spacecraftName: 'Sputnik 1',
    agency: 'Soviet Space Program',
    launchDate: DateTime(1957, 10, 4),
    endDate: DateTime(1958, 1, 4),
    destination: '지구 저궤도',
    achievements: [
      '인류 최초의 인공위성',
      '우주 시대의 시작',
      '21일 동안 신호 송신 성공',
      '미국과 소련의 우주 경쟁 촉발',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/sputnik-replica.jpg',
    crewMembers: [],
    status: ExplorationStatus.completed,
    historicalSignificance: '''
**우주 시대의 시작**
1957년 10월 4일, 소련은 세계 최초의 인공위성 스푸트니크 1호를 발사했습니다. 이 58cm 크기의 금속 구체는 "삐-삐-삐" 신호를 송신하며 지구를 돌았고, 이 신호는 전 세계에서 수신되었습니다.

**스푸트니크 쇼크**
미국은 소련이 우주에서 먼저 성공한 것에 큰 충격을 받았습니다. 이것이 "스푸트니크 쇼크"라고 불리며, 미국은 NASA를 설립하고 우주 프로그램에 막대한 투자를 시작했습니다.

**우주 경쟁의 서막**
스푸트니크 1호는 미소 우주 경쟁의 시작점이 되었습니다. 이후 인류는 달 착륙, 우주 정거장, 화성 탐사 등으로 우주 개척의 범위를 넓혀갔습니다.
''',
  );

  // Apollo 11 - First Moon Landing
  static final SpaceExploration _apollo11 = SpaceExploration(
    id: 'apollo-11',
    name: '아폴로 11호 (Apollo 11)',
    description: '인류 최초로 달 표면에 착륙한 역사적인 미션입니다.',
    type: ExplorationType.mannedMission,
    spacecraftName: 'Apollo 11',
    agency: 'NASA',
    launchDate: DateTime(1969, 7, 16),
    endDate: DateTime(1969, 7, 24),
    destination: '달 (Moon)',
    achievements: [
      '인류 최초 달 착륙 (1969년 7월 20일)',
      '닐 암스트롱의 역사적 첫 발자국',
      '21.5kg의 월석 샘플 수집',
      '2시간 31분 동안 달 표면 탐사',
      '케네디 대통령의 약속 이행',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/apollo-11-aldrin.jpg',
    crewMembers: [
      '닐 암스트롱 (Neil Armstrong) - 선장',
      '버즈 올드린 (Buzz Aldrin) - 달 착륙선 조종사',
      '마이클 콜린스 (Michael Collins) - 사령선 조종사',
    ],
    status: ExplorationStatus.completed,
    historicalSignificance: '''
**인류 최초의 달 착륙**
1969년 7월 20일, 닐 암스트롱은 달 표면에 첫 발을 내디디며 "이것은 한 사람에게는 작은 발걸음이지만, 인류에게는 위대한 도약이다"라는 역사적인 말을 남겼습니다.

**케네디의 비전 실현**
존 F. 케네디 대통령은 1961년 "이 십년이 끝나기 전에 인간을 달에 착륙시키고 안전하게 지구로 귀환시키겠다"고 선언했습니다. 아폴로 11호는 그의 비전을 실현한 것이었습니다.

**전 세계가 지켜본 순간**
약 6억 명의 사람들이 TV로 달 착륙을 생중계로 시청했습니다. 이는 인류 역사상 가장 많은 사람들이 동시에 지켜본 사건 중 하나였습니다.

**과학적 성과**
아폴로 11호는 21.5kg의 월석을 가져왔고, 이를 통해 달의 나이가 약 45억 년이며 지구와 유사한 기원을 가졌다는 것을 밝혀냈습니다.

**인류의 가능성**
아폴로 11호는 인류가 협력하고 헌신하면 불가능해 보이는 목표도 달성할 수 있다는 것을 보여주었습니다. 이는 우주 탐사의 새로운 시대를 열었습니다.
''',
  );

  // Voyager 1 - Farthest Human-Made Object
  static final SpaceExploration _voyager1 = SpaceExploration(
    id: 'voyager-1',
    name: '보이저 1호 (Voyager 1)',
    description: '태양계를 벗어나 성간 우주로 진입한 최초의 인공 물체입니다.',
    type: ExplorationType.probe,
    spacecraftName: 'Voyager 1',
    agency: 'NASA',
    launchDate: DateTime(1977, 9, 5),
    destination: '태양계 외곽 및 성간 우주',
    achievements: [
      '목성과 토성의 상세한 이미지 촬영',
      '2012년 8월 25일 성간 우주 진입',
      '지구에서 가장 먼 인공 물체 (240억 km 이상)',
      '골든 레코드로 인류 문명 소개',
      '45년 이상 작동 중 (2025년 현재)',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/voyager-golden-record.jpg',
    crewMembers: [],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**그랜드 투어**
보이저 1호와 2호는 176년마다 한 번씩 일어나는 행성 정렬을 이용하여 목성, 토성, 천왕성, 해왕성을 차례로 방문하는 "그랜드 투어"를 계획했습니다.

**창백한 푸른 점**
1990년, 보이저 1호는 60억 km 떨어진 곳에서 지구를 촬영했습니다. 칼 세이건은 이 사진을 "창백한 푸른 점(Pale Blue Dot)"이라고 명명하며, 인류의 겸손과 우주에서의 우리 위치에 대한 성찰을 촉구했습니다.

**골든 레코드**
보이저 1호에는 지구의 소리, 음악, 이미지를 담은 금도금 레코드가 실려 있습니다. 외계 생명체가 발견할 경우를 대비한 인류의 메시지입니다.

**성간 우주 진입**
2012년 8월 25일, 보이저 1호는 태양권계면(heliopause)을 넘어 성간 우주에 진입한 최초의 인공 물체가 되었습니다. 이는 인류가 태양계를 벗어난 역사적인 순간이었습니다.

**불멸의 여행자**
보이저 1호는 2025년경까지 신호를 보낼 것으로 예상됩니다. 그 이후에도 영원히 은하를 떠돌며 인류의 존재를 증명할 것입니다.
''',
  );

  // Voyager 2 - Grand Tour
  static final SpaceExploration _voyager2 = SpaceExploration(
    id: 'voyager-2',
    name: '보이저 2호 (Voyager 2)',
    description: '천왕성과 해왕성을 방문한 유일한 탐사선입니다.',
    type: ExplorationType.probe,
    spacecraftName: 'Voyager 2',
    agency: 'NASA',
    launchDate: DateTime(1977, 8, 20),
    destination: '목성, 토성, 천왕성, 해왕성, 성간 우주',
    achievements: [
      '유일하게 4개의 거대 행성 모두 방문',
      '천왕성과 해왕성 최초 근접 촬영',
      '2018년 11월 5일 성간 우주 진입',
      '16개의 새로운 위성 발견',
      '행성 자기장과 대기 연구',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/voyager-2-neptune.jpg',
    crewMembers: [],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**그랜드 투어 완수**
보이저 2호는 목성(1979), 토성(1981), 천왕성(1986), 해왕성(1989)을 모두 방문한 유일한 탐사선입니다. 이 "그랜드 투어"는 태양계 외곽 행성들에 대한 우리의 이해를 혁명적으로 바꾸었습니다.

**천왕성의 비밀**
1986년, 보이저 2호는 천왕성에 도착하여 10개의 새로운 위성과 2개의 새로운 고리를 발견했습니다. 또한 천왕성이 옆으로 누워서 공전한다는 독특한 특징을 확인했습니다.

**해왕성의 대흑점**
1989년, 보이저 2호는 해왕성의 "대흑점"이라는 거대한 폭풍을 발견했습니다. 또한 해왕성의 위성 트리톤이 태양계에서 가장 추운 천체 중 하나(-235°C)임을 밝혀냈습니다.

**쌍둥이 탐사선**
보이저 1호와 2호는 쌍둥이 탐사선으로, 서로 다른 경로를 통해 태양계를 탐사했습니다. 둘 다 현재까지 작동하고 있으며, 인류의 우주 탐사 역사에서 가장 성공적인 미션 중 하나입니다.
''',
  );

  // Hubble Space Telescope - Eyes of Humanity
  static final SpaceExploration _hubbleSpaceTelescope = SpaceExploration(
    id: 'hubble-space-telescope',
    name: '허블 우주 망원경 (Hubble Space Telescope)',
    description: '우주의 비밀을 밝혀낸 인류의 눈입니다.',
    type: ExplorationType.telescope,
    spacecraftName: 'Hubble Space Telescope',
    agency: 'NASA / ESA',
    launchDate: DateTime(1990, 4, 24),
    destination: '지구 저궤도 (547km)',
    achievements: [
      '우주의 나이 측정 (약 138억 년)',
      '100만 개 이상의 천체 관측',
      '딥 필드 이미지로 초기 우주 관측',
      '외계 행성 대기 분석',
      '암흑 에너지 존재 증거 제공',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/hubble-deep-field.jpg',
    crewMembers: [],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**시작의 어려움**
1990년 발사 직후, 허블의 주경에 결함이 발견되어 이미지가 흐릿하게 나왔습니다. 1993년 우주왕복선 미션을 통해 수리가 이루어졌고, 이후 놀라운 성과를 내기 시작했습니다.

**딥 필드 이미지**
1995년, 허블은 하늘의 작은 영역을 10일 동안 촬영하여 "딥 필드" 이미지를 만들었습니다. 이 이미지는 3,000개 이상의 은하를 보여주며, 그 중 일부는 120억 년 전의 모습이었습니다.

**우주의 가속 팽창**
허블의 관측을 통해 천문학자들은 우주가 가속 팽창하고 있다는 것을 발견했습니다. 이는 "암흑 에너지"의 존재를 시사하며, 2011년 노벨 물리학상을 받았습니다.

**대중의 사랑**
허블이 촬영한 아름다운 우주 이미지들은 과학 커뮤니티를 넘어 대중의 상상력을 사로잡았습니다. "창조의 기둥", "나선 은하" 등의 이미지는 현대 아이콘이 되었습니다.

**35년의 여정**
2025년 현재까지 작동 중인 허블은 지속적으로 우주의 비밀을 밝혀내고 있습니다. 제임스 웹 우주 망원경이 발사되었지만, 허블은 여전히 중요한 관측을 수행하고 있습니다.
''',
  );

  // International Space Station - Laboratory in Space
  static final SpaceExploration _internationalSpaceStation = SpaceExploration(
    id: 'international-space-station',
    name: '국제 우주 정거장 (ISS)',
    description: '인류가 우주에 건설한 가장 큰 구조물이자 국제 협력의 상징입니다.',
    type: ExplorationType.spaceStation,
    spacecraftName: 'International Space Station',
    agency: 'NASA, Roscosmos, ESA, JAXA, CSA',
    launchDate: DateTime(1998, 11, 20), // First module (Zarya)
    destination: '지구 저궤도 (408km)',
    achievements: [
      '20년 이상 지속적인 인간 거주',
      '3,000개 이상의 과학 실험 수행',
      '273명의 우주인 방문 (2025년 기준)',
      '15개국 협력 프로젝트',
      '장기 우주 체류 기록 (437일)',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/iss-exterior.jpg',
    crewMembers: ['상주 우주인 6-7명 (교대 근무)'],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**국제 협력의 결정체**
ISS는 미국, 러시아, 유럽, 일본, 캐나다 등 15개국이 참여한 인류 역사상 가장 큰 국제 협력 프로젝트입니다. 냉전 이후 미국과 러시아가 협력한 상징적 프로젝트이기도 합니다.

**우주 실험실**
ISS는 미세중력 환경에서 생물학, 물리학, 화학, 의학 등 다양한 분야의 실험을 수행합니다. 이를 통해 암 치료, 재료 과학, 식물 재배 등에서 중요한 발견이 이루어졌습니다.

**인간의 우주 적응 연구**
장기 우주 체류가 인체에 미치는 영향을 연구하여, 미래 화성 탐사를 위한 중요한 데이터를 수집하고 있습니다. 스콧 켈리는 340일, 발레리 폴라코프는 437일을 우주에서 보냈습니다.

**지구 관측 플랫폼**
ISS는 지구를 하루에 16번 공전하며 기후 변화, 자연재해, 해양 상태 등을 관측합니다. 우주인들이 촬영한 지구 사진은 환경 보호의 중요성을 일깨웁니다.

**미래를 향한 디딤돌**
ISS는 2030년까지 운영될 예정이며, 달 탐사와 화성 탐사를 위한 기술과 경험을 축적하고 있습니다. 민간 우주 정거장 시대를 여는 교두보 역할도 하고 있습니다.
''',
  );

  // Curiosity Rover - Mars Science Laboratory
  static final SpaceExploration _curiosity = SpaceExploration(
    id: 'curiosity',
    name: '큐리오시티 (Curiosity)',
    description: '화성의 과거 생명체 가능성을 탐사하는 SUV 크기의 로버입니다.',
    type: ExplorationType.rover,
    spacecraftName: 'Curiosity Rover',
    agency: 'NASA',
    launchDate: DateTime(2011, 11, 26),
    endDate: null,
    destination: '화성 게일 크레이터',
    achievements: [
      '화성에 과거 물이 흘렀다는 증거 발견',
      '유기 분자 검출 (생명체 가능성)',
      '메탄 가스 변동 측정',
      '28km 이상 주행 (2025년 기준)',
      '900,000장 이상의 이미지 전송',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/curiosity-selfie.jpg',
    crewMembers: [],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**스카이 크레인 착륙**
2012년 8월 6일, 큐리오시티는 "스카이 크레인"이라는 혁신적인 착륙 방식을 사용하여 화성에 안착했습니다. 이는 "7분간의 공포"로 불린 위험천만한 착륙 과정이었습니다.

**물의 증거**
큐리오시티는 게일 크레이터가 과거에 호수였다는 증거를 발견했습니다. 둥근 자갈과 퇴적층은 물이 흘렀던 흔적이며, 이는 화성에 생명체가 존재했을 가능성을 높입니다.

**유기 분자 발견**
2018년, 큐리오시티는 30억 년 된 화성 암석에서 유기 분자를 검출했습니다. 이는 생명체의 직접적인 증거는 아니지만, 생명체가 존재했을 환경이었다는 강력한 증거입니다.

**메탄의 수수께끼**
큐리오시티는 화성 대기에서 메탄 농도가 계절에 따라 변동한다는 것을 발견했습니다. 지구에서 메탄은 주로 생물학적 과정에서 생성되기 때문에, 이는 흥미로운 발견입니다.

**10년 이상의 임무**
원래 2년 임무였던 큐리오시티는 2025년 현재까지 13년 넘게 작동하고 있습니다. 화성 날씨의 가혹함에도 불구하고 여전히 과학 데이터를 보내고 있습니다.
''',
  );

  // New Horizons - Pluto Flyby
  static final SpaceExploration _newHorizons = SpaceExploration(
    id: 'new-horizons',
    name: '뉴 호라이즌스 (New Horizons)',
    description: '명왕성과 카이퍼 벨트를 탐사한 최초의 탐사선입니다.',
    type: ExplorationType.probe,
    spacecraftName: 'New Horizons',
    agency: 'NASA',
    launchDate: DateTime(2006, 1, 19),
    destination: '명왕성, 카이퍼 벨트',
    achievements: [
      '명왕성 최초 근접 관측 (2015년 7월 14일)',
      '명왕성의 하트 모양 지형 발견',
      '카이퍼 벨트 천체 Arrokoth 탐사',
      '명왕성의 5개 위성 상세 촬영',
      '명왕성 대기 분석',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/pluto-heart.jpg',
    crewMembers: [],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**9년 반의 여행**
뉴 호라이즌스는 2006년 발사되어 9년 반 동안 48억 km를 여행하여 2015년 7월 14일 명왕성에 도착했습니다. 이는 지구에서 가장 먼 태양계 천체에 대한 최초의 탐사였습니다.

**명왕성의 재발견**
명왕성은 2006년 행성에서 왜소행성으로 재분류되었지만, 뉴 호라이즌스의 관측은 명왕성이 놀라울 정도로 복잡하고 활동적인 세계임을 보여주었습니다.

**하트 모양의 스푸트니크 평원**
명왕성 표면의 거대한 하트 모양 지형(스푸트니크 평야)은 질소 얼음으로 덮여 있으며, 지질학적으로 활동적입니다. 이는 명왕성 내부에 열원이 있음을 시사합니다.

**대기의 놀라움**
명왕성은 질소, 메탄, 일산화탄소로 이루어진 얇은 대기를 가지고 있으며, 이 대기는 태양으로부터 멀어질수록 얼어붙어 지표로 떨어집니다.

**카이퍼 벨트로**
명왕성 탐사 후, 뉴 호라이즌스는 계속 나아가 2019년 1월 1일 카이퍼 벨트 천체 Arrokoth를 근접 관측했습니다. 이는 인류가 방문한 가장 먼 천체입니다.
''',
  );

  // Perseverance Rover - Search for Ancient Life
  static final SpaceExploration _perseverance = SpaceExploration(
    id: 'perseverance',
    name: '퍼서비어런스 (Perseverance)',
    description: '화성의 고대 생명체 흔적을 찾고 샘플을 수집하는 최첨단 로버입니다.',
    type: ExplorationType.rover,
    spacecraftName: 'Perseverance Rover',
    agency: 'NASA',
    launchDate: DateTime(2020, 7, 30),
    endDate: null,
    destination: '화성 제제로 크레이터',
    achievements: [
      '화성에서 최초로 산소 생성 (MOXIE 실험)',
      '화성 최초의 헬리콥터 인제뉴어티 탑재',
      '생명체 가능성이 있는 암석 샘플 수집',
      '고해상도 파노라마 이미지',
      '화성 표면 음향 녹음',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/perseverance-ingenuity.jpg',
    crewMembers: [],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**샘플 수집 미션**
퍼서비어런스의 주요 임무는 화성 암석과 토양 샘플을 수집하여 미래에 지구로 가져오는 것입니다. 이 "화성 샘플 반환" 프로그램은 2030년대에 실현될 예정입니다.

**산소 생성 성공**
2021년 4월, MOXIE 실험 장치는 화성 대기의 이산화탄소를 산소로 전환하는 데 성공했습니다. 이는 미래 화성 유인 탐사에 중요한 기술입니다.

**인제뉴어티 헬리콥터**
2021년 4월 19일, 인제뉴어티는 다른 행성에서 최초로 동력 비행에 성공했습니다. 원래 5회 비행 예정이었지만, 2025년 현재까지 70회 이상 비행하며 퍼서비어런스의 정찰기 역할을 하고 있습니다.

**제제로 크레이터**
제제로 크레이터는 35억 년 전에 호수와 강 삼각주가 있었던 곳으로 추정됩니다. 이곳은 고대 미생물의 화석을 찾기에 이상적인 장소입니다.

**화성의 소리**
퍼서비어런스는 화성 표면의 소리를 녹음한 최초의 탐사선입니다. 바람 소리, 로버의 이동 소리, 레이저 발사 소리 등을 녹음하여 지구로 전송했습니다.
''',
  );

  // James Webb Space Telescope - Eyes of the Future
  static final SpaceExploration _jamesWebbSpaceTelescope = SpaceExploration(
    id: 'james-webb-space-telescope',
    name: '제임스 웹 우주 망원경 (JWST)',
    description: '우주의 첫 별과 은하를 관측하는 차세대 우주 망원경입니다.',
    type: ExplorationType.telescope,
    spacecraftName: 'James Webb Space Telescope',
    agency: 'NASA / ESA / CSA',
    launchDate: DateTime(2021, 12, 25),
    destination: '라그랑주 L2 지점 (지구에서 150만 km)',
    achievements: [
      '우주 최초의 은하들 관측 (빅뱅 후 2억 년)',
      '외계 행성 대기 성분 분석',
      '놀라운 깊은 우주 이미지',
      '별 형성 지역 상세 관측',
      '암흑 물질 분포 연구',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/jwst-first-deep-field.jpg',
    crewMembers: [],
    status: ExplorationStatus.active,
    historicalSignificance: '''
**100억 달러의 도전**
제임스 웹 우주 망원경은 개발에 25년, 비용 100억 달러가 투입된 인류 역사상 가장 복잡한 과학 기기입니다. 허블의 후계자로 설계되었으며, 적외선 영역에서 100배 더 민감합니다.

**완벽한 전개**
2022년 1월, JWST는 344개의 단일 장애 지점을 가진 복잡한 전개 과정을 완벽하게 완료했습니다. 테니스 코트 크기의 차양막과 18개의 금도금 거울이 우주에서 펼쳐졌습니다.

**우주의 여명기**
2022년 7월, JWST는 첫 번째 딥 필드 이미지를 공개했습니다. 이 이미지는 빅뱅 후 2억 년 된 초기 은하들을 보여주며, 우주의 역사를 재구성하는 데 도움을 주고 있습니다.

**외계 행성 연구**
JWST는 외계 행성의 대기에서 물, 이산화탄소, 메탄 등을 검출하고 있습니다. 이는 생명체가 존재할 수 있는 행성을 찾는 데 중요한 단서를 제공합니다.

**새로운 발견들**
JWST는 예상보다 거대한 초기 은하들, 복잡한 유기 분자, 놀라운 별 형성 지역 등을 발견하며 우주론의 일부 가정을 재고하게 만들고 있습니다.
''',
  );

  // Artemis I - Return to the Moon
  static final SpaceExploration _artemisI = SpaceExploration(
    id: 'artemis-1',
    name: '아르테미스 1호 (Artemis I)',
    description: '달 재탐사와 화성 탐사를 위한 첫 단계 무인 시험 비행입니다.',
    type: ExplorationType.mannedMission,
    spacecraftName: 'Orion Spacecraft',
    agency: 'NASA',
    launchDate: DateTime(2022, 11, 16),
    endDate: DateTime(2022, 12, 11),
    destination: '달 궤도',
    achievements: [
      '오리온 우주선 무인 시험 성공',
      '달 너머 40,000km까지 비행 (인간용 우주선 최장거리)',
      'SLS 로켓 첫 발사 성공',
      '달 착륙을 위한 기술 검증',
      '2025년 유인 비행 준비',
    ],
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/artemis-earth-moon.jpg',
    crewMembers: [],
    status: ExplorationStatus.completed,
    historicalSignificance: '''
**아폴로를 넘어서**
아르테미스 프로그램은 1972년 이후 처음으로 인간을 달에 보내는 NASA의 야심찬 계획입니다. 이번에는 여성 우주인과 유색인종 우주인을 포함하여 더 포용적인 탐사를 목표로 합니다.

**SLS: 가장 강력한 로켓**
우주 발사 시스템(SLS)은 현재 운용 중인 가장 강력한 로켓으로, 아폴로 시대의 새턴 V 로켓보다 15% 더 많은 추력을 제공합니다.

**26일간의 여정**
아르테미스 1호는 26일 동안 약 210만 km를 여행하며 오리온 우주선의 모든 시스템을 테스트했습니다. 달 궤도를 두 번 공전하며 다양한 과학 실험을 수행했습니다.

**달 기지 건설 계획**
아르테미스 프로그램의 궁극적인 목표는 달 남극에 영구 기지를 건설하는 것입니다. 이 기지는 화성 탐사를 위한 훈련장이자 과학 연구의 전진 기지가 될 것입니다.

**국제 협력**
유럽, 일본, 캐나다 등이 아르테미스 프로그램에 참여하고 있으며, 달 게이트웨이 우주 정거장 건설에 협력하고 있습니다. 2025년 아르테미스 2호 유인 비행, 2026년 아르테미스 3호 달 착륙이 예정되어 있습니다.
''',
  );
}
