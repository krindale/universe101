import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Interactive 3D planet viewer widget
///
/// Displays 3D models of planets with touch controls for rotation and zoom.
/// Supports loading indicators and error handling.
class Planet3DViewer extends StatefulWidget {
  /// URL of the 3D model (GLB or GLTF format)
  final String modelUrl;

  /// Name of the planet (for display and accessibility)
  final String planetName;

  /// Optional background color (defaults to transparent)
  final Color? backgroundColor;

  /// Height of the viewer widget
  final double height;

  /// Whether to show loading indicator
  final bool showLoading;

  /// Whether to auto-rotate the model
  final bool autoRotate;

  /// Camera controls mode
  final bool cameraControls;

  const Planet3DViewer({
    super.key,
    required this.modelUrl,
    required this.planetName,
    this.backgroundColor,
    this.height = 400,
    this.showLoading = true,
    this.autoRotate = true,
    this.cameraControls = true,
  });

  @override
  State<Planet3DViewer> createState() => _Planet3DViewerState();
}

class _Planet3DViewerState extends State<Planet3DViewer> {
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        child: Stack(
          children: [
            // 3D Model Viewer
            _build3DViewer(),

            // Loading Indicator
            if (_isLoading && widget.showLoading) _buildLoadingIndicator(),

            // Error State
            if (_hasError) _buildErrorState(),

            // Info Overlay
            _buildInfoOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _build3DViewer() {
    return ModelViewer(
      src: widget.modelUrl,
      alt: '${widget.planetName} 3D model',
      autoRotate: widget.autoRotate,
      cameraControls: widget.cameraControls,
      backgroundColor: widget.backgroundColor ?? AppColors.deepSpace,
      loading: Loading.eager,
      cameraOrbit: '0deg 75deg 2.5m',
      minCameraOrbit: 'auto auto 1m',
      maxCameraOrbit: 'auto auto 10m',
      interpolationDecay: 200,
      onWebViewCreated: (_) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: AppColors.deepSpace.withValues(alpha: 0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.nebulaPurple),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '3D 모델 로딩 중...',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      color: AppColors.deepSpace.withValues(alpha: 0.9),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingLG),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.solarOrange,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '3D 모델을 불러올 수 없습니다',
                style: AppTypography.titleMedium,
                textAlign: TextAlign.center,
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _errorMessage!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _isLoading = true;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('다시 시도'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.nebulaPurple,
                  foregroundColor: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoOverlay() {
    return Positioned(
      top: AppSpacing.md,
      left: AppSpacing.md,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMD,
          vertical: AppSpacing.paddingSM,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.deepSpace.withValues(alpha: 0.8),
              AppColors.deepSpace.withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          border: Border.all(
            color: AppColors.nebulaPurple.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.threed_rotation,
              size: 20,
              color: AppColors.stardustGold,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              widget.planetName,
              style: AppTypography.titleSmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple 3D planet viewer without extra controls
class SimplePlanet3DViewer extends StatelessWidget {
  final String modelUrl;
  final double size;

  const SimplePlanet3DViewer({
    super.key,
    required this.modelUrl,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ModelViewer(
        src: modelUrl,
        autoRotate: true,
        cameraControls: false,
        backgroundColor: Colors.transparent,
        loading: Loading.eager,
        cameraOrbit: '0deg 75deg 2m',
      ),
    );
  }
}
