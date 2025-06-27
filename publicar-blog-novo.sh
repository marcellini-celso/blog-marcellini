#!/bin/bash

echo "🔄 Atualizando conteúdo local do blog..."
./atualizar_tags.sh

echo ""
echo "🚀 Publicando no GitHub Pages..."
quarto publish gh-pages

echo ""
echo "☁️ Publicação no S3 (manual)"
echo "📂 A pasta 'docs/' foi atualizada com sucesso."
echo "ℹ️ Acesse o painel da AWS e envie os arquivos da pasta 'docs/' para o bucket S3 configurado."

echo ""
echo "✅ Processo finalizado!"

