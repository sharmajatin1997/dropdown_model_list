import 'package:flutter/material.dart';

/// A single chip widget used to display a selected item with a delete icon.
///
/// Typically used to represent a selected tag or option in a multi-select UI.
class MultiSelectChip extends StatelessWidget {
  /// The label to display inside the chip.
  final String label;

  /// Callback triggered when the chip's delete icon is tapped.
  final VoidCallback onDeleted;

  /// Creates a [MultiSelectChip] with a [label] and an [onDeleted] callback.
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

/// A row of [MultiSelectChip] widgets used to show a list of selected items.
///
/// Displays the chips using a [Wrap] layout for proper spacing and line wrapping.
class ChipRow extends StatelessWidget {
  /// List of labels to display as chips.
  final List<String> selectedLabels;

  /// Callback triggered when a chip's delete icon is tapped.
  final void Function(String) onDelete;

  /// Creates a [ChipRow] with a list of [selectedLabels] and an [onDelete] callback.
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
