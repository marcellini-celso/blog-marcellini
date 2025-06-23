#!/bin/bash

# Número de posts mais recentes a listar
NUM_POSTS=5

# Gera lista de posts com base na data do YAML (com ou sem hora)
LISTA=$(find posts -name '*.qmd' -type f | while read -r FILE; do
    # Extrai a linha do campo date: e remove "date:" mantendo a hora se existir
    RAW_DATE=$(grep '^date:' "$FILE" | head -n1 | sed 's/^date:[[:space:]]*//')
    # Se RAW_DATE estiver vazio, pula o arquivo
    [ -z "$RAW_DATE" ] && continue

    # Converte para timestamp para ordenação robusta
    TS=$(date -d "$RAW_DATE" +%s 2>/dev/null)
    [ -z "$TS" ] && continue

    echo "$TS|$RAW_DATE|$FILE"
done | sort -t '|' -k1,1nr | head -n "$NUM_POSTS" | while IFS='|' read -r TS RAW_DATE FILE; do
    # Tenta obter o título com markdown visível
    TITLE=$(grep -m 1 '^# ' "$FILE" | sed 's/^# //')
    [ -z "$TITLE" ] && TITLE="(sem título)"
    LINK=${FILE%.qmd}.html
    echo "- [$TITLE]($LINK)"
done)

# Atualiza o trecho no index.qmd
awk -v new="$LISTA" '
  /<!-- inicio-ultimos-posts -->/ {
    print
    print new
    in_block=1
    next
  }
  /<!-- fim-ultimos-posts -->/ { in_block=0 }
  !in_block
' index.qmd > index_temp.qmd && mv index_temp.qmd index.qmd

echo "✅ Últimos posts atualizados com sucesso com base no campo 'date:' do YAML."

