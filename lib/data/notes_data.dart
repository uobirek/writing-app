// import 'package:writing_app/screens/notes/models/character_note.dart';
// import 'package:writing_app/screens/notes/models/note.dart';
// import 'package:writing_app/screens/notes/models/simple_note.dart';
// import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';

// final List<Note> notes = [
//   // Worldbuilding Notes
//   WorldbuildingNote(
//     id: '1',
//     title: 'Resort Island',
//     createdAt: DateTime.now(),
//     image: 'assets/images/resort.jpg', // Placeholder image path
//     placeName: 'Resort Island',
//     geography:
//         'A tropical island surrounded by crystal-clear waters, covered with lush palm trees and vibrant flowers.',
//     culture:
//         'Relaxed island life with a focus on hospitality and tourism. Locals celebrate an annual festival called "The Tide Festival," featuring music, food, and water sports.',
//     pointsOfInterest: [
//       'Luxury Beach - Famous for its pristine sands and turquoise water.',
//       'Ancient Lighthouse - A historical landmark with rumors of hidden chambers.',
//       'Underground Caves - A labyrinth of mysterious caves said to hold secrets from the island’s past.',
//     ],
//   ),

//   // Character Notes
//   CharacterNote(
//     id: '3',
//     createdAt: DateTime.now(),
//     image: 'assets/images/dottie.jpg',
//     name: 'Dottie',
//     gender: 'Female',
//     age: 20,
//     role: 'Protagonist',
//     eyeColor: 'Blue',
//     hairColor: 'Blonde',
//     skinColor: 'Fair',
//     fashionStyle: 'Adventurous',
//     distinguishingFeatures: ['Freckles', 'Scar on her left hand'],
//     keyFamilyMembers: ['Father - Ethan', 'Mother - Sophia'],
//     notableEvents: [
//       'Lost her way in the forest at age 10.',
//       'Discovered a hidden treasure map.',
//     ],
//     traits: ['Brave', 'Curious', 'Optimistic'],
//     hobbiesSkills: ['Exploring', 'Sketching maps', 'Climbing'],
//     otherPersonalityDetails:
//         'She is driven by a sense of wonder and adventure.',
//     goals: ['Find the treasure.', 'Prove her worth as an adventurer.'],
//     internalConflicts: ['Fear of failure.', 'Doubts about her abilities.'],
//     externalConflicts: ['Antagonist I.C. Loveless.', 'Treacherous terrains.'],
//     coreValues: ['Courage', 'Loyalty', 'Determination'],
//   ),
//   CharacterNote(
//     id: '4',
//     createdAt: DateTime.now(),
//     image: 'assets/images/georgia.jpg',
//     name: 'Georgia',
//     gender: 'Female',
//     age: 22,
//     role: 'Supporting Character',
//     eyeColor: 'Green',
//     hairColor: 'Brown',
//     skinColor: 'Tan',
//     fashionStyle: 'Casual',
//     distinguishingFeatures: ['Glasses', 'Bright smile'],
//     keyFamilyMembers: ['Brother - Max'],
//     notableEvents: [
//       'Stood up to a local bully.',
//       'Saved Dottie from a landslide.',
//     ],
//     traits: ['Loyal', 'Witty', 'Impulsive'],
//     hobbiesSkills: ['Debating', 'Fixing gadgets', 'Cooking'],
//     otherPersonalityDetails: 'She often hides her vulnerability behind humor.',
//     goals: ['Support Dottie on her journey.', 'Overcome her own fears.'],
//     internalConflicts: ['Struggles to trust others.', 'Impatience.'],
//     externalConflicts: [
//       'Friction with I.C. Loveless.',
//       'Challenges in the wild.'
//     ],
//     coreValues: ['Friendship', 'Integrity', 'Courage'],
//   ),
//   CharacterNote(
//     id: '5',
//     createdAt: DateTime.now(),
//     image: 'assets/images/inclementia.jpg',
//     name: 'I.C. Loveless',
//     gender: 'Non-binary',
//     age: 45,
//     role: 'Antagonist',
//     eyeColor: 'Dark brown',
//     hairColor: 'Black',
//     skinColor: 'Pale',
//     fashionStyle: 'Elegant but sinister',
//     distinguishingFeatures: ['Sharp eyes', 'Scar across their eyebrow'],
//     keyFamilyMembers: [],
//     notableEvents: [
//       'Betrayed by a close ally.',
//       'Rose to power in the underworld.',
//     ],
//     traits: ['Manipulative', 'Clever', 'Resilient'],
//     hobbiesSkills: ['Strategizing', 'Persuasion', 'Fencing'],
//     otherPersonalityDetails: 'They are enigmatic and always one step ahead.',
//     goals: ['Obtain the treasure.', 'Eliminate anyone in their way.'],
//     internalConflicts: ['Desires redemption but denies it to themselves.'],
//     externalConflicts: [
//       'Protagonist Dottie.',
//       'Former ally Zachariah Fleury.',
//     ],
//     coreValues: ['Power', 'Survival', 'Control'],
//   ),
//   CharacterNote(
//     id: '6',
//     createdAt: DateTime.now(),
//     image: 'assets/images/giovanni.jpg',
//     name: 'Giovanni',
//     gender: 'Male',
//     age: 60,
//     role: 'Mentor',
//     eyeColor: 'Gray',
//     hairColor: 'Silver',
//     skinColor: 'Olive',
//     fashionStyle: 'Simple yet dignified',
//     distinguishingFeatures: ['Beard', 'Walking stick'],
//     keyFamilyMembers: ['Nephew - Marco'],
//     notableEvents: [
//       'Survived a shipwreck in his youth.',
//       'Discovered the ancient lighthouse.',
//     ],
//     traits: ['Wise', 'Kind', 'Patient'],
//     hobbiesSkills: ['Storytelling', 'Navigation', 'Herbal medicine'],
//     otherPersonalityDetails: 'He is a source of guidance and inspiration.',
//     goals: ['Help Dottie succeed.', 'Protect the island’s legacy.'],
//     internalConflicts: ['Regret over past mistakes.'],
//     externalConflicts: ['Tension with I.C. Loveless.'],
//     coreValues: ['Wisdom', 'Compassion', 'Legacy'],
//   ),
//   CharacterNote(
//     id: '7',
//     createdAt: DateTime.now(),
//     image: 'assets/images/zach.jpg',
//     name: 'Zachariah Fleury',
//     gender: 'Male',
//     age: 30,
//     role: 'Rogue Ally',
//     eyeColor: 'Hazel',
//     hairColor: 'Dark brown',
//     skinColor: 'Light tan',
//     fashionStyle: 'Rugged and practical',
//     distinguishingFeatures: ['Tattoo of a compass', 'Piercing gaze'],
//     keyFamilyMembers: ['Estranged sister - Lily'],
//     notableEvents: [
//       'Betrayed I.C. Loveless.',
//       'Saved a village from bandits.',
//     ],
//     traits: ['Charming', 'Unpredictable', 'Resourceful'],
//     hobbiesSkills: [
//       'Lockpicking',
//       'Swordsmanship',
//       'Performing sleight-of-hand tricks'
//     ],
//     otherPersonalityDetails: 'He walks the line between hero and villain.',
//     goals: ['Redeem himself.', 'Uncover his sister’s fate.'],
//     internalConflicts: ['Struggles with guilt.', 'Fear of commitment.'],
//     externalConflicts: [
//       'Conflict with I.C. Loveless.',
//       'Alliance with Dottie.'
//     ],
//     coreValues: ['Freedom', 'Loyalty', 'Justice'],
//   ),
//   SimpleNote(
//     "that's the data",
//     id: "12",
//     title: "special note 1",
//     createdAt: DateTime.now(),
//     image: 'assets/images/zach.jpg',
//   )
// ];
