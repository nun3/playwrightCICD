#!/bin/bash

echo "🔑 Obtendo senha inicial do Jenkins..."

# Verificar se o container está rodando
if ! docker ps | grep -q jenkins; then
    echo "❌ Container Jenkins não está rodando."
    echo "Execute: ./start-jenkins.sh"
    exit 1
fi

# Obter a senha dos logs
echo "📋 Senha inicial do Jenkins:"
echo "----------------------------------------"
docker-compose logs | grep -A 1 "Jenkins initial setup is required" | tail -1
echo "----------------------------------------"
echo ""
echo "🌐 Acesse: http://localhost:8080"
echo "👤 Usuário: admin"
echo "🔑 Cole a senha acima"
