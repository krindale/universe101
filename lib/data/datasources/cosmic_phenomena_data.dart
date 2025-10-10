import '../../domain/entities/cosmic_phenomenon.dart';

/// Comprehensive cosmic phenomena data for educational content
/// Includes historical context, storytelling, and visual descriptions
class CosmicPhenomenaData {
  /// Get all cosmic phenomena
  static List<CosmicPhenomenon> getAllPhenomena() {
    return [
      _solarEclipse,
      _lunarEclipse,
      _aurora,
      _supernova,
      _blackHole,
      _gravitationalLensing,
      _meteorShower,
      _nebulaFormation,
      _cometOrbitalChange,
    ];
  }

  // Solar Eclipse - 일식
  static final CosmicPhenomenon _solarEclipse = CosmicPhenomenon(
    id: 'solar-eclipse',
    name: '일식 (Solar Eclipse)',
    description: '달이 태양과 지구 사이를 지나가면서 태양을 가리는 천문 현상입니다.',
    type: PhenomenonType.eclipse,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/eclipse-alignment.jpg',
    facts: [
      '개기일식은 평균 375년에 한 번씩 같은 장소에서 관측됩니다',
      '일식 동안 낮 기온이 최대 10도까지 떨어질 수 있습니다',
      '일식은 최대 7분 31초까지 지속될 수 있습니다',
      '일식을 맨눈으로 직접 보면 시력을 영구적으로 손상시킬 수 있습니다',
    ],
    historicalContext: '''
**고대의 공포와 예언**
고대 사람들은 일식을 신의 노여움이나 불길한 징조로 여겼습니다. 중국에서는 하늘의 용이 태양을 삼킨다고 믿었고, 북유럽 신화에서는 늑대 스콜이 태양을 잡아먹는다고 생각했습니다.

**1919년 아인슈타인의 상대성 이론 증명**
1919년 5월 29일, 개기일식 관측을 통해 아인슈타인의 일반 상대성 이론이 증명되었습니다. 영국의 천문학자 아서 에딩턴은 일식 동안 태양 근처의 별빛이 휘어지는 것을 관측하여 시공간이 질량에 의해 휘어진다는 것을 확인했습니다.

**현대의 과학적 연구**
현대에는 일식이 태양의 코로나를 연구하는 귀중한 기회입니다. 코로나는 태양의 외부 대기층으로, 평소에는 태양의 밝은 빛 때문에 관측이 어렵지만 일식 동안에는 명확하게 볼 수 있습니다.
''',
    location: '전 세계 다양한 지역 (일식 경로에 따라)',
    rarity: 7,
    relatedBodies: ['sun', 'earth', 'moon'],
  );

  // Lunar Eclipse - 월식
  static final CosmicPhenomenon _lunarEclipse = CosmicPhenomenon(
    id: 'lunar-eclipse',
    name: '월식 (Lunar Eclipse)',
    description: '지구가 태양과 달 사이를 지나가면서 지구의 그림자가 달을 가리는 현상입니다.',
    type: PhenomenonType.eclipse,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/lunar-eclipse.jpg',
    facts: [
      '개기월식 동안 달이 붉게 보이는 이유는 지구 대기를 통과한 붉은 빛이 달을 비추기 때문입니다',
      '연간 최대 3번의 월식이 발생할 수 있습니다',
      '월식은 일식보다 자주 발생하고 더 오래 지속됩니다',
      '월식은 맨눈으로 안전하게 관측할 수 있습니다',
    ],
    historicalContext: '''
**블러드 문의 신비**
고대부터 붉은 달은 "블러드 문"이라 불리며 전쟁, 기근, 역병의 전조로 여겨졌습니다. 마야 문명에서는 월식을 재규어가 달을 공격하는 것으로 해석했습니다.

**콜럼버스와 월식**
1504년, 자메이카에 좌초된 크리스토퍼 콜럼버스는 월식을 예측하여 원주민들에게 식량을 제공받았습니다. 그는 천문표를 이용해 월식을 정확히 예측하고, 신이 자신에게 달을 붉게 물들이는 힘을 주었다고 주장했습니다.

**현대 천문학의 도구**
월식은 달의 대기(극히 희박하지만)와 지구 대기의 특성을 연구하는 데 활용됩니다. 또한 달의 온도 변화를 측정하여 달 표면의 열적 특성을 이해하는 데 도움을 줍니다.
''',
    location: '지구의 밤 시간대 전 지역',
    rarity: 5,
    relatedBodies: ['sun', 'earth', 'moon'],
  );

