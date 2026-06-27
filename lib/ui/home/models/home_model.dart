import 'dart:math';

class HomeModel {
  HomeModel({required this.results, required this.info});

  factory HomeModel.fromJson(final Map<String, dynamic> json) => HomeModel(
    results:
        (json['results'] as List<dynamic>?)
            ?.map((final e) => ProfileModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    info: json['info'] as Map<String, dynamic>?,
  );

  final List<ProfileModel> results;
  final Map<String, dynamic>? info;

  Map<String, dynamic> toJson() => {
    'results': results.map((final e) => e.toJson()).toList(),
    'info': info,
  };
}

class ProfileModel {
  ProfileModel({
    this.name,
    this.age,
    this.location,
    this.distance,
    this.occupation,
    this.height,
    this.intent,
    this.matchPercent,
    this.trustPercent,
    this.replyTime,
    this.imageUrl,
    this.bio,
    this.dobDate,
    this.locationCity,
    this.locationRegion,
    this.loveLanguage,
    this.loveLanguageSubtext,
    this.religion,
    this.interestedIn,
    this.zodiac,
    this.zodiacTraits,
    this.motherTongue,
    this.communicationStyle,
    this.imageUrl2,
    this.imageUrl3,
    this.videoThumbnailUrl,
    this.prompt1Question,
    this.prompt1Answer,
    this.prompt2Question,
    this.prompt2Answer,
    this.eduCollege,
    this.eduDegree,
    this.workRole,
    this.workDetails,
    this.workStyle,
    this.ambitionLevel,
    this.bigDream,
    this.interests,
    this.lifestyleDiet,
    this.lifestyleDrinking,
    this.lifestyleSmoking,
    this.lifestyleFitness,
    this.lifestyleFitnessSub,
    this.lifestyleTravel,
    this.datingGoalTitle,
    this.datingGoalDesc,
  });

