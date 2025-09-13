#!/bin/bash

echo "🚀 Executando testes com Allure Report..."

# Instalar dependências se necessário
if [ ! -d "node_modules" ]; then
    echo "📦 Instalando dependências..."
    npm install
fi

# Instalar browsers do Playwright se necessário
if [ ! -d "$HOME/.cache/ms-playwright" ]; then
    echo "🌐 Instalando browsers do Playwright..."
    npx playwright install
fi

# Executar testes com Allure
echo "🧪 Executando testes..."
npx playwright test --reporter=allure

# Verificar se os resultados foram gerados
if [ -d "allure-results" ]; then
    echo "✅ Testes executados com sucesso!"
    echo "📊 Resultados Allure gerados em: allure-results/"
    echo ""
    echo "🎯 Para ver o relatório:"
    echo "   npx allure serve allure-results"
    echo ""
    echo "📁 Para gerar relatório estático:"
    echo "   npx allure generate allure-results --clean"
else
    echo "❌ Erro: Resultados Allure não foram gerados"
    exit 1
fi
