import 'package:shared_preferences/shared_preferences.dart';

class UsageTracker {
  static const _keyInput = 'usage_input_tokens';
  static const _keyOutput = 'usage_output_tokens';
  static const _keyMonth = 'usage_month';

  // Claude Haiku 4.5 pricing
  static const _inputPer1M = 0.80;
  static const _outputPer1M = 4.00;
  static const limitDollars = 1.0;

  static Future<void> _maybeReset(SharedPreferences prefs) async {
    final now = DateTime.now();
    final month = '${now.year}-${now.month}';
    if (prefs.getString(_keyMonth) != month) {
      await prefs.setString(_keyMonth, month);
      await prefs.setInt(_keyInput, 0);
      await prefs.setInt(_keyOutput, 0);
    }
  }

  static Future<void> record(int inputTokens, int outputTokens) async {
    final prefs = await SharedPreferences.getInstance();
    await _maybeReset(prefs);
    await prefs.setInt(_keyInput, (prefs.getInt(_keyInput) ?? 0) + inputTokens);
    await prefs.setInt(_keyOutput, (prefs.getInt(_keyOutput) ?? 0) + outputTokens);
  }

  static Future<double> monthlyCost() async {
    final prefs = await SharedPreferences.getInstance();
    await _maybeReset(prefs);
    final input = prefs.getInt(_keyInput) ?? 0;
    final output = prefs.getInt(_keyOutput) ?? 0;
    return (input * _inputPer1M + output * _outputPer1M) / 1000000;
  }

  static Future<bool> isOverLimit() async =>
      (await monthlyCost()) >= limitDollars;
}
