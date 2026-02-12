import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  bool isLoading = false;

  // Mock data - replace with actual storage calculation
  final double totalStorage = 500.0; // MB
  final double usedStorage = 342.5; // MB
  final Map<String, double> storageBreakdown = {
    'Chat History': 125.3,
    'Downloaded Files': 98.7,
    'Cache': 87.2,
    'Media': 31.3,
  };

  double get availableStorage => totalStorage - usedStorage;
  double get storagePercentage => (usedStorage / totalStorage) * 100;

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
            onPressed: _refreshStorage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Storage Overview Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kPrimaryColor, kSecondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1976D2).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Total Storage Used',
                      style: Style.bodysmall.copyWith(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${usedStorage.toStringAsFixed(1)} MB',
                      style: Style.headingLarge.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'of ${totalStorage.toStringAsFixed(0)} MB',
                      style: Style.bodysmall.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 24),

                    // Storage Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: usedStorage / totalStorage,
                        minHeight: 10,
                        backgroundColor: kSubTitleColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${storagePercentage.toStringAsFixed(1)}% Used',
                          style: Style.bodysmall.copyWith(color: Colors.white),
                        ),
                        Text(
                          '${availableStorage.toStringAsFixed(1)} MB Free',
                          style: Style.bodysmall.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Quick Actions
              Text(
                'Quick Actions',
                style: Style.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),

              _buildActionCard(
                icon: Icons.cleaning_services_outlined,
                title: 'Clear Cache',
                subtitle:
                    '${storageBreakdown['Cache']!.toStringAsFixed(1)} MB can be cleared',
                color: Colors.orange,
                onTap: _clearCache,
              ),
              const SizedBox(height: 30),
              // Tips Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.lightbulb_outline,
                          color: kPrimaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Storage Tips',
                          style: Style.bodysmall.copyWith(
                            color: kPrimaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTip('Clear cache regularly to free up space'),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Style.bodysmall.copyWith(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Style.bodysmall.copyWith(color: kSubTitleColor),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: kSubTitleColor),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 14,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Style.bodysmall.copyWith(
                fontSize: 14,
                color: kSubTitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshStorage() async {
    setState(() => isLoading = true);
    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Storage refreshed')));
    }
  }

  Future<void> _clearCache() async {
    final confirmed = await _showConfirmDialog(
      'Clear Cache',
      'This will clear ${storageBreakdown['Cache']!.toStringAsFixed(1)} MB of cached data. Continue?',
    );
    if (confirmed == true) {
      // Implement cache clearing logic
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cache cleared successfully')),
        );
      }
    }
  }

  Future<bool?> _showConfirmDialog(String title, String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: kErrorColor),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
