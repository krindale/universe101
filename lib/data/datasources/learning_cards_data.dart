import '../../domain/entities/learning_card.dart';

/// Sample learning cards data for the universe education app
class LearningCardsData {
  static List<LearningCard> getSampleCards() {
    return [
      // Planet Cards
      LearningCard(
        id: 'card_001',
        title: '태양계에서 가장 큰 행성',
        content: '목성은 태양계에서 가장 큰 행성입니다. 지구의 1,300배나 되는 부피를 가지고 있으며, 태양계 모든 행성의 질량을 합친 것보다 2.5배나 무겁습니다.',
        category: 'planet',
        relatedId: 'jupiter',
        difficulty: LearningCardDifficulty.easy,
        tags: ['목성', '태양계', '크기'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_002',
        title: '화성의 붉은 색깔',
        content: '화성이 붉게 보이는 이유는 표면에 산화철(녹)이 많이 있기 때문입니다. 지구의 사막과 비슷한 풍경을 가지고 있으며, 물이 있었던 흔적이 발견되었습니다.',
        category: 'planet',
        relatedId: 'mars',
        difficulty: LearningCardDifficulty.easy,
        tags: ['화성', '색깔', '산화철'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_003',
        title: '토성의 고리',
        content: '토성의 고리는 얼음과 암석 조각들로 이루어져 있습니다. 고리의 폭은 수십만 킬로미터에 달하지만, 두께는 불과 10미터 정도로 매우 얇습니다.',
        category: 'planet',
        relatedId: 'saturn',
        difficulty: LearningCardDifficulty.medium,
        tags: ['토성', '고리', '얼음'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_004',
        title: '금성의 극한 환경',
        content: '금성은 태양계에서 가장 뜨거운 행성입니다. 표면 온도가 약 462°C로, 수성보다도 뜨겁습니다. 두꺼운 이산화탄소 대기가 온실 효과를 일으키기 때문입니다.',
        category: 'planet',
        relatedId: 'venus',
        difficulty: LearningCardDifficulty.medium,
        tags: ['금성', '온도', '온실효과'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_005',
        title: '수성의 극단적인 온도차',
        content: '수성은 태양에 가장 가까운 행성으로, 낮에는 430°C까지 올라가지만 밤에는 -180°C까지 떨어집니다. 대기가 거의 없어 열을 저장할 수 없기 때문입니다.',
        category: 'planet',
        relatedId: 'mercury',
        difficulty: LearningCardDifficulty.hard,
        tags: ['수성', '온도', '대기'],
        createdAt: DateTime.now(),
      ),

      // Phenomena Cards
      LearningCard(
        id: 'card_006',
        title: '일식의 원리',
        content: '일식은 달이 태양과 지구 사이를 지나가면서 태양을 가리는 현상입니다. 달과 태양이 하늘에서 비슷한 크기로 보이기 때문에 가능한 놀라운 우연입니다.',
        category: 'phenomenon',
        relatedId: 'eclipse_solar',
        difficulty: LearningCardDifficulty.easy,
        tags: ['일식', '달', '태양'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_007',
        title: '오로라의 빛',
        content: '오로라는 태양에서 날아온 입자들이 지구 자기장을 따라 극지방 대기와 충돌하면서 생기는 빛입니다. 주로 초록색이지만, 붉은색이나 보라색도 나타날 수 있습니다.',
        category: 'phenomenon',
        relatedId: 'aurora',
        difficulty: LearningCardDifficulty.medium,
        tags: ['오로라', '자기장', '극지방'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_008',
        title: '초신성 폭발',
        content: '초신성은 별의 생애 마지막에 일어나는 거대한 폭발입니다. 단 몇 주 동안 은하 전체만큼 밝게 빛나며, 우리 몸을 이루는 무거운 원소들을 우주로 뿌립니다.',
        category: 'phenomenon',
        relatedId: 'supernova',
        difficulty: LearningCardDifficulty.hard,
        tags: ['초신성', '폭발', '원소'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_009',
        title: '블랙홀의 탈출 속도',
        content: '블랙홀의 중력이 너무 강해서 빛조차 탈출할 수 없습니다. 사건의 지평선이라고 불리는 경계를 넘으면, 어떤 것도 다시 나올 수 없습니다.',
        category: 'phenomenon',
        relatedId: 'black_hole',
        difficulty: LearningCardDifficulty.hard,
        tags: ['블랙홀', '중력', '빛'],
        createdAt: DateTime.now(),
      ),

      // Exploration Cards
      LearningCard(
        id: 'card_010',
        title: '아폴로 11호의 달 착륙',
        content: '1969년 7월 20일, 인류 최초로 달에 발을 디딘 날입니다. 닐 암스트롱이 "한 사람에게는 작은 발걸음이지만, 인류에게는 거대한 도약입니다"라고 말했습니다.',
        category: 'exploration',
        relatedId: 'apollo_11',
        difficulty: LearningCardDifficulty.easy,
        tags: ['아폴로', '달', '착륙'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_011',
        title: '보이저의 끝없는 여행',
        content: '보이저 1호는 1977년에 발사되어 현재까지도 우주를 여행하고 있습니다. 2012년에 태양계를 벗어나 성간 공간에 진입한 최초의 인공물체가 되었습니다.',
        category: 'exploration',
        relatedId: 'voyager',
        difficulty: LearningCardDifficulty.medium,
        tags: ['보이저', '성간여행', '태양계'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_012',
        title: '제임스 웹 우주망원경',
        content: '2021년 발사된 제임스 웹은 허블 망원경보다 100배 강력합니다. 적외선으로 관측하여 우주 초기의 별과 은하들을 볼 수 있으며, 놀라운 우주 사진들을 보내고 있습니다.',
        category: 'exploration',
        relatedId: 'jwst',
        difficulty: LearningCardDifficulty.medium,
        tags: ['제임스웹', '망원경', '적외선'],
        createdAt: DateTime.now(),
      ),

      // General Space Facts
      LearningCard(
        id: 'card_013',
        title: '우주의 나이',
        content: '우주는 약 138억 년 전 빅뱅으로 시작되었습니다. 빅뱅 이론은 우주가 작은 점에서 시작해 팽창하고 있다는 것을 설명합니다.',
        category: 'general',
        difficulty: LearningCardDifficulty.medium,
        tags: ['빅뱅', '우주', '나이'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_014',
        title: '1광년의 거리',
        content: '1광년은 빛이 1년 동안 가는 거리로, 약 9조 4,600억 킬로미터입니다. 가장 가까운 별인 프록시마 센타우리도 4.24광년이나 떨어져 있습니다.',
        category: 'general',
        difficulty: LearningCardDifficulty.hard,
        tags: ['광년', '거리', '빛'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_015',
        title: '은하수의 별',
        content: '우리 은하인 은하수에는 약 2,000억 개에서 4,000억 개의 별이 있습니다. 그리고 우주에는 은하수 같은 은하가 수천억 개나 더 있습니다.',
        category: 'general',
        difficulty: LearningCardDifficulty.easy,
        tags: ['은하수', '별', '은하'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_016',
        title: '중력렌즈 효과',
        content: '아인슈타인이 예측한 것처럼, 거대한 질량이 있으면 빛이 휘어집니다. 은하나 블랙홀이 렌즈처럼 작용해 뒤에 있는 별이나 은하의 상을 왜곡시킵니다.',
        category: 'general',
        difficulty: LearningCardDifficulty.hard,
        tags: ['중력렌즈', '아인슈타인', '빛'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_017',
        title: '우주 정거장의 하루',
        content: '국제우주정거장(ISS)은 지구 주위를 약 90분마다 한 바퀴 돕니다. 즉, 우주비행사들은 하루에 16번의 일출과 일몰을 경험합니다.',
        category: 'exploration',
        difficulty: LearningCardDifficulty.easy,
        tags: ['ISS', '우주정거장', '일출'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_018',
        title: '목성의 대적점',
        content: '목성의 대적점은 지구보다 큰 거대한 폭풍입니다. 최소 350년 동안 계속되고 있으며, 시속 432km의 바람이 불고 있습니다.',
        category: 'planet',
        relatedId: 'jupiter',
        difficulty: LearningCardDifficulty.medium,
        tags: ['목성', '대적점', '폭풍'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_019',
        title: '달의 뒷면',
        content: '달은 항상 같은 면만 지구를 향하고 있습니다. 이를 조석 고정이라고 하며, 1959년 소련의 루나 3호가 처음으로 달의 뒷면을 촬영했습니다.',
        category: 'general',
        difficulty: LearningCardDifficulty.medium,
        tags: ['달', '조석고정', '뒷면'],
        createdAt: DateTime.now(),
      ),
      LearningCard(
        id: 'card_020',
        title: '우주의 소리',
        content: '우주는 진공이라 소리가 전달되지 않습니다. 하지만 전파를 소리로 변환하면 행성과 별들의 "음악"을 들을 수 있습니다. NASA는 이런 우주의 소리들을 공개하고 있습니다.',
        category: 'general',
        difficulty: LearningCardDifficulty.easy,
        tags: ['우주', '소리', '진공'],
        createdAt: DateTime.now(),
      ),
    ];
  }

  /// Get cards by category
  static List<LearningCard> getCardsByCategory(String category) {
    return getSampleCards()
        .where((card) => card.category == category)
        .toList();
  }

  /// Get cards by difficulty
  static List<LearningCard> getCardsByDifficulty(
      LearningCardDifficulty difficulty) {
    return getSampleCards()
        .where((card) => card.difficulty == difficulty)
        .toList();
  }

  /// Get cards by tag
  static List<LearningCard> getCardsByTag(String tag) {
    return getSampleCards()
        .where((card) => card.tags.contains(tag))
        .toList();
  }
}
