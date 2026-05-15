import 'package:flutter/material.dart';

class CryptoPrediction {
  final String symbol;
  final String name;
  final double currentPrice;
  final double predictionPrice;
  final String signal; // "Buy", "Sell", "Hold"
  final double confidence;
  final double change24h;

  CryptoPrediction({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.predictionPrice,
    required this.signal,
    required this.confidence,
    required this.change24h,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<CryptoPrediction> predictions = [
    CryptoPrediction(
      symbol: 'BTC',
      name: 'Bitcoin',
      currentPrice: 65430.00,
      predictionPrice: 68000.00,
      signal: 'Buy',
      confidence: 0.89,
      change24h: 2.5,
    ),
    CryptoPrediction(
      symbol: 'ETH',
      name: 'Ethereum',
      currentPrice: 3450.00,
      predictionPrice: 3800.00,
      signal: 'Buy',
      confidence: 0.82,
      change24h: 4.1,
    ),
    CryptoPrediction(
      symbol: 'USD.AI',
      name: 'USD.AI Token',
      currentPrice: 1.05,
      predictionPrice: 1.50,
      signal: 'Strong Buy',
      confidence: 0.95,
      change24h: 15.2,
    ),
    CryptoPrediction(
      symbol: 'SOL',
      name: 'Solana',
      currentPrice: 145.20,
      predictionPrice: 140.00,
      signal: 'Hold',
      confidence: 0.65,
      change24h: -1.2,
    ),
    CryptoPrediction(
      symbol: 'XRP',
      name: 'Ripple',
      currentPrice: 0.58,
      predictionPrice: 0.52,
      signal: 'Sell',
      confidence: 0.75,
      change24h: -3.4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'USD.AI Predictions',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 900 ? 3 : constraints.maxWidth > 600 ? 2 : 1;
          
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AI Market Analysis',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Powered by USD.AI deep learning models. Forecasts are updated in real-time based on market sentiment and volume analysis.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildPredictionCard(predictions[index]);
                      },
                      childCount: predictions.length,
                    ),
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildPredictionCard(CryptoPrediction crypto) {
    final bool isPositive = crypto.change24h >= 0;
    final Color signalColor = crypto.signal.contains('Buy') 
        ? const Color(0xFF00FF7F) 
        : crypto.signal == 'Sell' 
            ? Colors.redAccent 
            : Colors.amber;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: signalColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: signalColor.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    radius: 18,
                    child: Text(
                      crypto.symbol[0],
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crypto.symbol,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        crypto.name,
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${isPositive ? '+' : ''}${crypto.change24h}%',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Price',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${crypto.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Target (24h)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${crypto.predictionPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: signalColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_graph, color: signalColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    crypto.signal,
                    style: TextStyle(
                      color: signalColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'AI Confidence: ${(crypto.confidence * 100).toInt()}%',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: crypto.confidence,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(signalColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