  // Aurora - 오로라
  static final CosmicPhenomenon _aurora = CosmicPhenomenon(
    id: 'aurora',
    name: '오로라 (Aurora)',
    description: '태양풍이 지구 자기장과 상호작용하여 대기 상층부에서 발생하는 아름다운 빛의 현상입니다.',
    type: PhenomenonType.atmospheric,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/aurora-borealis.jpg',
    facts: [
      '오로라는 북극에서는 오로라 보레알리스, 남극에서는 오로라 오스트랄리스라고 불립니다',
      '오로라의 색은 대기 중 어떤 기체와 충돌하느냐에 따라 달라집니다 (산소-녹색/붉은색, 질소-파란색/보라색)',
      '오로라는 초당 수백만 와트의 전력을 생성합니다',
      '목성, 토성, 천왕성, 해왕성에서도 오로라가 관측됩니다',
    ],
    historicalContext: '''
**신화와 전설**
북유럽 신화에서는 오로라를 발키리(전사 여신들)가 전장으로 향하는 길이라고 믿었습니다. 이누이트 족은 오로라를 죽은 자의 영혼이 하늘에서 춤추는 것으로 여겼습니다.

**갈릴레오의 명명**
1619년, 갈릴레오 갈릴레이가 로마 신화의 새벽의 여신 아우로라의 이름을 따서 "오로라"라고 명명했습니다.

**현대 과학의 이해**
1896년, 노르웨이의 물리학자 크리스티안 비르켈란트는 오로라가 태양에서 방출된 하전 입자가 지구 자기장에 갇혀 발생한다는 이론을 제시했습니다. 이는 1960년대 인공위성 관측으로 확인되었습니다.

**우주 날씨의 지표**
오로라는 태양 활동의 강도를 보여주는 지표입니다. 강력한 태양 폭풍은 저위도 지역에서도 오로라를 볼 수 있게 하지만, 동시에 위성 통신과 전력망에 영향을 줄 수 있습니다.
''',
    location: '극지방 (북위 60-75도, 남위 60-75도)',
    rarity: 3,
    relatedBodies: ['sun', 'earth'],
  );

  // Supernova - 초신성
  static final CosmicPhenomenon _supernova = CosmicPhenomenon(
    id: 'supernova',
    name: '초신성 (Supernova)',
    description: '거대한 별이 생명을 다하고 폭발하면서 엄청난 에너지와 빛을 방출하는 현상입니다.',
    type: PhenomenonType.stellar,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/crab-nebula.jpg',
    facts: [
      '초신성 폭발은 태양이 평생 방출하는 에너지보다 많은 에너지를 순간적으로 방출합니다',
      '우리 은하에서 약 50년에 한 번씩 초신성이 발생합니다',
      '초신성은 철보다 무거운 원소들을 만들어내는 우주의 연금술사입니다',
      '초신성 잔해는 중성자별이나 블랙홀을 남깁니다',
    ],
    historicalContext: '''
**1054년 게 성운**
중국 천문학자들은 1054년 7월 4일, 황소자리에서 낮에도 보이는 밝은 별을 발견했습니다. 이것이 바로 초신성 SN 1054였으며, 그 잔해가 현재 게 성운(Crab Nebula)입니다. 23일 동안 낮에도 보였고, 2년 동안 밤하늘에서 관측되었습니다.

**1987A 초신성**
1987년 2월 23일, 대마젤란은하에서 발견된 SN 1987A는 400년 만에 맨눈으로 볼 수 있는 가장 가까운 초신성이었습니다. 이 초신성은 중성미자를 처음으로 직접 검출한 천문 사건이기도 합니다.

**우주의 거리 측정자**
Ia형 초신성은 항상 같은 밝기로 폭발하는 "표준 촛불"로, 천문학자들이 우주의 거리를 측정하는 데 사용합니다. 1990년대 Ia형 초신성 관측을 통해 우주가 가속 팽창하고 있다는 사실이 밝혀져 노벨상을 받았습니다.

**생명의 근원**
초신성이 만든 무거운 원소들(탄소, 질소, 산소, 철 등)은 우주 공간으로 퍼져 나가 새로운 별과 행성, 그리고 생명체를 구성하는 재료가 됩니다. 우리 몸을 이루는 원자들도 수십억 년 전 초신성에서 만들어졌습니다.
''',
    location: '우주 전체 (은하 내)',
    rarity: 9,
    relatedBodies: [],
  );

