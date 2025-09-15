#!/bin/bash

echo "🧪 Testando upload para Nexus..."

# Configurações
NEXUS_URL="http://localhost:8081"
NEXUS_USER="jenkins"
NEXUS_PASS="jenkins123"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Criar arquivo de teste
echo "Teste de upload - $(date)" > test-file.txt

# Fazer upload para playwright-evidence
echo "📤 Upload para playwright-evidence..."
curl -u ${NEXUS_USER}:${NEXUS_PASS} \
     --upload-file test-file.txt \
     ${NEXUS_URL}/repository/playwright-evidence/test-${TIMESTAMP}.txt

if [ $? -eq 0 ]; then
    echo "✅ Upload para playwright-evidence: SUCESSO"
    echo "🔗 URL: ${NEXUS_URL}/repository/playwright-evidence/test-${TIMESTAMP}.txt"
else
    echo "❌ Upload para playwright-evidence: FALHOU"
fi

# Fazer upload para playwright-reports
echo "📤 Upload para playwright-reports..."
curl -u ${NEXUS_USER}:${NEXUS_PASS} \
     --upload-file test-file.txt \
     ${NEXUS_URL}/repository/playwright-reports/test-${TIMESTAMP}.txt

if [ $? -eq 0 ]; then
    echo "✅ Upload para playwright-reports: SUCESSO"
    echo "🔗 URL: ${NEXUS_URL}/repository/playwright-reports/test-${TIMESTAMP}.txt"
else
    echo "❌ Upload para playwright-reports: FALHOU"
fi

# Limpar arquivo de teste
rm test-file.txt

echo "🎉 Teste concluído!"
