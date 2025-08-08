import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _ChargebeeDemoLints();

class _ChargebeeDemoLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        _NoDebugPrintRule(),
      ];
}

class _NoDebugPrintRule extends DartLintRule {
  _NoDebugPrintRule() : super(code: _code);

  static const _code = LintCode(
    name: 'no_debug_print',
    problemMessage: 'Use Log.d (our logger wrapper) instead of debugPrint.',
    correctionMessage: 'Import package:chargebee_demo/core/logging/logger.dart and call Log.d()',
  );

  @override
  void registerNodeProcessors(NodeRegistry registry, LintRuleContext context) {
    registry.addMethodInvocation(this, (node) {
      final target = node.target;
      final name = node.methodName.name;
      if (target == null && name == 'debugPrint') {
        context.reportErrorForNode(_code, node.methodName);
      }
    });
  }
}
