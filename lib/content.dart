// ============================================================================
// DEMO CONTENT — this is the only file you need to edit.
// Replace the title, color, items and quiz with the audience's subject.
// ============================================================================
import 'package:flutter/material.dart';

import 'models.dart';

const appTitle = 'Ocean Explorer';
const appTagline = 'Meet the strangest creatures of the deep.';
const seedColor = Colors.teal;

/// What each item is called in the UI ("Creatures", "Planets", "Players"...).
const itemLabel = 'Creatures';

const items = <Item>[
  Item(
    emoji: '🐙',
    name: 'Octopus',
    subtitle: 'Eight arms, three hearts',
    description:
        'Octopuses are clever invertebrates that can change color and texture '
        'in a fraction of a second, solve puzzles, and squeeze through any gap '
        'larger than their beak.',
    facts: {'Habitat': 'Every ocean', 'Lifespan': '1–5 years', 'Hearts': '3'},
  ),
  Item(
    emoji: '🦈',
    name: 'Great White Shark',
    subtitle: 'Apex predator',
    description:
        'Great whites can sense a drop of blood in 100 liters of water and '
        'have about 300 serrated teeth arranged in rows.',
    facts: {'Length': 'Up to 6 m', 'Speed': '56 km/h', 'Lifespan': '70+ years'},
  ),
  Item(
    emoji: '🐋',
    name: 'Blue Whale',
    subtitle: 'Largest animal ever',
    description:
        'A blue whale\'s heart is the size of a small car, and its calls can '
        'travel hundreds of kilometers underwater.',
    facts: {'Length': 'Up to 30 m', 'Weight': '150+ tonnes', 'Diet': 'Krill'},
  ),
  Item(
    emoji: '🪼',
    name: 'Jellyfish',
    subtitle: 'No brain, no problem',
    description:
        'Jellyfish have existed for over 500 million years — longer than '
        'dinosaurs — and are about 95% water.',
    facts: {'Age of species': '500M years', 'Water': '95%', 'Brain': 'None'},
  ),
  Item(
    emoji: '🐢',
    name: 'Sea Turtle',
    subtitle: 'Ocean navigator',
    description:
        'Sea turtles use Earth\'s magnetic field to return to the same beach '
        'where they hatched to lay their own eggs.',
    facts: {'Lifespan': '50–100 years', 'Species': '7', 'Dive time': 'Hours'},
  ),
  Item(
    emoji: '🐡',
    name: 'Pufferfish',
    subtitle: 'Inflatable defense',
    description:
        'Pufferfish gulp water to balloon to several times their size, and many '
        'carry a toxin far deadlier than cyanide.',
    facts: {'Species': '120+', 'Defense': 'Inflate + toxin', 'Teeth': '4 fused'},
  ),
];

const quiz = <QuizQuestion>[
  QuizQuestion(
    question: 'How many hearts does an octopus have?',
    options: ['1', '2', '3', '8'],
    answerIndex: 2,
  ),
  QuizQuestion(
    question: 'What is the largest animal that has ever lived?',
    options: ['T. rex', 'Blue whale', 'Megalodon', 'Giant squid'],
    answerIndex: 1,
  ),
  QuizQuestion(
    question: 'Roughly how much of a jellyfish is water?',
    options: ['50%', '75%', '95%', '100%'],
    answerIndex: 2,
  ),
  QuizQuestion(
    question: 'What do sea turtles use to find their home beach?',
    options: ['The stars', 'Smell', 'Earth\'s magnetic field', 'Currents'],
    answerIndex: 2,
  ),
];
