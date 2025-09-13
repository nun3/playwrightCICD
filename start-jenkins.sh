#!/bin/bash

echo "🚀 Iniciando Jenkins..."

# Verificar se Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Por favor, inicie o Docker Desktop primeiro."
    exit 1
fi

echo "✅ Docker está rodando"

# Parar containers existentes (se houver)
echo "🛑 Parando containers existentes..."
docker-compose down

# Iniciar o container
echo "🔨 Iniciando Jenkins..."
docker-compose up -d

# Aguardar Jenkins inicializar
echo "⏳ Aguardando Jenkins inicializar..."
sleep 30

# Verificar se Jenkins está rodando
if curl -s http://localhost:8080/login > /dev/null; then
    echo "✅ Jenkins está rodando!"
    echo ""
    echo "🌐 Acesse: http://localhost:8080"
    echo ""
    echo "🔑 Para obter a senha inicial, execute:"
    echo "   docker-compose logs"
    echo ""
    echo "📋 Próximos passos:"
    echo "1. Acesse o Jenkins no navegador"
    echo "2. Cole a senha inicial dos logs"
    echo "3. Configure seu usuário admin"
    echo "4. Crie um novo job Pipeline"
    echo "5. Use o Jenkinsfile do repositório"
    echo ""
    echo "🛑 Para parar o Jenkins:"
    echo "   docker-compose down"
else
    echo "❌ Jenkins não está respondendo. Verifique os logs:"
    echo "   docker-compose logs"
fi