  // Black Hole - 블랙홀
  static final CosmicPhenomenon _blackHole = CosmicPhenomenon(
    id: 'black-hole',
    name: '블랙홀 (Black Hole)',
    description: '중력이 너무 강해서 빛조차 빠져나올 수 없는 시공간의 영역입니다.',
    type: PhenomenonType.gravitational,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/black-hole-m87.jpg',
    facts: [
      '블랙홀의 중심에는 특이점(singularity)이라는 무한대의 밀도를 가진 점이 있습니다',
      '블랙홀 주변의 시간은 멀리서 볼 때 극도로 느리게 흐릅니다',
      '우리 은하 중심에는 태양 질량의 400만 배에 달하는 초거대 블랙홀이 있습니다',
      '블랙홀끼리 충돌하면 중력파가 발생하여 시공간이 흔들립니다',
    ],
    historicalContext: '''
**아인슈타인의 예측**
1915년, 알베르트 아인슈타인의 일반 상대성 이론은 블랙홀의 존재를 수학적으로 예측했습니다. 그러나 아인슈타인 자신도 블랙홀이 실제로 존재한다고는 믿지 않았습니다.

**슈바르츠실트의 해**
1916년, 독일의 천문학자 칼 슈바르츠실트는 아인슈타인 방정식의 해를 찾아 블랙홀의 경계인 "사건의 지평선"을 처음 기술했습니다. 이것이 블랙홀 이론의 시작이었습니다.

**백조자리 X-1**
1964년, 백조자리에서 강한 X선을 방출하는 천체가 발견되었습니다. 이는 최초로 확인된 블랙홀 후보였으며, 1990년대에 블랙홀임이 확정되었습니다.

**최초의 블랙홀 사진**
2019년 4월 10일, 사건의 지평선 망원경(EHT) 프로젝트는 5,500만 광년 떨어진 M87 은하 중심의 초거대 블랙홀 사진을 공개했습니다. 이는 인류가 블랙홀을 직접 "본" 역사적인 순간이었습니다.

**중력파 검출**
2015년, LIGO 실험은 13억 광년 떨어진 두 블랙홀의 충돌로 발생한 중력파를 최초로 검출했습니다. 이는 아인슈타인의 마지막 미검증 예측을 100년 만에 확인한 것이며, 2017년 노벨 물리학상을 받았습니다.
''',
    location: '우주 전체 (은하 중심, 별의 잔해)',
    rarity: 8,
    relatedBodies: [],
  );

  // Gravitational Lensing - 중력 렌즈 효과
  static final CosmicPhenomenon _gravitationalLensing = CosmicPhenomenon(
    id: 'gravitational-lensing',
    name: '중력 렌즈 효과 (Gravitational Lensing)',
    description: '거대한 천체의 중력이 빛을 휘게 만들어 먼 천체가 확대되거나 여러 개로 보이는 현상입니다.',
    type: PhenomenonType.gravitational,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/einstein-ring.jpg',
    facts: [
      '아인슈타인 링은 완벽한 정렬 상태에서 나타나는 원형 이미지입니다',
      '중력 렌즈는 우주에서 가장 먼 은하를 관측하는 천연 망원경 역할을 합니다',
      '암흑 물질의 분포를 지도화하는 주요 방법입니다',
      '같은 초신성이 여러 번 보이게 만들 수 있습니다',
    ],
    historicalContext: '''
**아인슈타인의 예측**
1915년, 일반 상대성 이론은 질량이 시공간을 휘게 만들어 빛의 경로를 바꾼다고 예측했습니다. 1919년 개기일식 관측으로 이 효과가 처음 확인되었습니다.

**1979년 쌍둥이 퀘이사**
천문학자들은 하늘에서 매우 가까운 두 개의 동일한 퀘이사를 발견했습니다. 알고 보니 이것은 하나의 퀘이사가 중간의 은하에 의해 두 개로 보이는 것이었습니다. 이는 중력 렌즈의 첫 확실한 관측이었습니다.

**허블 딥 필드**
1995년, 허블 우주 망원경의 딥 필드 관측은 중력 렌즈 효과로 확대된 수많은 먼 은하들을 보여주었습니다. 이를 통해 우주 초기의 은하 형성 과정을 연구할 수 있게 되었습니다.

**암흑 물질 지도**
중력 렌즈 효과는 보이지 않는 암흑 물질의 분포를 "보는" 유일한 방법입니다. 빛의 왜곡 패턴을 분석하여 우주의 거대 구조와 암흑 물질의 분포를 지도화할 수 있습니다.
''',
    location: '우주 전체 (거대 은하단 주변)',
    rarity: 6,
    relatedBodies: [],
  );

