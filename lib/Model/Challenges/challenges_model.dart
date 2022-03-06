class ChallengesModel {
  final int index;
  final String title;
  final String description;
  final String image;
  final List<String> tileImages;
  ChallengesModel({
    required this.index,
    required this.title,
    required this.description,
    required this.image,
    required this.tileImages,
  });
}

List<ChallengesModel> listOfChallenges = [
  ChallengesModel(
      index: 0,
      title: "Easy times",
      description:
          "Score 20 points by only matching up Waffle Sam. If you match up any other character you lose 5 points.",
      image: "images/puzzle/1.png",
      tileImages: [
        "images/characters/shaky_vi.png",
        "images/characters/waffle_sam.png",
        "images/characters/cup_dize.png",
        "images/characters/waffle_sam.png",
        "images/characters/shaky_vi.png",
        "images/characters/cup_dize.png",
        "images/characters/waffle_sam.png",
        "images/characters/shaky_vi.png",
        "images/characters/cup_dize.png",
        "images/characters/cup_dize.png",
        "images/characters/shaky_vi.png",
        "images/characters/waffle_sam.png",
        "images/characters/cup_dize.png",
        "images/characters/waffle_sam.png",
        "images/characters/shaky_vi.png",
        "images/characters/shaky_vi.png",
      ]),
  ChallengesModel(
      index: 1,
      title: "Ain't it messy",
      description:
          "Score 15 points before your time runs out. For every tile that lands in its correct position you get 5secs added to your time.",
      image: "images/puzzle/2.png",
      tileImages: []),
  ChallengesModel(
      index: 2,
      title: "The impossible",
      description:
          "Score 20 points while avoiding all tiles with Shiva. You have to work smart on this one, not hard.",
      image: "images/puzzle/3.png",
      tileImages: []),
  ChallengesModel(
      index: 3,
      title: "Defiance",
      description: "Figure it out before yout time is up. You have only 30sec",
      image: "images/puzzle/4.png",
      tileImages: []),
  ChallengesModel(
      index: 4,
      title: "Rules 🤮🤮🤮",
      description:
          "Rules were meant to be broken. Instead of 4 match up only 2 tiles of a character to win 5 points. Score 30 points to win the challenge",
      image: "images/puzzle/5.png",
      tileImages: []),
  ChallengesModel(
      index: 5,
      title: "Calm before a Storm",
      description:
          "You have 2mins to win this challenge. Score 45 points. You lose 2secs every time you move tile with Puzzle Master",
      image: "images/puzzle/6.png",
      tileImages: []),
  ChallengesModel(
      index: 6,
      title: "The Storm",
      description: "You have 15 seconds score 5points.",
      image: "images/puzzle/7.png",
      tileImages: []),
];
