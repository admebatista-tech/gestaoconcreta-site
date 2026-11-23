#!/bin/bash
# Gera o site (site-novo) e copia a versão pronta para esta pasta de publicação.
set -e
cd "$(dirname "$0")/.."
P="$(pwd)"
(cd ../site-novo && npm run build)
rsync -a --delete --exclude .git --exclude deploy --exclude .htaccess --exclude README.md ../site-novo/out/ "$P/"
echo "Pronto. Agora: git add -A && git commit && git push, e o deploy na Hostinger."
