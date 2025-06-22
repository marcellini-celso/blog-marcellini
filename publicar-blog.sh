#!/bin/bash

# Script para publicar o Blog do Marcellini no GitHub Pages usando Quarto

# 1. Exibe a etapa atual
echo "🛠️  Etapa 1: Renderizando o site com Quarto..."
quarto render

# 2. Confere se a renderização foi bem-sucedida
if [ $? -ne 0 ]; then
  echo "❌ Erro ao renderizar com Quarto. Abortando."
  exit 1
fi

# 3. Confirma se o diretório .git existe
if [ ! -d .git ]; then
  echo "❌ Este diretório não é um repositório Git. Execute 'git init' e configure o Git antes."
  exit 1
fi

# 4. Adiciona todos os arquivos (inclusive docs/)
echo "📦  Etapa 2: Adicionando arquivos ao Git..."
git add .

# 5. Cria um commit automático
echo "📝  Etapa 3: Criando commit..."
git commit -m "Atualiza conteúdo do blog com nova renderização"

# 6. Publica no GitHub Pages
echo "🚀  Etapa 4: Publicando com Quarto..."
quarto publish gh-pages

# 7. Envia atualizações para a branch main
echo "⬆️  Etapa 5: git push origin main"
git push origin main

# 8. Fim
echo "✅ Blog publicado com sucesso!"
