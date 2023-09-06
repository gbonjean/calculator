import 'package:calculator/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorBody extends ConsumerWidget {
  const CalculatorBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String display = ref.watch(displayProvider);  

    return Column(
      children: [

        Container(
          color: Colors.white,
          width: double.infinity,
          height: 80,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                display,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          )
        ),
        const SizedBox(height: 32),
        const Flexible(
          child: CalculatorRow(
              text: ['C', '', '', '\u232B ']),
        ),
        const SizedBox(height: 16),
        const Flexible(
          child: CalculatorRow(
              text: ['7', '8', '9', '÷']),
        ),
        const SizedBox(height: 16),
        const Flexible(
          child: CalculatorRow(
              text: ['4', '5', '6', '×']),
        ),
        const SizedBox(height: 16),
        const Flexible(
          child: CalculatorRow(
              text: ['1', '2', '3', '-']),
        ),
        const SizedBox(height: 16),
        const Flexible(
          child: CalculatorRow(
              text: ['.', '0', '=', '+']),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class CalculatorRow extends StatelessWidget {
  const CalculatorRow(
      {super.key, required this.text});

  final List<String> text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(width: 16),
        Flexible(child: CalculatorButton(text[0])),
        const SizedBox(width: 16),
        Flexible(child: CalculatorButton(text[1])),
        const SizedBox(width: 16),
        Flexible(child: CalculatorButton(text[2])),
        const SizedBox(width: 16),
        Flexible(child: CalculatorButton(text[3])),
        const SizedBox(width: 16),
      ],
    );
  }
}

class CalculatorButton extends ConsumerWidget {
  const CalculatorButton(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(displayProvider.notifier).update(text);
      },
      child: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
            color: text.isEmpty 
            ? Theme.of(context).colorScheme.surfaceVariant
            : Theme.of(context).colorScheme.background,
            shape: BoxShape.circle,
     
            ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}