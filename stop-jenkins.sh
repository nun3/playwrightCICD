#!/bin/bash

echo "🛑 Parando Jenkins..."

# Parar e remover containers
docker-compose down

echo "✅ Jenkins parado com sucesso!"
echo ""
echo "💾 Dados do Jenkins foram preservados no volume 'jenkins_home'"
echo ""
echo "🚀 Para iniciar novamente:"
echo "   ./start-jenkins.sh"
