import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:miscelaneos/presentation/widgets/shared/gradient_card.dart';

// Barra centrada en cero que muestra el valor de un eje
class AxisMeter extends StatelessWidget {
  final String label;
  final double value;
  final double range; // Valor que llena media barra
  final Color color;
  final String unit;

  const AxisMeter({
    super.key,
    required this.label,
    required this.value,
    required this.range,
    required this.color,
    this.unit = '',
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final factor = (value.abs() / range).clamp(0.0, 1.0);
    final bar = AnimatedFractionallySizedBox(
      duration: const Duration(milliseconds: 120),
      widthFactor: factor,
      child: Container(
        height: 14,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(label,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Container(
              height: 14,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: value < 0 ? bar : null)),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: value >= 0 ? bar : null)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 84,
            child: Text(
              '${value.toStringAsFixed(2)} $unit',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

// Panel genérico para sensores de 3 ejes (X, Y, Z)
class SensorPanel extends StatefulWidget {
  final IconData icon;
  final String description;
  final double x, y, z;
  final double range;
  final String unit;

  const SensorPanel({
    super.key,
    required this.icon,
    required this.description,
    required this.x,
    required this.y,
    required this.z,
    required this.range,
    required this.unit,
  });

  @override
  State<SensorPanel> createState() => _SensorPanelState();
}

class _SensorPanelState extends State<SensorPanel> {
  double _max = 0; // Mayor magnitud registrada
  bool _paused = false;
  late double _x = widget.x, _y = widget.y, _z = widget.z;

  double get _magnitude => math.sqrt(_x * _x + _y * _y + _z * _z);

  @override
  void didUpdateWidget(SensorPanel old) {
    super.didUpdateWidget(old);
    if (_paused) return; // Congela la lectura
    _x = widget.x;
    _y = widget.y;
    _z = widget.z;
    if (_magnitude > _max) _max = _magnitude;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        GradientCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(widget.icon, size: 40, color: Colors.white70),
              const SizedBox(height: 8),
              Text(
                _magnitude.toStringAsFixed(2),
                style: text.displaySmall?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
              Text('${widget.unit} · magnitud total',
                  style: text.bodySmall?.copyWith(color: Colors.white70)),
              const SizedBox(height: 12),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: text.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              AxisMeter(label: 'X', value: _x, range: widget.range, color: Colors.redAccent, unit: widget.unit),
              AxisMeter(label: 'Y', value: _y, range: widget.range, color: Colors.green, unit: widget.unit),
              AxisMeter(label: 'Z', value: _z, range: widget.range, color: Colors.blueAccent, unit: widget.unit),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Máximo registrado',
                        style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                    Text('${_max.toStringAsFixed(2)} ${widget.unit}',
                        style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filledTonal(
              tooltip: 'Reiniciar máximo',
              onPressed: () => setState(() => _max = 0),
              icon: const Icon(Icons.restart_alt_rounded),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              tooltip: _paused ? 'Reanudar' : 'Pausar',
              onPressed: () => setState(() => _paused = !_paused),
              icon: Icon(_paused ? Icons.play_arrow_rounded : Icons.pause_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