  // Meteor Shower - 유성우
  static final CosmicPhenomenon _meteorShower = CosmicPhenomenon(
    id: 'meteor-shower',
    name: '유성우 (Meteor Shower)',
    description: '혜성이 남긴 먼지와 얼음 조각들이 지구 대기권에 진입하면서 타들어가는 현상입니다.',
    type: PhenomenonType.atmospheric,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/perseid-meteor-shower.jpg',
    facts: [
      '페르세우스 유성우는 매년 8월 중순에 시간당 최대 100개의 유성을 볼 수 있습니다',
      '유성은 초속 70km의 속도로 대기권에 진입합니다',
      '대부분의 유성은 모래알 크기의 작은 입자에서 발생합니다',
      '유성우는 특정 혜성의 궤도와 연관되어 있습니다',
    ],
    historicalContext: '''
**1833년 레오니드 유성우 폭풍**
1833년 11월 13일 밤, 북미 전역에서 시간당 수만 개의 유성이 떨어지는 경이로운 광경이 펼쳐졌습니다. 많은 사람들이 세상의 종말이라고 믿었지만, 이는 템플-터틀 혜성이 남긴 잔해가 원인이었습니다.

**혜성과의 연결 발견**
1866년, 이탈리아 천문학자 조반니 스키아파렐리는 페르세우스 유성우가 스위프트-터틀 혜성의 궤도와 일치한다는 것을 발견했습니다. 이로써 유성우가 혜성 잔해에서 비롯된다는 사실이 밝혀졌습니다.

**주요 유성우들**
- **페르세우스 유성우** (8월): 스위프트-터틀 혜성
- **제미니드 유성우** (12월): 소행성 3200 파에톤
- **쿼드란티드 유성우** (1월): 2003 EH1 소행성
- **레오니드 유성우** (11월): 템플-터틀 혜성

**소원을 비는 전통**
고대부터 유성에 소원을 비는 전통이 있습니다. 그리스에서는 유성을 신이 인간 세계를 내려다보는 순간이라고 믿었고, 이때 기도하면 신이 들어준다고 여겼습니다.
''',
    location: '지구 전역 (특정 시기)',
    rarity: 2,
    relatedBodies: ['earth'],
  );

