# Configuração Playwright no Jenkins

## Pré-requisitos

1. **Jenkins** instalado e configurado
2. **Docker** instalado no Jenkins (para usar a imagem do Playwright)
3. **Node.js** (opcional, se não usar Docker)

## Configuração no Jenkins

### 1. Instalar Plugins Necessários

No Jenkins, instale os seguintes plugins:
- **Pipeline** (já vem por padrão)
- **HTML Publisher** (para relatórios HTML)
- **JUnit** (para resultados de teste)

### 2. Configurar Job Pipeline

1. Crie um novo **Pipeline Job**
2. Em **Pipeline Definition**, selecione **Pipeline script from SCM**
3. Configure seu repositório Git
4. Especifique o arquivo `Jenkinsfile` como **Script Path**

### 3. Configurações Recomendadas

#### Timeout
Configure um timeout adequado para execução dos testes:
```groovy
options {
    timeout(time: 60, unit: 'MINUTES')
}
```

#### Variáveis de Ambiente
Se necessário, configure variáveis de ambiente:
```groovy
environment {
    CI = 'true'
    PLAYWRIGHT_TEST_BASE_URL = 'https://sua-app.com'
}
```

## Execução

### Pipeline Básico
```bash
# Usar o Jenkinsfile padrão
pipeline {
   agent { docker { image 'mcr.microsoft.com/playwright:v1.55.0-noble' } }
   // ... resto da configuração
}
```

### Pipeline com Sharding (para projetos grandes)
```bash
# Usar Jenkinsfile.sharded para execução paralela
# Divide os testes em 3 shards para execução mais rápida
```

## Relatórios e Artefatos

Após a execução, você terá acesso a:

1. **Relatório HTML**: Disponível na página do build
2. **Resultados JUnit**: Para integração com outros sistemas
3. **Screenshots e Traces**: Para debugging de falhas

## Troubleshooting

### Problemas Comuns

1. **Timeout**: Aumente o timeout se os testes demorarem muito
2. **Memória**: Para projetos grandes, considere usar sharding
3. **Dependências**: Use `npm ci` para instalação limpa

### Debug

Para debug, adicione logs detalhados:
```groovy
stage('Debug') {
   steps {
      sh 'npx playwright test --reporter=list'
   }
}
```

## Comandos Úteis

```bash
# Executar apenas testes que falharam
npx playwright test --grep-invert=""

# Executar em modo headed (com interface)
npx playwright test --headed

# Gerar relatório local
npx playwright show-report
```
