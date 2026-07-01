import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../data/models/streamer_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.waveGradientEnd, AppColors.waveGradientStart],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Alive', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                      Icon(Icons.videocam_rounded, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.notifications_none_rounded, color: Colors.black87, size: 26),
                  ),
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 12),
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.waveGradientEnd, AppColors.waveGradientStart],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 24),
            ),
          ],
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                // Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      _buildTabItem('Stream', viewModel),
                      const SizedBox(width: 24),
                      _buildTabItem('Hot', viewModel),
                      const SizedBox(width: 24),
                      _buildTabItem('Follow', viewModel),
                    ],
                  ),
                ),
                // Categories
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildCategoryChip('🌐 Global', viewModel),
                      _buildCategoryChip('🇮🇳 India', viewModel),
                      _buildCategoryChip('🇵🇭 Philippines', viewModel),
                      _buildCategoryChip('🇧🇷 Brazil', viewModel),
                      _buildCategoryChip('🇲🇦 Morocco', viewModel),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Grid
                Expanded(
                  child: viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 100),
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200, // Adapts seamlessly to iPads and larger screens
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: viewModel.streamers.length,
                          itemBuilder: (context, index) {
                            return _buildStreamerCard(viewModel.streamers[index]);
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, HomeViewModel viewModel) {
    final isSelected = viewModel.selectedTab == label;
    return GestureDetector(
      onTap: () => viewModel.setTab(label),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.5),
          fontSize: isSelected ? 20 : 18,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, HomeViewModel viewModel) {
    final isSelected = viewModel.selectedCategory == label;
    final parts = label.split(' ');
    final iconString = parts.first;
    final textString = parts.skip(1).join(' ');

    return GestureDetector(
      onTap: () => viewModel.setCategory(label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : Colors.transparent,
          border: isSelected ? Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 1.0) : Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconString == '🌐') 
              const Icon(Icons.language, color: Colors.blue, size: 18)
            else 
              Text(iconString, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              textString,
              style: TextStyle(
                color: isSelected ? Colors.black87 : Colors.grey.shade500,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamerCard(StreamerModel streamer) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: CachedNetworkImageProvider(streamer.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
            stops: const [0.5, 1.0],
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.remove_red_eye, color: Colors.white, size: 12),
                  const SizedBox(width: 4),
                  Text(streamer.views, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(streamer.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(streamer.countryFlag, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('+ Follow', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
