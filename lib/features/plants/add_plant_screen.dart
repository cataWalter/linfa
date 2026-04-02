import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/enums.dart';
import '../../data/models/plant.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/widgets/photo_picker.dart';

/// Add plant screen
class AddPlantScreen extends ConsumerStatefulWidget {
  const AddPlantScreen({super.key});

  @override
  ConsumerState<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends ConsumerState<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _roomController = TextEditingController();
  final _notesController = TextEditingController();

  String? _photoPath;
  LightCondition _lightCondition = LightCondition.indirect;
  PlantStatus _status = PlantStatus.healthy;
  bool _isLoading = false;

  // Common rooms
  final List<String> _commonRooms = [
    'Soggiorno',
    'Cucina',
    'Camera da letto',
    'Bagno',
    'Studio',
    'Balcone',
    'Terrazzo',
  ];

  // Common species
  final List<String> _commonSpecies = [
    'Pothos',
    'Monstera Deliciosa',
    'Sansevieria',
    'Ficus Elastica',
    'Philodendron',
    'Succulenta',
    'Felce',
    'Palma',
    'Orchidea',
    'Aloe Vera',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _roomController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _savePlant() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final plant = Plant()
        ..name = _nameController.text.trim()
        ..species = _speciesController.text.trim().isEmpty
            ? null
            : _speciesController.text.trim()
        ..room = _roomController.text.trim().isEmpty
            ? null
            : _roomController.text.trim()
        ..lightCondition = _lightCondition.name
        ..status = _status.name
        ..photoPath = _photoPath
        ..notes = _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim()
        ..createdAt = DateTime.now();

      await ref.read(plantsProvider.notifier).addPlant(plant);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            backgroundColor: LinfaColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addPlant),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _savePlant,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    AppStrings.save,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Photo
            PhotoPicker(
              currentPhotoPath: _photoPath,
              onPhotoSelected: (path) {
                setState(() => _photoPath = path);
              },
            ),
            const SizedBox(height: 24),

            // Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: AppStrings.plantName,
                hintText: AppStrings.plantNameHint,
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Inserisci un nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Species
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return _commonSpecies;
                }
                return _commonSpecies.where((species) =>
                    species.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String selection) {
                _speciesController.text = selection;
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: AppStrings.species,
                    hintText: AppStrings.speciesHint,
                  ),
                  onFieldSubmitted: (_) => onFieldSubmitted(),
                );
              },
            ),
            const SizedBox(height: 16),

            // Room
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return _commonRooms;
                }
                return _commonRooms.where((room) =>
                    room.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String selection) {
                _roomController.text = selection;
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: AppStrings.room,
                    hintText: AppStrings.roomHint,
                  ),
                  onFieldSubmitted: (_) => onFieldSubmitted(),
                );
              },
            ),
            const SizedBox(height: 24),

            // Light condition
            Text(
              AppStrings.lightCondition,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: LightCondition.values.map((condition) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(condition.icon, size: 16),
                      const SizedBox(width: 4),
                      Text(condition.displayName),
                    ],
                  ),
                  selected: _lightCondition == condition,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _lightCondition = condition);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Status
            Text(
              AppStrings.plantStatus,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: PlantStatus.values.map((status) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(status.icon, size: 16),
                      const SizedBox(width: 4),
                      Text(status.displayName),
                    ],
                  ),
                  selected: _status == status,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _status = status);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Notes
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: AppStrings.notes,
                hintText: AppStrings.notesHint,
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
