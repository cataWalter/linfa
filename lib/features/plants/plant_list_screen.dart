import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/typography.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/widgets/empty_state.dart';
import 'widgets/plant_list_item.dart';

/// Plant list screen
class PlantListScreen extends ConsumerStatefulWidget {
  const PlantListScreen({super.key});

  @override
  ConsumerState<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends ConsumerState<PlantListScreen> {
  String? _selectedRoom;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final plantsAsync = ref.watch(plantsProvider);
    final roomsAsync = ref.watch(plantRoomsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myPlants),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => _searchQuery = '');
                          ref.read(plantsProvider.notifier).loadPlants();
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
                if (value.isNotEmpty) {
                  ref.read(plantsProvider.notifier).searchPlants(value);
                } else {
                  ref.read(plantsProvider.notifier).loadPlants();
                }
              },
            ),
          ),
          // Room filter chips
          roomsAsync.when(
            data: (rooms) {
              if (rooms.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    FilterChip(
                      label: const Text(AppStrings.allRooms),
                      selected: _selectedRoom == null,
                      onSelected: (_) {
                        setState(() => _selectedRoom = null);
                        ref.read(plantsProvider.notifier).loadPlants();
                      },
                    ),
                    const SizedBox(width: 8),
                    ...rooms.map((room) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(room),
                        selected: _selectedRoom == room,
                        onSelected: (_) {
                          setState(() => _selectedRoom = room);
                          ref.read(plantsProvider.notifier).filterByRoom(room);
                        },
                      ),
                    )),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          // Plant list
          Expanded(
            child: plantsAsync.when(
              data: (plants) {
                if (plants.isEmpty) {
                  return EmptyState(
                    icon: Icons.eco_outlined,
                    title: AppStrings.noPlants,
                    message: AppStrings.addFirstPlant,
                    actionLabel: AppStrings.addPlant,
                    onAction: () {
                      context.push(AppRoutes.addPlant);
                    },
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: plants.length,
                  itemBuilder: (context, index) {
                    return PlantListItem(plant: plants[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Errore: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add_plant_fab',
        onPressed: () {
          context.push(AppRoutes.addPlant);
        },
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addPlant),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SizedBox(),
    );
  }
}

/// Provider for plant rooms
final plantRoomsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.getAllRooms();
});
