import 'package:class_frontend/services/provider/test.provier.dart';
import 'package:class_frontend/widgets/global/test.card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestData extends StatelessWidget {
  const TestData({super.key});

  @override
  Widget build(BuildContext context) {
    final testProvider = Provider.of<TestProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      testProvider.fetchTest();
    });

    return Consumer<TestProvider>(
      builder: (context, testProvider, child) {
        if (testProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (testProvider.test.isEmpty) {
          return Center(child: Text('No test available'));
        }

        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: testProvider.test.length,
            itemBuilder: (context, index) {
              final test = testProvider.test[index];
              return TestCard(test:test);
            },
          ),
        );
      },
    );
    
  }
}