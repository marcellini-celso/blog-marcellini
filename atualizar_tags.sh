#!/bin/bash

# Caminhos
POSTS_DIR="posts"
ARQ_TAGS="tags.qmd"
TMP_TAGS="tags_tmp.txt"
FREQ_FILE="tags_freq.txt"
LISTA_FINAL="lista_tags_gerada.md"
NUVEM_SCRIPT="nuvem_tags.py"
POSTS_JSON_SCRIPT="gerar_posts_json.py"

echo "📁 Atualizando tags do blog..."

# Limpa arquivos anteriores
rm -f "$TMP_TAGS" "$FREQ_FILE" "$LISTA_FINAL"

# Extrair tags dos arquivos .qmd
grep -r "^tags:" "$POSTS_DIR" | while IFS=: read -r file linha; do
  echo "$linha" | sed 's/^tags:\s*\[//; s/\]//; s/, /\n/g' >> "$TMP_TAGS"
done

# Contar e organizar
sort "$TMP_TAGS" | sed 's/^[ \t]*//;s/[ \t]*$//' | grep -v '^$' | uniq -c | sort -k2 > "$FREQ_FILE"

# Gerar lista em Markdown
while read -r count tag; do
  echo "- \`$tag\` (${count} post$(test "$count" -gt 1 && echo "s"))" >> "$LISTA_FINAL"
done < "$FREQ_FILE"

# Inserir lista entre os delimitadores no tags.qmd
awk -v newcontent="$(cat "$LISTA_FINAL")" '
  BEGIN { inside = 0 }
  /<!-- lista_tags:inicio -->/ { print; print newcontent; inside = 1; next }
  /<!-- lista_tags:fim -->/ { inside = 0 }
  !inside { print }
' "$ARQ_TAGS" > tags_temp.qmd && mv tags_temp.qmd "$ARQ_TAGS"

echo "✅ Lista de tags inserida em '$ARQ_TAGS'."

# Gerar imagem da nuvem
if [ -f "$NUVEM_SCRIPT" ]; then
  python3 "$NUVEM_SCRIPT"
  echo "✅ Nuvem de tags atualizada: nuvem_tags.png"

  # Inserir imagem no ponto certo do tags.qmd
  awk -v img="![](nuvem_tags.png)" '
    BEGIN { inside = 0 }
    /<!-- nuvem_tags:inicio -->/ { print; print img; inside = 1; next }
    /<!-- nuvem_tags:fim -->/ { inside = 0 }
    !inside { print }
  ' "$ARQ_TAGS" > tags_temp.qmd && mv tags_temp.qmd "$ARQ_TAGS"
  echo "✅ Imagem da nuvem inserida em '$ARQ_TAGS'."
else
  echo "⚠️ Script '$NUVEM_SCRIPT' não encontrado."
fi

# Gerar posts.json
if [ -f "$POSTS_JSON_SCRIPT" ]; then
  python3 "$POSTS_JSON_SCRIPT"
  echo "✅ Arquivo posts.json gerado."
else
  echo "⚠️ Script '$POSTS_JSON_SCRIPT' não encontrado."
fi

# Renderizar o site
echo "🎯 Renderizando site com Quarto..."
quarto render

echo "🚀 Blog atualizado com sucesso!"

