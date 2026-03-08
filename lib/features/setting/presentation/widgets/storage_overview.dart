import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';

class StorageOverview extends StatelessWidget {
  final double usedStorage;
  final double totalStorage;
  final double storagePercentage;
  final double availableStorage;

  const StorageOverview({
    required this.usedStorage,
    required this.totalStorage,
    required this.storagePercentage,
    required this.availableStorage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kPrimaryColor, kSecondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1976D2).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('Total Storage Used',
              style: Style.bodysmall.copyWith(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 12),
          Text('${usedStorage.toStringAsFixed(1)} MB',
              style: Style.headingLarge.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text('of ${totalStorage.toStringAsFixed(0)} MB',
              style: Style.bodysmall.copyWith(color: Colors.white70)),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: usedStorage / totalStorage,
              minHeight: 10,
              backgroundColor: kSubTitleColor,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${storagePercentage.toStringAsFixed(1)}% Used',
                  style: Style.bodysmall.copyWith(color: Colors.white)),
              Text('${availableStorage.toStringAsFixed(1)} MB Free',
                  style: Style.bodysmall.copyWith(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}