  // Nebula Formation - 성운 형성
  static final CosmicPhenomenon _nebulaFormation = CosmicPhenomenon(
    id: 'nebula-formation',
    name: '성운 형성 (Nebula Formation)',
    description: '우주 공간의 가스와 먼지가 모여 만들어지는 아름다운 구조로, 별의 탄생지이자 무덤입니다.',
    type: PhenomenonType.stellar,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/eagle-nebula.jpg',
    facts: [
      '독수리 성운의 "창조의 기둥"은 높이가 약 5광년에 달합니다',
      '오리온 성운은 맨눈으로 볼 수 있는 가장 밝은 성운입니다',
      '성운 내부에서는 수천 개의 별이 동시에 태어날 수 있습니다',
      '행성상 성운은 태양과 같은 중소형 별의 아름다운 최후입니다',
    ],
    historicalContext: '''
**메시에 목록**
1774년, 프랑스 천문학자 샤를 메시에는 혜성을 찾다가 혜성과 혼동되는 "성운 같은" 천체들의 목록을 만들었습니다. M1(게 성운)부터 M110까지의 이 목록은 오늘날까지도 사용됩니다.

**허블의 성운 관측**
1920년대, 에드윈 허블은 안드로메다 성운(M31)이 실제로는 우리 은하 밖의 거대한 은하임을 발견했습니다. 이는 우주의 규모에 대한 인류의 이해를 혁명적으로 바꾸었습니다.

**창조의 기둥**
1995년, 허블 우주 망원경이 촬영한 독수리 성운의 "창조의 기둥" 사진은 천문학 역사상 가장 상징적인 이미지가 되었습니다. 이 기둥들은 별 탄생이 활발히 일어나는 지역으로, 새로 태어나는 별들의 복사에 의해 조각되고 있습니다.

**별의 요람과 무덤**
성운은 두 가지 방식으로 형성됩니다:
1. **방출 성운**: 뜨거운 별의 빛이 주변 가스를 이온화시켜 빛나게 만듭니다
2. **행성상 성운**: 죽어가는 별이 외층을 우주로 방출하며 만들어집니다
3. **암흑 성운**: 별빛을 차단하는 짙은 먼지 구름으로, 미래의 별들이 태어날 장소입니다
''',
    location: '우주 전체 (은하 내)',
    rarity: 4,
    relatedBodies: [],
  );

  // Comet Orbital Change - 혜성 궤도 변화
  static final CosmicPhenomenon _cometOrbitalChange = CosmicPhenomenon(
    id: 'comet-orbital-change',
    name: '혜성 궤도 변화 (Comet Orbital Change)',
    description: '혜성이 태양이나 행성의 중력 영향을 받아 궤도가 극적으로 변화하는 현상입니다.',
    type: PhenomenonType.orbital,
    imageUrl: 'https://science.nasa.gov/wp-content/uploads/2023/09/comet-shoemaker-levy-9.jpg',
    facts: [
      '슈메이커-레비 9 혜성은 목성에 포획되어 목성 주위를 공전하다 1994년 충돌했습니다',
      '혜성은 한 번 지나갈 때마다 질량의 일부를 잃어 결국 소멸합니다',
      '목성은 "우주의 진공청소기" 역할을 하여 지구로 향하는 혜성들을 끌어당깁니다',
      '핼리 혜성은 약 76년마다 지구 근처를 지나갑니다',
    ],
    historicalContext: '''
**핼리 혜성의 발견**
1705년, 에드먼드 핼리는 1531년, 1607년, 1682년에 관측된 혜성이 같은 혜성이며 76년 주기로 돌아온다는 것을 발견했습니다. 그는 1758년 재출현을 예측했고, 그의 사후인 1758년 크리스마스에 혜성이 예측대로 돌아왔습니다.

**슈메이커-레비 9의 극적인 충돌**
1994년 7월, 슈메이커-레비 9 혜성이 21개 조각으로 분열되어 목성에 연쇄 충돌했습니다. 이는 인류가 처음으로 실시간으로 관측한 천체 충돌 사건이었습니다. 충돌로 생긴 자국은 지구 크기만큼 컸으며, 몇 달 동안 관측되었습니다.

**1910년 핼리 혜성 공포**
1910년 핼리 혜성이 돌아왔을 때, 과학자들은 혜성의 꼬리에 독성 가스가 있다고 발표했습니다. 이로 인해 전 세계적으로 공포가 퍼졌고, 사람들은 "혜성 알약"을 사서 독가스를 막으려 했습니다. 물론 아무 일도 일어나지 않았습니다.

**ISON 혜성의 소멸**
2013년, "세기의 혜성"으로 기대받던 ISON 혜성은 태양에 너무 가까이 접근하여 완전히 분해되었습니다. 이는 혜성의 생명이 얼마나 위태로운지 보여주는 극적인 사례였습니다.

**오르트 구름의 수수께끼**
대부분의 장주기 혜성은 태양계 외곽의 오르트 구름에서 옵니다. 때때로 근처를 지나가는 별의 중력이 혜성을 흔들어 내부 태양계로 보내며, 이것이 우리가 보는 새로운 혜성들입니다.
''',
    location: '태양계 전역',
    rarity: 5,
    relatedBodies: ['sun', 'jupiter'],
  );
}
