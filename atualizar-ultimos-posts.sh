#!/bin/bash

# Número de posts mais recentes a listar
NUM_POSTS=5

# Gera a lista de links com título e caminho relativo
LISTA=$(find posts -name '*.qmd' -type f -printf '%T@ %p\n' | sort -nr | head -n "$NUM_POSTS" | cut -d' ' -f2- | while read -r FILE; do
	TITLE=$(grep -m 1 '^# ' "$FILE" | sed 's/^# //')
    LINK=${FILE%.qmd}.html
    echo "- [$TITLE]($LINK)"
done)

# Substitui a seção marcada no index.qmd
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

echo "✅ Últimos posts atualizados com sucesso no index.qmd"

