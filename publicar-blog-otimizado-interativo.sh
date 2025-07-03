#!/bin/bash

# Verifica se há alterações não commitadas
if ! git diff-index --quiet HEAD --; then
  echo "⚠️  Você tem alterações não commitadas."
  echo "Escolha uma opção:"
  echo "[1] Fazer commit das alterações"
  echo "[2] Fazer stash das alterações temporariamente"
  echo "[3] Descartar as alterações (reset)"
  echo "[4] Cancelar"

  read -p "Digite o número da opção desejada: " escolha

  case "$escolha" in
    1)
      echo "📦 Preparando commit..."
      git add .
      read -p "Digite a mensagem do commit: " msg
      git commit -m "$msg"
      ;;
    2)
      echo "📦 Fazendo stash das alterações..."
      git stash
      ;;
    3)
      echo "⚠️ Descartando alterações..."
      git reset --hard
      ;;
    4)
      echo "❌ Cancelado pelo usuário."
      exit 1
      ;;
    *)
      echo "❌ Opção inválida. Cancelando."
      exit 1
      ;;
  esac
fi

# Aqui continua o restante do seu script
# Exemplo de mensagem:
echo "🚀 Continuando com a publicação do blog..."
