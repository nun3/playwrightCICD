# Playwright CI/CD com Jenkins - Baseado na Documentação Oficial

Este projeto implementa CI/CD para testes Playwright usando Jenkins, seguindo as melhores práticas da [documentação oficial do Playwright](https://playwright.dev/docs/ci).

## 🏗️ Arquitetura

- **Projeto**: GitHub (código fonte dos testes)
- **Jenkins**: Docker container local (servidor CI/CD)
- **Execução**: Jenkins executa testes Playwright baixando do GitHub

## 📁 Opções de Jenkinsfile

### 1. **Jenkinsfile** (Básico - Atual)
```groovy
pipeline {
   agent { docker { image 'mcr.microsoft.com/playwright:v1.55.0-noble' } }
   // Execução sequencial simples
}
```

### 2. **Jenkinsfile.official** (Recomendado)
```groovy
pipeline {
   agent { docker { image 'mcr.microsoft.com/playwright:v1.55.0-noble' } }
   environment {
      CI = 'true'  // Ativa configurações específicas para CI
   }
   // Inclui instalação de browsers e relatórios JUnit
}
```

### 3. **Jenkinsfile.sharded** (Para projetos grandes)
```groovy
pipeline {
   agent none
   // Execução paralela em 3 shards para velocidade
}
```

## 🚀 Configuração Baseada na Documentação Oficial

### Pré-requisitos
1. **Docker** instalado e rodando
2. **Jenkins** configurado com plugins necessários

### Plugins Jenkins Necessários
- **Pipeline** (já vem por padrão)
- **HTML Publisher** (para relatórios HTML)
- **JUnit** (para resultados de teste)

### Configurações Recomendadas

#### 1. Workers em CI
```javascript
// playwright.config.js
export default defineConfig({
  workers: process.env.CI ? 1 : undefined, // Estabilidade em CI
  retries: process.env.CI ? 2 : 0,         // Retry em CI
  forbidOnly: !!process.env.CI,            // Bloqueia test.only em CI
});
```

#### 2. Reporters
```javascript
reporter: [
  ['html'],                                    // Relatório visual
  ['junit', { outputFile: 'test-results/junit.xml' }] // Para Jenkins
],
```

## 🔧 Comandos de Setup

### Iniciar Jenkins
```bash
./start-jenkins.sh
```

### Reiniciar com novas configurações
```bash
./restart-jenkins.sh
```

### Parar Jenkins
```bash
./stop-jenkins.sh
```

## 📊 Relatórios e Artefatos

Após execução, você terá acesso a:

1. **Relatório HTML**: Página do build no Jenkins
2. **Resultados JUnit**: Para integração com outros sistemas
3. **Screenshots e Traces**: Para debugging de falhas
4. **Artefatos**: Arquivos de evidência dos testes

## 🎯 Escolha do Jenkinsfile

### Use **Jenkinsfile.official** se:
- ✅ Quer seguir exatamente a documentação oficial
- ✅ Precisa de relatórios JUnit
- ✅ Quer configurações otimizadas para CI

### Use **Jenkinsfile.sharded** se:
- ✅ Tem muitos testes (>50)
- ✅ Quer execução mais rápida
- ✅ Tem recursos suficientes para paralelização

### Use **Jenkinsfile** (atual) se:
- ✅ Quer simplicidade
- ✅ Tem poucos testes
- ✅ Não precisa de relatórios JUnit

## 🐛 Troubleshooting

### Problema: "docker: Permission denied"
**Solução**: Use `./restart-jenkins.sh` para aplicar as correções de permissão

### Problema: "Jenkins doesn't have label 'master'"
**Solução**: Use `Jenkinsfile.official` que não tem esse problema

### Problema: Testes muito lentos
**Solução**: Use `Jenkinsfile.sharded` para execução paralela

## 📚 Referências

- [Documentação Oficial Playwright CI](https://playwright.dev/docs/ci)
- [Jenkins Docker Agent](https://www.jenkins.io/doc/book/pipeline/docker/)
- [Playwright Docker Image](https://playwright.dev/docs/docker)

## 🔄 Próximos Passos

1. **Escolha um Jenkinsfile** baseado nas suas necessidades
2. **Renomeie** para `Jenkinsfile` (substituindo o atual)
3. **Reinicie** o Jenkins: `./restart-jenkins.sh`
4. **Execute** o pipeline no Jenkins
5. **Verifique** os relatórios gerados
