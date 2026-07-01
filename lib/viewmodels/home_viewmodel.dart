import 'package:flutter/material.dart';
import '../data/models/streamer_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<StreamerModel> _streamers = [];
  
  String _selectedTab = 'Stream';
  String _selectedCategory = '🌐 Global';
  
  bool get isLoading => _isLoading;
  List<StreamerModel> get streamers => _streamers;
  String get selectedTab => _selectedTab;
  String get selectedCategory => _selectedCategory;

  HomeViewModel() {
    fetchStreamers();
  }

  void setTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchStreamers() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data based on the design
    _streamers = [
      StreamerModel(
        id: '1',
        name: 'Sofia Chen',
        imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=400',
        views: '8.2K',
        countryFlag: '🇵🇭',
      ),
      StreamerModel(
        id: '2',
        name: 'Sofia Chen',
        imageUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&q=80&w=400',
        views: '8.2K',
        countryFlag: '🇵🇭',
      ),
      StreamerModel(
        id: '3',
        name: 'Sofia Chen',
        imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&q=80&w=400',
        views: '8.2K',
        countryFlag: '🇵🇭',
      ),
      StreamerModel(
        id: '4',
        name: 'Sofia Chen',
        imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&q=80&w=400',
        views: '8.2K',
        countryFlag: '🇵🇭',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