  factory ProfileModel.fromJson(final Map<String, dynamic> json) {
    // Seed Random with the unique email hash code from the API response
    final emailStr = json['email'] as String? ?? '';
    final random = Random(emailStr.hashCode);

    final nameObj = json['name'] as Map<String, dynamic>?;
    final fullName = nameObj != null
        ? '${nameObj['first'] ?? ''} ${nameObj['last'] ?? ''}'.trim()
        : null;

    final locObj = json['location'] as Map<String, dynamic>?;
    final locString = locObj != null
        ? '${locObj['city'] ?? ''}, ${locObj['state'] ?? ''}'.trim()
        : null;

    final city = locObj?['city'] as String?;
    final state = locObj?['state'] as String?;
    final country = locObj?['country'] as String?;
    final locationRegionStr = (state != null && country != null)
        ? '$state, $country'
        : (state ?? country);

    final dobObj = json['dob'] as Map<String, dynamic>?;
    final age = dobObj?['age'] as int?;
    final dobDateStr = dobObj?['date'] as String?;

    String? dobDateFormatted;
    String? zodiacSign;
    String? zodiacTraits;
    if (dobDateStr != null) {
      try {
        final dobDateTime = DateTime.parse(dobDateStr);
        dobDateFormatted = _formatDob(dobDateTime);
        zodiacSign = _getZodiac(dobDateTime);
        zodiacTraits = _getZodiacTraits(zodiacSign);
      } catch (_) {}
    }

    final picObj = json['picture'] as Map<String, dynamic>?;
    final imageUrl = picObj?['large'] as String?;

    // Generate extra image URLs matching gender from API
    final gender = json['gender'] as String?;
    final isMale = gender == 'male';
    final pType = isMale ? 'men' : 'women';

    final imgNum1 = random.nextInt(90) + 1;
    final imgNum2 = (imgNum1 + random.nextInt(88) + 1) % 90 + 1;
    final imgNum3 = (imgNum2 + random.nextInt(88) + 1) % 90 + 1;
    final imageUrl2 = 'https://randomuser.me/api/portraits/$pType/$imgNum1.jpg';
    final imageUrl3 = 'https://randomuser.me/api/portraits/$pType/$imgNum2.jpg';
    final videoThumbnail = 'https://randomuser.me/api/portraits/$pType/$imgNum3.jpg';

    // Height parsing
    final feet = 5;
    final inches = random.nextInt(4) + 4; // 5'4" to 5'7"
    final heightInCm = ((feet * 12 + inches) * 2.54).round();
    final heightStr = '$feet\'$inches" ($heightInCm cm)';

    // Mock Love Language
    final loveLanguages = [
      {'lang': 'Compliment', 'sub': 'Words of affirmation'},
      {'lang': 'Quality Time', 'sub': 'Undivided attention'},
      {'lang': 'Physical Touch', 'sub': 'To feel connected'},
      {'lang': 'Acts of Service', 'sub': 'Actions speak louder than words'},
      {'lang': 'Receiving Gifts', 'sub': 'Thoughtfulness and effort'},
    ];
    final loveLangMap = loveLanguages[random.nextInt(loveLanguages.length)];

    // Mock Communication Style
    final commStyles = [
      'Phone calls over texts',
      'Texts over phone calls',
      'Video calls over texts',
      'In-person meetings over calls',
    ];
    final commStyle = commStyles[random.nextInt(commStyles.length)];

    // Mock Religion
    final nat = json['nat'] as String?;
    final String religionStr;
    if (nat == 'IN') {
      final religions = ['Hindu-Marathi', 'Hindu-Hindi', 'Sikh', 'Spiritual'];
      religionStr = religions[random.nextInt(religions.length)];
    } else {
      final religions = ['Christian', 'Catholic', 'Agnostic', 'Spiritual', 'None'];
      religionStr = religions[random.nextInt(religions.length)];
    }

    // Mock Mother Tongue
    final String motherTongueStr;
    if (nat == 'IN') {
      motherTongueStr = random.nextBool() ? 'Marathi' : 'Hindi';
    } else if (nat == 'UA') {
      motherTongueStr = 'Ukrainian';
    } else if (nat == 'CH') {
      motherTongueStr = random.nextBool() ? 'French' : 'German';
    } else if (nat == 'BR') {
      motherTongueStr = 'Portuguese';
    } else if (nat == 'FR') {
      motherTongueStr = 'French';
    } else if (nat == 'DE') {
      motherTongueStr = 'German';
    } else if (nat == 'FI') {
      motherTongueStr = 'Finnish';
    } else if (nat == 'NL') {
      motherTongueStr = 'Dutch';
    } else if (nat == 'RS') {
      motherTongueStr = 'Serbian';
    } else {
      motherTongueStr = 'English';
    }

    // Mock Interested in based on gender
    final interestedInStr = isMale ? 'Women - Dating' : 'Men - Dating';

    // Seeding remaining components
    final careerMap = _mockCareers[random.nextInt(_mockCareers.length)];
    final prompt1Map = _mockPrompts1[random.nextInt(_mockPrompts1.length)];
    final prompt2Map = _mockPrompts2[random.nextInt(_mockPrompts2.length)];

    // Hobbies / Interests selection
    final allHobbies = ['Travel', 'Coffee', 'Trekking', 'Books', 'Yoga', 'Indie music', 'Cooking', 'Photography', 'Art', 'Cycling', 'Gardening', 'Movies'];
    final profileHobbies = <String>[];
    final shuffled = List<String>.from(allHobbies)..shuffle(random);
    final hobbiesCount = random.nextInt(3) + 5; // 5 to 7 hobbies
    for (var i = 0; i < hobbiesCount; i++) {
      profileHobbies.add(shuffled[i]);
    }

    // Lifestyle mapping
    final diet = _lifestyleDiets[random.nextInt(_lifestyleDiets.length)];
    final drink = _lifestyleDrinkings[random.nextInt(_lifestyleDrinkings.length)];
    final smoke = _lifestyleSmokings[random.nextInt(_lifestyleSmokings.length)];
    final fitness = _lifestyleFitnessTypes[random.nextInt(_lifestyleFitnessTypes.length)];
    final travel = _lifestyleTravels[random.nextInt(_lifestyleTravels.length)];

    // Dating Goal
    final datingGoal = _mockDatingGoals[random.nextInt(_mockDatingGoals.length)];

    return ProfileModel(
      name: fullName,
      age: age,
      location: locString,
      distance: '${random.nextInt(20) + 1} km away',
      occupation: careerMap['role'] ?? _mockOccupations[random.nextInt(_mockOccupations.length)],
      height: heightStr,
      intent: datingGoal['title'] ?? _mockIntents[random.nextInt(_mockIntents.length)],
      matchPercent: random.nextInt(30) + 70,
      trustPercent: random.nextInt(20) + 80,
      replyTime: '~${random.nextInt(15) + 1}m Reply',
      imageUrl: imageUrl,
      bio: _mockBios[random.nextInt(_mockBios.length)],
      dobDate: dobDateFormatted,
      locationCity: city,
      locationRegion: locationRegionStr,
      loveLanguage: loveLangMap['lang'],
      loveLanguageSubtext: loveLangMap['sub'],
      religion: religionStr,
      interestedIn: interestedInStr,
      zodiac: zodiacSign,
      zodiacTraits: zodiacTraits,
      motherTongue: motherTongueStr,
      communicationStyle: commStyle,
      imageUrl2: imageUrl2,
      imageUrl3: imageUrl3,
      videoThumbnailUrl: videoThumbnail,
      prompt1Question: prompt1Map['question'],
      prompt1Answer: prompt1Map['answer'],
      prompt2Question: prompt2Map['question'],
      prompt2Answer: prompt2Map['answer'],
      eduCollege: careerMap['college'],
      eduDegree: careerMap['degree'],
      workRole: careerMap['role'],
      workDetails: careerMap['details'],
      workStyle: careerMap['style'],
      ambitionLevel: careerMap['ambition'],
      bigDream: careerMap['dream'],
      interests: profileHobbies,
      lifestyleDiet: diet,
      lifestyleDrinking: drink,
      lifestyleSmoking: smoke,
      lifestyleFitness: fitness['main'],
      lifestyleFitnessSub: fitness['sub'],
      lifestyleTravel: travel,
      datingGoalTitle: datingGoal['title'],
      datingGoalDesc: datingGoal['desc'],
    );
  }

