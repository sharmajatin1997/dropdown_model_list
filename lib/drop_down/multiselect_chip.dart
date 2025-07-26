import 'package:flutter/material.dart';

class MultiSelectChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const MultiSelectChip({
    required this.label,
    required this.onDeleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Chip(
        label: Text(label, style: const TextStyle(fontSize: 14)),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: onDeleted,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 6),
      ),
    );
  }
}

class ChipRow extends StatelessWidget {
  final List<String> selectedLabels;
  final void Function(String) onDelete;

  const ChipRow({
    super.key,
    required this.selectedLabels,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: selectedLabels
          .map((label) => MultiSelectChip(
        label: label,
        onDeleted: () => onDelete(label),
      ))
          .toList(),
    );
  }
}
