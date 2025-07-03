#!/bin/bash

# Verificar se há alterações não commitadas
#if [[ -n $(git status --porcelain) ]]; then
#  echo "⚠️ Você tem alterações não commitadas."
#  echo "💡 Faça commit, stash ou descarte antes de continuar."
#  exit 1
#fi

# Atualizar a branch local com rebase antes de qualquer push
#echo "📥 Executando git pull --rebase para sincronizar com o repositório remoto..."
#git pull origin main --rebase || { echo "❌ Erro ao executar git pull --rebase."; exit 1; }


# Função de log com timestamp
log() {
  echo "[`date +"%Y-%m-%d %H:%M:%S"`] $1"
}

log "🔄 Atualizando últimos posts..."
bash atualizar-ultimos-posts.sh || { echo "❌ Falha ao atualizar últimos posts."; exit 1; }

log "📦 Gerando arquivo posts.json..."
python3 gerar_posts_json.py || { echo "❌ Falha ao gerar posts.json."; exit 1; }

log "🏷️ Atualizando tags..."
bash atualizar_tags.sh || { echo "❌ Falha ao atualizar tags."; exit 1; }

# python verificar_integridade.py || { echo "❌ Falha na verificação de integridade."; exit 1; }
log "✅ Atualização completa!"
