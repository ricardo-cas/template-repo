#!/bin/bash
# .github/scripts/verify_merge_back.sh
set -e
TARGET_BRANCH="${TARGET_BRANCH:-main}"
SOURCE_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "--- Verificando o Merge Back ---"
echo "Branch de Destino: ${TARGET_BRANCH}"
echo "Branch de Origem:  ${SOURCE_BRANCH}"
echo "--------------------------------"
git fetch origin
LATEST_TARGET_COMMIT=$(git rev-parse "origin/${TARGET_BRANCH}")
if [ -z "$LATEST_TARGET_COMMIT" ]; then
    echo "Erro: Não foi possível encontrar o último commit da branch '${TARGET_BRANCH}'."
    exit 1
fi
echo "O último commit na '${TARGET_BRANCH}' é: ${LATEST_TARGET_COMMIT}"
if git merge-base --is-ancestor "${LATEST_TARGET_COMMIT}" HEAD; then
    echo "✅ Sucesso: A branch de origem contém o último commit da '${TARGET_BRANCH}'."
    exit 0
else
    echo "❌ Erro: A branch de origem não está atualizada com a '${TARGET_BRANCH}'."
    echo "Por favor, faça 'merge' ou 'rebase' da '${TARGET_BRANCH}' na sua branch antes de continuar."
    exit 1
fi
