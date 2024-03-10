
import 'package:flutter/material.dart';

class InsurancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopSection(context),
          _buildBottomSection(context),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: PageView(
        children: [
          _buildSlide('imgs/fin_harmony.json', 'Financial Harmony, Community Prosperity',
              'National Health Insurance Fund is a State Parastatal that was established in 1966 as a department under the Ministry of Health. The original Act of Parliament that set up this Fund in 1966 has over the years been reviewed to accommodate the changing healthcare needs of the Kenyan population, employment and restructuring in the health sector.', context),
          _buildSlide('imgs/phone_hand.json', 'Unlock Prosperity, Secure Tomorrow',
              'Unlock the doors to prosperity and secure your financial tomorrow. Our SACCOS and financial solutions are designed to safeguard your dreams and create a path to wealth.', context),
          _buildSlide('imgs/anim_1.json', 'Building Wealth, Building Trust',
              '"Build wealth while building trust. Our SACCOS and financial solutions prioritize transparency and integrity, ensuring a trustworthy partnership in your financial journey.', context),
          _buildSlide('imgs/anim_2.json', 'Investing in Your Tomorrow, Today',
              'Our SACCOS and financial solutions pave the way for a brighter tomorrow. Start investing in your future today with personalized financial strategies that stand the test of time.', context),
          _buildSlide('imgs/anim_3.json', 'Savings Redefined, Dreams Realized',
              'Experience the power of smart finance that strengthens communities. Our SACCOS and financial solutions foster economic growth, ensuring a resilient and prosperous society.', context),
        ],
      ),
    );
  }

  Widget _buildSlide(String lottie, String title, String text, context ) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Image.asset(
              'kcb.png',
              height: MediaQuery.of(context).size.height * 0.07,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 5.0),
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.0),
          OutlinedButton(
            onPressed: () {
            },
            child: Text('Learn MOre...'),
          ),
        ],
      ),
    );
  }
}
