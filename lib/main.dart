import 'dart:math';

import 'package:flutter/material.dart';

import 'content.dart';
import 'models.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme(Brightness b) => ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: b),
          useMaterial3: true,
        );
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      home: const HomeShell(),
    );
  }
}

/// Bottom-tab shell: Explore, Quiz, Favorites. Favorites live in memory.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;
  final _favorites = <String>{};

  void _toggleFavorite(Item item) => setState(() {
        if (!_favorites.remove(item.name)) _favorites.add(item.name);
      });

  void _openItem(Item item) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => StatefulBuilder(
          builder: (context, setLocal) => DetailPage(
            item: item,
            isFavorite: _favorites.contains(item.name),
            onToggleFavorite: () {
              _toggleFavorite(item);
              setLocal(() {});
            },
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    final pages = [
      ExplorePage(onOpen: _openItem),
      if (quiz.isNotEmpty) const QuizPage(),
      ItemList(
        items: items.where((i) => _favorites.contains(i.name)).toList(),
        onOpen: _openItem,
        empty: 'Tap ♡ on any of the $itemLabel to save it here.',
      ),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          if (quiz.isNotEmpty)
            const NavigationDestination(icon: Icon(Icons.quiz), label: 'Quiz'),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _favorites.isNotEmpty,
              label: Text('${_favorites.length}'),
              child: const Icon(Icons.favorite),
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key, required this.onOpen});

  final void Function(Item) onOpen;

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final q = _query.toLowerCase();
    final filtered = items
        .where((i) => '${i.name} ${i.subtitle}'.toLowerCase().contains(q))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Row(
            children: [
              Expanded(child: Text(appTitle, style: text.headlineMedium)),
              IconButton.filledTonal(
                tooltip: 'Surprise me',
                icon: const Icon(Icons.casino),
                onPressed: () =>
                    widget.onOpen(items[Random().nextInt(items.length)]),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(appTagline, style: text.bodyLarge),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchBar(
            hintText: 'Search $itemLabel',
            leading: const Icon(Icons.search),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: ItemList(
            items: filtered,
            onOpen: widget.onOpen,
            empty: 'No $itemLabel match "$_query".',
          ),
        ),
      ],
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.items,
    required this.onOpen,
    required this.empty,
  });

  final List<Item> items;
  final void Function(Item) onOpen;
  final String empty;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(empty, textAlign: TextAlign.center),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        return Card(
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Hero(
              tag: item.name,
              child: Text(item.emoji, style: const TextStyle(fontSize: 36)),
            ),
            title: Text(item.name),
            subtitle: Text(item.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onOpen(item),
          ),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final Item item;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : null,
            onPressed: onToggleFavorite,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              width: 160,
              height: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Hero(
                tag: item.name,
                child: Text(item.emoji, style: const TextStyle(fontSize: 88)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(item.name,
              style: theme.textTheme.headlineMedium, textAlign: TextAlign.center),
          Text(item.subtitle,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.primary),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text(item.description, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final f in item.facts.entries)
                Chip(label: Text('${f.key}: ${f.value}')),
            ],
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _index = 0;
  int _score = 0;
  int? _picked;

  void _pick(int i) {
    if (_picked != null) return;
    setState(() {
      _picked = i;
      if (i == quiz[_index].answerIndex) _score++;
    });
  }

  void _next() => setState(() {
        _index++;
        _picked = null;
      });

  void _restart() => setState(() {
        _index = 0;
        _score = 0;
        _picked = null;
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_index >= quiz.length) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_score == quiz.length ? '🏆' : '🎉',
                style: const TextStyle(fontSize: 96)),
            Text('You scored $_score / ${quiz.length}',
                style: theme.textTheme.headlineSmall),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _restart,
              icon: const Icon(Icons.replay),
              label: const Text('Play again'),
            ),
          ],
        ),
      );
    }
    final q = quiz[_index];
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        LinearProgressIndicator(value: _index / quiz.length),
        const SizedBox(height: 8),
        Text('Question ${_index + 1} of ${quiz.length}',
            style: theme.textTheme.labelLarge),
        const SizedBox(height: 16),
        Text(q.question, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 24),
        for (var i = 0; i < q.options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _OptionButton(
              label: q.options[i],
              state: _picked == null
                  ? null
                  : i == q.answerIndex
                      ? true
                      : i == _picked
                          ? false
                          : null,
              onTap: () => _pick(i),
            ),
          ),
        if (_picked != null)
          FilledButton(
            onPressed: _next,
            child: Text(_index == quiz.length - 1 ? 'See score' : 'Next'),
          ),
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({required this.label, required this.state, required this.onTap});

  final String label;

  /// null = neutral, true = correct, false = wrong pick.
  final bool? state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      true => Colors.green,
      false => Colors.red,
      null => null,
    };
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(18),
        alignment: Alignment.centerLeft,
        backgroundColor: color?.withValues(alpha: 0.15),
        side: color == null ? null : BorderSide(color: color, width: 2),
      ),
      onPressed: onTap,
      child: Text(label, style: const TextStyle(fontSize: 18)),
    );
  }
}
