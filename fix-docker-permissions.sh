#!/bin/bash

echo "🔧 Corrigindo permissões do Docker..."

# Parar Jenkins
echo "🛑 Parando Jenkins..."
docker-compose down

# Corrigir permissões do socket Docker
echo "🔐 Corrigindo permissões do socket Docker..."
sudo chmod 666 /var/run/docker.sock

# Reiniciar Jenkins
echo "🚀 Reiniciando Jenkins..."
docker-compose up -d

# Aguardar inicialização
echo "⏳ Aguardando Jenkins inicializar..."
sleep 30

# Verificar se está funcionando
if curl -s http://localhost:8080/login > /dev/null; then
    echo "✅ Jenkins reiniciado com sucesso!"
    echo "🔧 Permissões do Docker corrigidas!"
    echo ""
    echo "🌐 Acesse: http://localhost:8080"
    echo "🎯 Teste o pipeline novamente!"
else
    echo "❌ Jenkins não está respondendo. Verifique os logs:"
    echo "   docker-compose logs"
fi
