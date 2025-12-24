import 'package:flutter/material.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';
import 'package:mg_common_game/core/ui/layout/mg_spacing.dart';
import 'package:mg_common_game/core/ui/typography/mg_text_styles.dart';
import 'package:mg_common_game/core/ui/widgets/buttons/mg_icon_button.dart';
import 'package:mg_common_game/core/ui/widgets/progress/mg_linear_progress.dart';
import 'package:mg_common_game/core/ui/widgets/indicators/mg_resource_bar.dart';

/// MG-0020 Time Slip Dungeon HUD
/// 시간 역행 던전 게임용 HUD - HP, 타임슬립 게이지, 던전 층수, 아이템 표시
class MGTimeSlipHud extends StatelessWidget {
  final int playerHp;
  final int playerMaxHp;
  final int gold;
  final int timeSlipCharges;
  final int maxTimeSlipCharges;
  final int currentFloor;
  final int maxFloor;
  final String? currentRoomType;
  final VoidCallback? onPause;
  final VoidCallback? onTimeSlip;
  final VoidCallback? onInventory;

  const MGTimeSlipHud({
    super.key,
    required this.playerHp,
    required this.playerMaxHp,
    required this.gold,
    required this.timeSlipCharges,
    required this.maxTimeSlipCharges,
    required this.currentFloor,
    required this.maxFloor,
    this.currentRoomType,
    this.onPause,
    this.onTimeSlip,
    this.onInventory,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(MGSpacing.sm),
        child: Column(
          children: [
            // 상단 HUD
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 왼쪽: HP 바
                Expanded(flex: 2, child: _buildHpBar()),
                const SizedBox(width: MGSpacing.sm),
                // 중앙: 층수
                _buildFloorInfo(),
                const SizedBox(width: MGSpacing.sm),
                // 오른쪽: 버튼들
                _buildActionButtons(),
              ],
            ),
            const SizedBox(height: MGSpacing.xs),
            // 골드 & 타임슬립 게이지
            Row(
              children: [
                // 골드
                MGResourceBar(
                  resources: [
                    ResourceItem(
                      icon: Icons.monetization_on,
                      value: gold,
                      color: MGColors.resourceGold,
                    ),
                  ],
                ),
                const Spacer(),
                // 타임슬립 게이지
                _buildTimeSlipGauge(),
              ],
            ),
            const Spacer(),
            // 하단: 타임슬립 버튼
            if (onTimeSlip != null && timeSlipCharges > 0)
              _buildTimeSlipButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHpBar() {
    final double hpRatio = playerMaxHp > 0 ? playerHp / playerMaxHp : 0;

    return Container(
      padding: const EdgeInsets.all(MGSpacing.xs),
      decoration: BoxDecoration(
        color: MGColors.surface.withOpacity(0.85),
        borderRadius: BorderRadius.circular(MGSpacing.sm),
        border: Border.all(color: MGColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.red, size: 18),
          const SizedBox(width: MGSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MGLinearProgress(
                  value: hpRatio,
                  height: 12,
                  backgroundColor: Colors.red.withOpacity(0.2),
                  progressColor: hpRatio > 0.3 ? Colors.red : Colors.orange,
                ),
                const SizedBox(height: MGSpacing.xxs),
                Text(
                  '$playerHp / $playerMaxHp',
                  style: MGTextStyles.caption.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloorInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MGSpacing.md,
        vertical: MGSpacing.xs,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.withOpacity(0.8),
            Colors.purple.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(MGSpacing.sm),
        border: Border.all(color: Colors.purpleAccent),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Floor $currentFloor',
            style: MGTextStyles.buttonMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (currentRoomType != null)
            Text(
              currentRoomType!,
              style: MGTextStyles.caption.copyWith(
                color: Colors.white70,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onInventory != null)
          MGIconButton(
            icon: Icons.inventory_2,
            onPressed: onInventory!,
            size: MGIconButtonSize.small,
          ),
        if (onPause != null)
          MGIconButton(
            icon: Icons.pause,
            onPressed: onPause!,
            size: MGIconButtonSize.small,
          ),
      ],
    );
  }

  Widget _buildTimeSlipGauge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MGSpacing.sm,
        vertical: MGSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.cyan.withOpacity(0.2),
        borderRadius: BorderRadius.circular(MGSpacing.xs),
        border: Border.all(color: Colors.cyan.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.history, color: Colors.cyan, size: 16),
          const SizedBox(width: MGSpacing.xs),
          ...List.generate(maxTimeSlipCharges, (index) {
            final bool isFilled = index < timeSlipCharges;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                isFilled ? Icons.hourglass_full : Icons.hourglass_empty,
                color: isFilled ? Colors.cyan : Colors.grey,
                size: 18,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimeSlipButton() {
    return GestureDetector(
      onTap: onTimeSlip,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MGSpacing.xl,
          vertical: MGSpacing.md,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.cyan,
              Colors.blue,
            ],
          ),
          borderRadius: BorderRadius.circular(MGSpacing.md),
          border: Border.all(color: Colors.white24, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withOpacity(0.5),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.history, color: Colors.white, size: 24),
            const SizedBox(width: MGSpacing.sm),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'TIME SLIP',
                  style: MGTextStyles.buttonMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rewind to safety',
                  style: MGTextStyles.caption.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
