import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/date.dart';
import '../../data/models/growth_entry.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/photo_picker.dart';

/// Growth timeline screen
class GrowthTimelineScreen extends ConsumerStatefulWidget {
  const GrowthTimelineScreen({super.key, required this.plantId, this.plantName = ''});

  final int plantId;
  final String plantName;

  @override
  ConsumerState<GrowthTimelineScreen> createState() => _GrowthTimelineScreenState();
}

class _GrowthTimelineScreenState extends ConsumerState<GrowthTimelineScreen> {
  final List<GrowthEntry> _entries = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    setState(() => _isLoading = true);
    // Simulated loading - in real app this would query the database
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
  }

  Future<void> _addEntry() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddEntrySheet(
        plantId: widget.plantId,
        onEntryAdded: () {
          _loadEntries();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppStrings.growthTimeline} - ${widget.plantName}'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _entries.isEmpty
              ? EmptyState(
                  icon: Icons.timeline,
                  title: AppStrings.noGrowthEntries,
                  message: AppStrings.addFirstPhoto,
                  actionLabel: AppStrings.add,
                  onAction: _addEntry,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _entries.length,
                  itemBuilder: (context, index) {
                    final entry = _entries[index];
                    return _GrowthEntryCard(
                      entry: entry,
                      onDelete: () {
                        setState(() => _entries.removeAt(index));
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_growth_entry_fab',
        onPressed: _addEntry,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

class _GrowthEntryCard extends StatelessWidget {
  const _GrowthEntryCard({required this.entry, required this.onDelete});

  final GrowthEntry entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entry.photoPath != null && File(entry.photoPath!).existsSync())
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.file(
                File(entry.photoPath!),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LinfaDateUtils.formatFullDate(entry.date),
                      style: LinfaTypography.getLabelMedium().copyWith(
                        color: LinfaColors.textSecondaryLight,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: onDelete,
                    ),
                  ],
                ),
                if (entry.heightCm != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.height, size: 16),
                      const SizedBox(width: 4),
                      Text('${entry.heightCm} cm'),
                    ],
                  ),
                ],
                if (entry.newLeaves != null && entry.newLeaves! > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.eco, size: 16),
                      const SizedBox(width: 4),
                      Text('${entry.newLeaves} nuove foglie'),
                    ],
                  ),
                ],
                if (entry.healthRating != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < entry.healthRating!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 16,
                        color: index < entry.healthRating!
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
                if (entry.notes != null && entry.notes!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(entry.notes!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddEntrySheet extends StatefulWidget {
  const _AddEntrySheet({required this.plantId, required this.onEntryAdded});

  final int plantId;
  final VoidCallback onEntryAdded;

  @override
  State<_AddEntrySheet> createState() => _AddEntrySheetState();
}

class _AddEntrySheetState extends State<_AddEntrySheet> {
  final _notesController = TextEditingController();
  final _heightController = TextEditingController();
  final _newLeavesController = TextEditingController();
  String? _photoPath;
  int _healthRating = 3;
  bool _isSaving = false;

  @override
  void dispose() {
    _notesController.dispose();
    _heightController.dispose();
    _newLeavesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _photoPath = image.path);
    }
  }

  Future<void> _saveEntry() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 500));
    widget.onEntryAdded();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.addGrowthEntry,
              style: LinfaTypography.getTitleLarge(),
            ),
            const SizedBox(height: 16),
            PhotoPicker(
              currentPhotoPath: _photoPath,
              onPhotoSelected: (path) => setState(() => _photoPath = path),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: AppStrings.height,
                hintText: AppStrings.heightHint,
                suffixText: 'cm',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newLeavesController,
              decoration: const InputDecoration(
                labelText: AppStrings.newLeaves,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(AppStrings.healthRating),
                const SizedBox(width: 16),
                ...List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      index < _healthRating ? Icons.favorite : Icons.favorite_border,
                      color: index < _healthRating ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => setState(() => _healthRating = index + 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: AppStrings.notes,
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveEntry,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(AppStrings.save),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
