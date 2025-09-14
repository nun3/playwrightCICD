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

# Aguardar Nexus inicializar
echo "⏳ Aguardando Nexus inicializar..."
sleep 30

# Verificar se Jenkins está rodando
if curl -s http://localhost:8080/login > /dev/null; then
    echo "✅ Jenkins está rodando!"
    echo ""
    echo "🌐 Jenkins: http://localhost:8080"
    echo "🌐 Nexus: http://localhost:8081"
    echo ""
    echo "🔑 Para obter a senha inicial do Jenkins, execute:"
    echo "   docker-compose logs jenkins"
    echo ""
    echo "🔑 Para obter a senha inicial do Nexus, execute:"
    echo "   docker-compose logs nexus | grep 'admin.password'"
    echo ""
    echo "📋 Próximos passos:"
    echo "1. Acesse o Jenkins: http://localhost:8080"
    echo "2. Acesse o Nexus: http://localhost:8081"
    echo "3. Configure ambos com as senhas dos logs"
    echo "4. Configure o Nexus como repositório de artefatos"
    echo "5. Execute o pipeline no Jenkins"
    echo ""
    echo "🛑 Para parar tudo:"
    echo "   docker-compose down"
else
    echo "❌ Jenkins não está respondendo. Verifique os logs:"
    echo "   docker-compose logs"
fi
