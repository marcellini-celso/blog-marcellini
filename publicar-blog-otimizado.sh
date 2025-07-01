#!/bin/bash

# Função para exibir mensagens com timestamp
log() {
  echo "[`date +"%Y-%m-%d %H:%M:%S"`] $1"
}

log "Iniciando publicação do blog..."

# Verifica se o Quarto está instalado
if ! command -v quarto &> /dev/null; then
  log "❌ Erro: o Quarto não está instalado ou não está no PATH."
  exit 1
fi

# Renderiza o site diretamente em docs/
log "Renderizando o site (saida: docs/)..."
if ! quarto render; then
  log "❌ Falha ao renderizar o site."
  exit 1
fi

# Verifica se há mudanças
if git diff --quiet && git diff --cached --quiet; then
  log "Nenhuma mudança detectada. Nada para publicar."
  exit 0
fi

# Adiciona apenas os arquivos relevantes
log "Adicionando arquivos relevantes ao Git..."
git add docs _quarto.yml

# Adiciona arquivos .qmd, .md, .ipynb se existirem
shopt -s nullglob
arquivos=( *.qmd *.md *.ipynb )
if [ ${#arquivos[@]} -gt 0 ]; then
  git add "${arquivos[@]}" || {
    log "❌ Erro ao adicionar arquivos de conteúdo ao Git."
    exit 1
  }
fi

# Solicita mensagem de commit
read -p "Digite a mensagem de commit: " mensagem
git commit -m "$mensagem" || {
  log "❌ Erro ao realizar o commit. Verifique se há mudanças reais."
  exit 1
}

# Push
log "Enviando alterações para a branch main..."
if ! git push origin main; then
  log "❌ Erro ao enviar as alterações para o repositório remoto."
  exit 1
fi

log "✅ Publicação concluída com sucesso na branch 'main' (pasta /docs)."
