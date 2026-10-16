import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

/// Crédito "Feito por Marcos H. Silva" com link para o site do autor.
///
/// Usa o [Link] do url_launcher: na web ele vira um `<a href>` de verdade no HTML
/// (e não só um texto desenhado no canvas), então buscadores e leitores de tela
/// reconhecem o link. Coloque no rodapé ou no "Sobre" dos apps.
///
/// ```dart
/// const TebAuthorCredit(projectPath: '/projetos/planning-poker-web-app/')
/// ```
class TebAuthorCredit extends StatelessWidget {
  static const defaultSiteUrl = 'https://www.marcosmhs.com.br';

  /// Texto antes do nome.
  final String prefix;
  final String authorName;
  final String siteUrl;

  /// Caminho da página do projeto no site (ex.: '/projetos/meu-app/'); vazio aponta para a home.
  final String projectPath;
  final TextStyle? style;
  final Color? linkColor;

  const TebAuthorCredit({
    super.key,
    this.prefix = 'Feito por ',
    this.authorName = 'Marcos H. Silva',
    this.siteUrl = defaultSiteUrl,
    this.projectPath = '',
    this.style,
    this.linkColor,
  });

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.bodySmall ?? const TextStyle(fontSize: 12);
    final color = linkColor ?? Theme.of(context).colorScheme.primary;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prefix, style: base),
        Link(
          uri: Uri.parse('$siteUrl${projectPath.isEmpty ? '/' : projectPath}'),
          target: LinkTarget.blank,
          builder: (context, followLink) => InkWell(
            onTap: followLink,
            child: Text(
              authorName,
              style: base.copyWith(color: color, decoration: TextDecoration.underline, decorationColor: color),
            ),
          ),
        ),
      ],
    );
  }
}