  final String? name;
  final int? age;
  final String? location;
  final String? distance;
  final String? occupation;
  final String? height;
  final String? intent;
  final int? matchPercent;
  final int? trustPercent;
  final String? replyTime;
  final String? imageUrl;
  final String? bio;

  final String? dobDate;
  final String? locationCity;
  final String? locationRegion;
  final String? loveLanguage;
  final String? loveLanguageSubtext;
  final String? religion;
  final String? interestedIn;
  final String? zodiac;
  final String? zodiacTraits;
  final String? motherTongue;
  final String? communicationStyle;

  // Video and Images
  final String? imageUrl2;
  final String? imageUrl3;
  final String? videoThumbnailUrl;

  // Prompts
  final String? prompt1Question;
  final String? prompt1Answer;
  final String? prompt2Question;
  final String? prompt2Answer;

  // Career details
  final String? eduCollege;
  final String? eduDegree;
  final String? workRole;
  final String? workDetails;
  final String? workStyle;
  final String? ambitionLevel;
  final String? bigDream;

  // Hobbies / Interests
  final List<String>? interests;

  // Lifestyle
  final String? lifestyleDiet;
  final String? lifestyleDrinking;
  final String? lifestyleSmoking;
  final String? lifestyleFitness;
  final String? lifestyleFitnessSub;
  final String? lifestyleTravel;

  // Dating Goal
  final String? datingGoalTitle;
  final String? datingGoalDesc;

  static String _formatDob(DateTime dt) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  static String _getZodiac(DateTime dt) {
    final day = dt.day;
    final month = dt.month;
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return 'Aries';
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return 'Taurus';
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return 'Gemini';
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return 'Cancer';
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return 'Leo';
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return 'Virgo';
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return 'Libra';
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return 'Scorpio';
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return 'Sagittarius';
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return 'Capricorn';
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return 'Aquarius';
    return 'Pisces';
  }

