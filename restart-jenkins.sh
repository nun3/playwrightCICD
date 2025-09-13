#!/bin/bash

echo "🔄 Reiniciando Jenkins com novas configurações..."

# Parar containers existentes
echo "🛑 Parando containers existentes..."
docker-compose down

# Remover containers antigos
echo "🧹 Removendo containers antigos..."
docker-compose rm -f

# Iniciar novamente
echo "🚀 Iniciando Jenkins com configurações atualizadas..."
docker-compose up -d

# Aguardar Jenkins inicializar
echo "⏳ Aguardando Jenkins inicializar..."
sleep 30

# Verificar se Jenkins está rodando
if curl -s http://localhost:8080/login > /dev/null; then
    echo "✅ Jenkins reiniciado com sucesso!"
    echo ""
    echo "🌐 Acesse: http://localhost:8080"
    echo "👤 Usuário: admin"
    echo "🔑 Senha: admin123"
    echo ""
    echo "📋 Agora você pode executar o pipeline novamente!"
else
    echo "❌ Jenkins não está respondendo. Verifique os logs:"
    echo "   docker-compose logs jenkins"
fi
