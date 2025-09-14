#!/bin/bash

echo "🔑 Obtendo senha inicial do Nexus..."

# Verificar se o container está rodando
if ! docker ps | grep -q nexus; then
    echo "❌ Container Nexus não está rodando."
    echo "Execute: ./start-jenkins.sh"
    exit 1
fi

# Obter a senha dos logs
echo "📋 Senha inicial do Nexus:"
echo "----------------------------------------"
docker-compose logs nexus | grep 'admin.password' | tail -1
echo "----------------------------------------"
echo ""
echo "🌐 Acesse: http://localhost:8081"
echo "👤 Usuário: admin"
echo "🔑 Cole a senha acima"
echo ""
echo "📋 Após o login, você pode:"
echo "1. Criar repositórios para artefatos"
echo "2. Configurar o Jenkins para usar o Nexus"
echo "3. Fazer upload de relatórios e artefatos"