  static String _getZodiacTraits(String zodiac) {
    switch (zodiac) {
      case 'Aries': return 'Adventurous - Energetic - Courageous';
      case 'Taurus': return 'Patient - Reliable - Warmhearted';
      case 'Gemini': return 'Adaptable - Versatile - Witty';
      case 'Cancer': return 'Intuitive - Protective - Compassionate';
      case 'Leo': return 'Generous - Warmhearted - Creative';
      case 'Virgo': return 'Modest - Shy - Meticulous';
      case 'Libra': return 'Diplomatic - Urban - Easygoing';
      case 'Scorpio': return 'Loyal - Passionate - Intuitive';
      case 'Sagittarius': return 'Optimistic - Freedom-loving - Honest';
      case 'Capricorn': return 'Practical - Prudent - Disciplined';
      case 'Aquarius': return 'Friendly - Humanitarian - Honest';
      case 'Pisces': return 'Imaginative - Sensitive - Compassionate';
      default: return '';
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'location': location,
    'distance': distance,
    'occupation': occupation,
    'height': height,
    'intent': intent,
    'match_percent': matchPercent,
    'trust_percent': trustPercent,
    'reply_time': replyTime,
    'image_url': imageUrl,
    'bio': bio,
    'dob_date': dobDate,
    'location_city': locationCity,
    'location_region': locationRegion,
    'love_language': loveLanguage,
    'love_language_subtext': loveLanguageSubtext,
    'religion': religion,
    'interested_in': interestedIn,
    'zodiac': zodiac,
    'zodiac_traits': zodiacTraits,
    'mother_tongue': motherTongue,
    'communication_style': communicationStyle,
    'image_url_2': imageUrl2,
    'image_url_3': imageUrl3,
    'video_thumbnail_url': videoThumbnailUrl,
    'prompt_1_question': prompt1Question,
    'prompt_1_answer': prompt1Answer,
    'prompt_2_question': prompt2Question,
    'prompt_2_answer': prompt2Answer,
    'edu_college': eduCollege,
    'edu_degree': eduDegree,
    'work_role': workRole,
    'work_details': workDetails,
    'work_style': workStyle,
    'ambition_level': ambitionLevel,
    'big_dream': bigDream,
    'interests': interests,
    'lifestyle_diet': lifestyleDiet,
    'lifestyle_drinking': lifestyleDrinking,
    'lifestyle_smoking': lifestyleSmoking,
    'lifestyle_fitness': lifestyleFitness,
    'lifestyle_fitness_sub': lifestyleFitnessSub,
    'lifestyle_travel': lifestyleTravel,
    'dating_goal_title': datingGoalTitle,
    'dating_goal_desc': datingGoalDesc,
  };
}

const List<String> _mockOccupations = [
  'Software Engineer',
  'Graphic Designer',
  'Marketing Specialist',
  'Chef',
  'Teacher',
  'Doctor',
  'Freelancer',
];

const List<String> _mockIntents = [
  'Serious relationship',
  'Casual dating',
  'New friends',
  'Not sure yet',
];

const List<String> _mockBios = [
  'Building products by day, planning my next trek by night. Looking for someone equally driven and equally curious.',
  'Coffee enthusiast, dog lover, and amateur photographer. Let\'s explore the city together.',
  'Foodie at heart. I believe the best way to someone\'s heart is through their stomach.',
  'Currently seeking someone to share pizza and bad jokes with. Fluent in sarcasm and movie quotes.',
];

const List<Map<String, String>> _mockPrompts1 = [
  {
    'question': 'The way to win me over is...',
    'answer': 'A good book rec and a strong chai opinion.'
  },
  {
    'question': 'The way to win me over is...',
    'answer': 'Taking me out for street food and a sunset walk.'
  },
  {
    'question': 'The way to win me over is...',
    'answer': 'Being able to match my sarcasm and dark humor.'
  },
  {
    'question': 'The way to win me over is...',
    'answer': 'A surprise playlist with obscure indie artists.'
  }
];

const List<Map<String, String>> _mockPrompts2 = [
  {
    'question': 'My simple pleasures...',
    'answer': 'Roadside chai after a long trek, no signal, good company.'
  },
  {
    'question': 'My simple pleasures...',
    'answer': 'A warm blanket, a hot coffee, and a quiet rainy day.'
  },
  {
    'question': 'My simple pleasures...',
    'answer': 'Exploring new cafes in the city without a maps app.'
  },
  {
    'question': 'My simple pleasures...',
    'answer': 'The smell of old books and fresh lavender.'
  }
];

const List<Map<String, String>> _mockCareers = [
  {
    'college': 'NIFT Pune',
    'degree': 'B. Des Fashion Design • 3rd year',
    'role': 'Fashion Design',
    'details': 'Freelance • 2 yrs exp',
    'style': 'Creative • Hybrid',
    'ambition': 'HIGHLY DRIVEN',
    'dream': 'Launch her own sustainable Indian fashion label — handcrafted, slow fashion made with heart. Also wants to travel every fashion capital before 30.'
  },
  {
    'college': 'IIT Bombay',
    'degree': 'B.Tech Computer Science • Graduate',
    'role': 'Software Developer',
    'details': 'Tech Startup • 3 yrs exp',
    'style': 'Technical • Remote',
    'ambition': 'GOAL ORIENTED',
    'dream': 'Build an open-source educational platform for underprivileged kids to learn coding, and lead a remote lifestyle.'
  },
  {
    'college': 'Symbiosis Pune',
    'degree': 'MBA Marketing • Alumna',
    'role': 'Brand Consultant',
    'details': 'Media Agency • 4 yrs exp',
    'style': 'Strategic • On-site',
    'ambition': 'PASSIONATE & DRIVEN',
    'dream': 'Help small local businesses establish their identity online, and establish a boutique marketing studio.'
  },
  {
    'college': 'J J School of Art',
    'degree': 'BFA Fine Arts • 4th year',
    'role': 'Illustrator',
    'details': 'Independent Studio • 2 yrs exp',
    'style': 'Flexible • Hybrid',
    'ambition': 'CREATIVE & FOCUSED',
    'dream': 'Publish a children\'s picture book showcasing traditional folklore, and host a solo art gallery exhibition.'
  }
];

const List<String> _lifestyleDiets = ['Vegetarian', 'Vegan', 'Non-vegetarian', 'Eggetarian'];
const List<String> _lifestyleDrinkings = ['Socially', 'Regularly', 'Teetotaler', 'Rarely'];
const List<String> _lifestyleSmokings = ['Non-smoker', 'Occasional smoker', 'Smoker'];
const List<Map<String, String>> _lifestyleFitnessTypes = [
  {'main': 'Gym 4x/week', 'sub': 'Yoga • Trekking'},
  {'main': 'Running 3x/week', 'sub': 'Cycling • Swimming'},
  {'main': 'Yoga daily', 'sub': 'Meditation • Pilates'},
  {'main': 'Home workouts', 'sub': 'HIIT • Stretching'},
];
const List<String> _lifestyleTravels = ['4-5 trips/year', 'Weekend getaways', 'Frequent traveler', '1-2 trips/year'];

const List<Map<String, String>> _mockDatingGoals = [
  {
    'title': 'Long-term, marriage-open',
    'desc': 'No pressure, no timelines — just looking for the right person to build something real with.'
  },
  {
    'title': 'Long-term relationship',
    'desc': 'Looking to connect, see where things go, and build a meaningful long-term relationship.'
  },
  {
    'title': 'Casual dating',
    'desc': 'Keen to explore the city, meet new people, and share fun experiences without heavy expectations.'
  },
  {
    'title': 'New friends & connections',
    'desc': 'Open to making new friends, sharing common interests, and seeing where it naturally leads.'
  }
];
