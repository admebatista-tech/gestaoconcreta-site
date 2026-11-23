#!/bin/bash
# Vigia do site Gestão Concreta (cron na Hostinger, a cada 15 min).
# O domínio gestãoconcreta.com é "parked" no farol.pro e só funciona por causa do
# bloco "BEGIN GestaoConcreta" no public_html/.htaccess do farol.pro. Se esse bloco
# sumir, ele volta aqui. Só acrescenta o bloco; não mexe no resto do arquivo.
R="$HOME/domains/farol.pro/public_html"
A="$R/gestaoconcreta-site"
B="$HOME/backups-gestaoconcreta"
[ -f "$A/deploy/htaccess-raiz.txt" ] || { echo "$(date '+%F %T') ERRO: $A sumiu (refazer o git deploy)"; exit 1; }
grep -q "BEGIN GestaoConcreta" "$R/.htaccess" 2>/dev/null && exit 0
mkdir -p "$B"
[ -f "$R/.htaccess" ] && cp -p "$R/.htaccess" "$B/htaccess-farol-$(date +%Y%m%d%H%M%S)"
{ [ -f "$R/.htaccess" ] && cat "$R/.htaccess"; echo; cat "$A/deploy/htaccess-raiz.txt"; } > "$R/.htaccess.gc-novo" \
  && chmod 644 "$R/.htaccess.gc-novo" && mv "$R/.htaccess.gc-novo" "$R/.htaccess"
echo "$(date '+%F %T') regra Gestão Concreta colocada no .htaccess do farol.pro"
