import 'dart:math';

import 'package:flutter/material.dart';

import '../data/quotes.dart';
import '../models/quote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Quote _quote;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _quote = _pickRandom();
  }

  Quote _pickRandom() {
    return quotes[_random.nextInt(quotes.length)];
  }

  void _nextQuote() {
    setState(() {
      Quote next;
      do {
        next = _pickRandom();
      } while (quotes.length > 1 && next.text == _quote.text);
      _quote = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.format_quote, color: scheme.primary, size: 34),
                  const SizedBox(width: 8),
                  Text(
                    'Daily Quote',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.primary,
                        ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Column(
                        key: ValueKey(_quote.text),
                        children: [
                          Text(
                            '“${_quote.text}”',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 28,
                                height: 2,
                                color: scheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '— ${_quote.author}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: _nextQuote,
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      'New Quote',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: scheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}