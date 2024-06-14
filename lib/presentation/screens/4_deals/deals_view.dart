import 'package:chambeape/presentation/screens/4_deals/widgets/post_card_deal_widget.dart';
import 'package:flutter/material.dart';

class DealsView extends StatelessWidget {
  const DealsView({super.key});

  static const String routeName = 'deals_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Negociaciones'),
      ),
      body: const PostCardDealWidget(),
    );
  }
}
