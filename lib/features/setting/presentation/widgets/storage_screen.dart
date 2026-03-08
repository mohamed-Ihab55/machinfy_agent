import 'package:flutter/material.dart';
import 'package:machinfy_agent/features/setting/presentation/services/storage_service.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/section_title.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/storage_action_card.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/storage_overview.dart';
import 'package:machinfy_agent/features/setting/presentation/widgets/storage_tips.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  bool isLoading = false;
  double totalStorage = 500.0;
  double usedStorage = 0.0;
  Map<String, double> storageBreakdown = {
    'Chat History': 0,
    'Downloaded Files': 0,
    'Cache': 0,
    'Media': 0,
  };

  double get availableStorage => totalStorage - usedStorage;
  double get storagePercentage =>
      totalStorage == 0 ? 0 : (usedStorage / totalStorage) * 100;

  @override
  void initState() {
    super.initState();
    _updateStorageInfo();
  }

  Future<void> _updateStorageInfo() async {
    setState(() => isLoading = true);
    final result = await StorageService.calculateStorage();
    setState(() {
      storageBreakdown = result;
      usedStorage = storageBreakdown.values.reduce((a, b) => a + b);
      isLoading = false;
    });
  }

  Future<void> _clearCache() async {
    final confirmed = await StorageService.showConfirmDialog(
      context,
      'Clear Cache',
      'This will clear ${storageBreakdown['Cache']!.toStringAsFixed(1)} MB of cached data. Continue?',
    );
    if (confirmed != true) return;

    await StorageService.clearCache();
    await _updateStorageInfo();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache cleared successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Storage'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _updateStorageInfo,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StorageOverview(
                    usedStorage: usedStorage,
                    totalStorage: totalStorage,
                    storagePercentage: storagePercentage,
                    availableStorage: availableStorage,
                  ),
                  const SizedBox(height: 30),
                  const SectionTitle(title: 'Quick Actions'),
                  const SizedBox(height: 16),
                  ActionCard(
                    icon: Icons.cleaning_services_outlined,
                    title: 'Clear Cache',
                    subtitle:
                        '${storageBreakdown['Cache']!.toStringAsFixed(1)} MB can be cleared',
                    color: Colors.orange,
                    onTap: _clearCache,
                  ),
                  const SizedBox(height: 30),
                  const StorageTips(
                    tips: ['Clear cache regularly to free up space'],
                  ),
                ],
              ),
            ),
    );
  }
}
