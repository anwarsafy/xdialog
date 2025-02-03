import 'package:flutter/material.dart';

/// A highly customizable animated dialog package for Flutter applications.
///
/// Features include:
/// - Custom animations (scale & fade)
/// - Multiple button configurations
/// - Theming support
/// - Custom icons
/// - Flexible layout options
///
/// ```dart
/// XDialog.show(
///   context: context,
///   title: 'Confirmation',
///   message: 'Are you sure?',
/// );
/// ```
class XDialog {
  /// Shows a customizable dialog
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    Widget? icon,
    bool showCloseIcon = true,
    String? positiveButtonText,
    String? negativeButtonText,
    String? neutralButtonText,
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
    VoidCallback? onNeutralPressed,
    VoidCallback? onClose,
    Color? backgroundColor,
    Color? textColor,
    Color? positiveButtonColor,
    Color? negativeButtonColor,
    Color? neutralButtonColor,
    Duration transitionDuration = const Duration(milliseconds: 400),
    Curve transitionCurve = Curves.easeOut,
    bool useScaleAnimation = true,
    bool useFadeAnimation = true,
    double dialogWidth = 400,
    double iconSize = 70,
    double titleFontSize = 24,
    double messageFontSize = 16,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: transitionDuration,
      pageBuilder: (_, __, ___) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final theme = Theme.of(context);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: transitionCurve,
        );

        double scale = 1;
        double opacity = 1;

        if (useScaleAnimation) {
          scale = Tween<double>(begin: 0.8, end: 1.0).evaluate(curvedAnimation);
        }
        if (useFadeAnimation) {
          opacity = Tween<double>(begin: 0.0, end: 1.0).evaluate(curvedAnimation);
        }

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: _XDialogContent(
                title: title,
                message: message,
                icon: icon,
                showCloseIcon: showCloseIcon,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                neutralButtonText: neutralButtonText,
                onPositivePressed: onPositivePressed,
                onNegativePressed: onNegativePressed,
                onNeutralPressed: onNeutralPressed,
                onClose: onClose,
                backgroundColor: backgroundColor ?? theme.dialogBackgroundColor,
                textColor: textColor ?? theme.textTheme.bodyLarge?.color,
                positiveButtonColor: positiveButtonColor ?? theme.primaryColor,
                negativeButtonColor: negativeButtonColor ?? Colors.grey,
                neutralButtonColor: neutralButtonColor ?? Colors.blueGrey,
                dialogWidth: dialogWidth,
                iconSize: iconSize,
                titleFontSize: titleFontSize,
                messageFontSize: messageFontSize,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _XDialogContent extends StatelessWidget {
  final String title;
  final String message;
  final Widget? icon;
  final bool showCloseIcon;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final String? neutralButtonText;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;
  final VoidCallback? onNeutralPressed;
  final VoidCallback? onClose;
  final Color backgroundColor;
  final Color? textColor;
  final Color positiveButtonColor;
  final Color negativeButtonColor;
  final Color neutralButtonColor;
  final double dialogWidth;
  final double iconSize;
  final double titleFontSize;
  final double messageFontSize;

  const _XDialogContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.showCloseIcon,
    required this.positiveButtonText,
    required this.negativeButtonText,
    required this.neutralButtonText,
    required this.onPositivePressed,
    required this.onNegativePressed,
    required this.onNeutralPressed,
    required this.onClose,
    required this.backgroundColor,
    required this.textColor,
    required this.positiveButtonColor,
    required this.negativeButtonColor,
    required this.neutralButtonColor,
    required this.dialogWidth,
    required this.iconSize,
    required this.titleFontSize,
    required this.messageFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final hasActions = positiveButtonText != null ||
        negativeButtonText != null ||
        neutralButtonText != null;

    return Container(
      width: dialogWidth,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showCloseIcon)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: textColor?.withValues(alpha: 0.6)),
                onPressed: onClose ?? () => Navigator.pop(context),
              ),
            ),
          _buildIcon(context),
          const SizedBox(height: 16),
          _buildTitle(context),
          const SizedBox(height: 16),
          _buildMessage(context),
          if (hasActions) const SizedBox(height: 24),
          if (hasActions) _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return icon ??
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: positiveButtonColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.info_outline,
            size: iconSize * 0.5,
            color: positiveButtonColor,
          ),
        );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: titleFontSize,
        fontWeight: FontWeight.bold,
        color: textColor,
        height: 1.3,
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: messageFontSize,
        color: textColor?.withValues(alpha: 0.8),
        height: 1.5,
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        if (neutralButtonText != null)
          Expanded(
            child: _DialogButton(
              text: neutralButtonText!,
              color: neutralButtonColor,
              onPressed: onNeutralPressed ?? () => Navigator.pop(context),
            ),
          ),
        if (neutralButtonText != null) const SizedBox(width: 12),
        if (negativeButtonText != null)
          Expanded(
            child: _DialogButton(
              text: negativeButtonText!,
              color: negativeButtonColor,
              onPressed: onNegativePressed ?? () => Navigator.pop(context),
            ),
          ),
        if (negativeButtonText != null) const SizedBox(width: 12),
        if (positiveButtonText != null)
          Expanded(
            child: _DialogButton(
              text: positiveButtonText!,
              color: positiveButtonColor,
              onPressed: onPositivePressed ?? () => Navigator.pop(context),
            ),
          ),
      ],
    );
  }
}

class _DialogButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const _DialogButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  State<_DialogButton> createState() => _DialogButtonState();
}

class _DialogButtonState extends State<_DialogButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered ? widget.color.withValues(alpha: 0.9) : widget.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: widget.onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}