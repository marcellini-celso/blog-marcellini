#!/bin/bash

set -e  # Interrompe o script se ocorrer erro

# 📅 Data/hora para logs e backups
NOW=$(date +"%Y-%m-%d_%H-%M-%S")

# 📁 Pasta de backups opcionais (cria se não existir)
BACKUP_DIR="backups"
mkdir -p "$BACKUP_DIR"

echo "🕒 [$NOW] Iniciando publicação do Blog do Marcellini..."

# 🔄 Etapa 1: Backup do index.qmd antes de modificar
cp index.qmd "$BACKUP_DIR/index.qmd.backup.$NOW"
echo "📦 Backup de index.qmd salvo em $BACKUP_DIR/index.qmd.backup.$NOW"

# 🔄 Etapa 2: Atualizando lista de últimos posts
./atualizar-ultimos-posts.sh

# 🛠️ Etapa 3: Renderização do site
echo "🛠️ Renderizando com Quarto..."
quarto render

# 📂 Etapa 4: Git add
echo "📦 Adicionando arquivos ao Git..."
git add .

# 📝 Etapa 5: Git commit (com fallback)
echo "📝 Realizando commit..."
git commit -m "Atualiza conteúdo do blog em $NOW" || echo "ℹ️ Nenhuma alteração nova para commit."

# 🔄 Etapa 6: Git pull com rebase
echo "🔄 Fazendo rebase com origin/main..."
git pull --rebase origin main

# ⬆️ Etapa 7: Push para main
echo "⬆️ Enviando para GitHub (main)..."
git push origin main

# 🚀 Etapa 8: Publicação via GitHub Pages
echo "🚀 Publicando com quarto publish gh-pages..."
quarto publish gh-pages

# 📝 Etapa 9: Registro de log
echo "🕒 [$NOW] Blog publicado com sucesso!" >> "$BACKUP_DIR/publicacao.log"

# ✅ Finalização
echo "✅ Blog publicado com sucesso!"
echo "📄 Log registrado em $BACKUP_DIR/publicacao.log"
echo "🌐 Disponível em: https://marcellini-celso.github.io/blog-marcellini/"

