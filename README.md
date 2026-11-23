# Gestão Concreta — site publicado

Versão pronta (estática) do site em `../site-novo`, publicada em https://gestãoconcreta.com.

Atualizar: `deploy/publicar.sh`, depois commit, push e o deploy Git na Hostinger (farol.pro, pasta `gestaoconcreta-site`).
O domínio é *parked* no farol.pro; `deploy/htaccess-raiz.txt` é a regra que manda o domínio para esta pasta e `deploy/vigia.sh` (cron) recoloca a regra se ela sumir.
