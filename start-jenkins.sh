#!/bin/bash

echo "🚀 Iniciando ambiente Jenkins para Playwright..."

# Verificar se Docker está rodando
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Por favor, inicie o Docker Desktop primeiro."
    exit 1
fi

echo "✅ Docker está rodando"

# Parar containers existentes (se houver)
echo "🛑 Parando containers existentes..."
docker-compose down

# Remover volumes antigos (opcional - descomente se quiser limpar tudo)
# echo "🧹 Removendo volumes antigos..."
# docker-compose down -v

# Construir e iniciar os containers
echo "🔨 Construindo e iniciando containers..."
docker-compose up -d

# Aguardar Jenkins inicializar
echo "⏳ Aguardando Jenkins inicializar..."
sleep 30

# Verificar se Jenkins está rodando
if curl -s http://localhost:8080/login > /dev/null; then
    echo "✅ Jenkins está rodando!"
    echo ""
    echo "🌐 Acesse: http://localhost:8080"
    echo "👤 Usuário: admin"
    echo "🔑 Senha: admin123"
    echo ""
    echo "📋 Próximos passos:"
    echo "1. Acesse o Jenkins no navegador"
    echo "2. Faça login com admin/admin123"
    echo "3. Configure seu repositório Git no job 'playwright-tests'"
    echo "4. Execute o pipeline!"
    echo ""
    echo "📊 Para ver os logs do Jenkins:"
    echo "   docker-compose logs -f jenkins"
    echo ""
    echo "🛑 Para parar o ambiente:"
    echo "   docker-compose down"
else
    echo "❌ Jenkins não está respondendo. Verifique os logs:"
    echo "   docker-compose logs jenkins"
fi
