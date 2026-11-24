#!/bin/bash
# Vigia dos sites Gestão Concreta (cron na Hostinger, a cada 15 min).
# Os domínios gestãoconcreta.com e gestaoconcreta.net são "parked" no farol.pro e só
# funcionam por causa dos blocos "BEGIN GestaoConcreta (" e "BEGIN GestaoConcretaNet"
# no public_html/.htaccess do farol.pro. Se um bloco sumir, ele volta aqui.
# Só acrescenta blocos; não mexe no resto do arquivo.
R="$HOME/domains/farol.pro/public_html"
B="$HOME/backups-gestaoconcreta"

garantir() { # $1 = marcador, $2 = arquivo com o bloco
  [ -f "$2" ] || { echo "$(date '+%F %T') ERRO: $2 sumiu (refazer o git deploy)"; return 1; }
  grep -qF "$1" "$R/.htaccess" 2>/dev/null && return 0
  mkdir -p "$B"
  [ -f "$R/.htaccess" ] && cp -p "$R/.htaccess" "$B/htaccess-farol-$(date +%Y%m%d%H%M%S)"
  { [ -f "$R/.htaccess" ] && cat "$R/.htaccess"; echo; cat "$2"; } > "$R/.htaccess.gc-novo" \
    && chmod 644 "$R/.htaccess.gc-novo" && mv "$R/.htaccess.gc-novo" "$R/.htaccess"
  echo "$(date '+%F %T') bloco \"$1\" colocado no .htaccess do farol.pro"
}

garantir "# BEGIN GestaoConcreta (" "$R/gestaoconcreta-site/deploy/htaccess-raiz.txt"
garantir "# BEGIN GestaoConcretaNet" "$R/gestaoconcreta-net/deploy/htaccess-raiz.txt"
