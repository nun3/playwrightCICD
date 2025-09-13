#!/bin/bash

echo "🔧 Configurando repositório para Jenkins..."

# Verificar se estamos em um repositório Git
if [ ! -d ".git" ]; then
    echo "📦 Inicializando repositório Git..."
    git init
    git add .
    git commit -m "Initial commit: Playwright CI/CD setup"
    echo "✅ Repositório Git inicializado!"
fi

# Criar arquivo .gitignore se não existir
if [ ! -f ".gitignore" ]; then
    echo "📝 Criando .gitignore..."
    cat > .gitignore << EOF
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Test results
test-results/
playwright-report/
playwright/.cache/

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Jenkins
.jenkins/
EOF
    echo "✅ .gitignore criado!"
fi

# Adicionar arquivos ao Git
echo "📁 Adicionando arquivos ao Git..."
git add .

# Verificar se há mudanças para commit
if [ -n "$(git status --porcelain)" ]; then
    git commit -m "Add Playwright CI/CD configuration"
    echo "✅ Mudanças commitadas!"
else
    echo "ℹ️  Nenhuma mudança para commit"
fi

echo ""
echo "🎉 Repositório configurado!"
echo ""
echo "📋 Próximos passos:"
echo "1. Crie um repositório no GitHub/GitLab"
echo "2. Adicione o remote: git remote add origin <url-do-repo>"
echo "3. Faça push: git push -u origin main"
echo "4. Configure a URL do repositório no Jenkins"
