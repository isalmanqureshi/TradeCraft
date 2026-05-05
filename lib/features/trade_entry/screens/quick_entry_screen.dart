import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/trade_model.dart';
import '../controllers/trade_entry_controller.dart';

class QuickEntryScreen extends ConsumerStatefulWidget { const QuickEntryScreen({super.key}); @override ConsumerState<QuickEntryScreen> createState()=>_QuickEntryScreenState(); }
class _QuickEntryScreenState extends ConsumerState<QuickEntryScreen> {
  final symbol = TextEditingController(); final entry=TextEditingController(); final exit=TextEditingController(); final qty=TextEditingController(); final fees=TextEditingController(text:'0'); final notes=TextEditingController();
  @override Widget build(BuildContext context){ final st=ref.watch(tradeEntryControllerProvider).value; final ctl=ref.read(tradeEntryControllerProvider.notifier); final pnl=st?.calculatedPnl; final c=pnl==null?AppColors.textSecondary:(pnl>=0?AppColors.profit:AppColors.loss);
    return Scaffold(appBar: AppBar(title: const Text('Quick Entry')), body: ListView(padding: const EdgeInsets.all(16), children:[
      AppTextField(label:'Symbol',hint:'AAPL',controller:symbol,onChanged:ctl.updateSymbol), const Gap(12),
      SegmentedButton<TradeDirection>(segments: const [ButtonSegment(value: TradeDirection.long, label: Text('Long'), icon: Icon(Icons.trending_up)),ButtonSegment(value: TradeDirection.short, label: Text('Short'), icon: Icon(Icons.trending_down))], selected:{st?.draft.direction??TradeDirection.long}, onSelectionChanged:(s)=>ctl.updateDirection(s.first)), const Gap(12),
      AppTextField(label:'Entry Price',hint:'150.00',controller:entry,keyboardType: const TextInputType.numberWithOptions(decimal: true),onChanged:(v)=>ctl.updateEntryPrice(double.tryParse(v)??0)), const Gap(12),
      AppTextField(label:'Exit Price',hint:'155.00',controller:exit,keyboardType: const TextInputType.numberWithOptions(decimal: true),onChanged:(v)=>ctl.updateExitPrice(double.tryParse(v)??0)), const Gap(12),
      AppTextField(label:'Quantity',hint:'100',controller:qty,keyboardType: const TextInputType.numberWithOptions(decimal: true),onChanged:(v)=>ctl.updateQuantity(double.tryParse(v)??0)), const Gap(12),
      AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('P&L Preview', style: Theme.of(context).textTheme.titleMedium), const Gap(8), Text('Net: ${pnl?.toStringAsFixed(2) ?? '--'}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color:c)), const Gap(8), AppTextField(label:'Fees',controller:fees,keyboardType: const TextInputType.numberWithOptions(decimal: true),onChanged:(v)=>ctl.updateFees(double.tryParse(v)??0))])), const Gap(12),
      Wrap(spacing:8, children: ['Breakout','Trend','Reversal','Scalp','Swing'].map((t)=>FilterChip(label: Text(t), selected: st?.draft.tags.contains(t)??false, onSelected:(_)=>ctl.toggleTag(t))).toList()), const Gap(12),
      AppTextField(label:'Notes',controller:notes,maxLines:3,onChanged:ctl.updateNotes), const Gap(24),
      AppButton(text:'Save Trade',onPressed: st?.isValid==true?()=>ctl.saveTrade():null,isFullWidth:true),
    ])); }
}
