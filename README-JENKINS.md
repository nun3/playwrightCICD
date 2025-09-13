# 🚀 Ambiente Jenkins para Playwright CI/CD

Este projeto configura um ambiente Jenkins completo para executar testes Playwright em CI/CD usando Docker.

## 📋 Pré-requisitos

- **Docker Desktop** instalado e rodando
- **Git** instalado
- **Node.js** (opcional, para desenvolvimento local)

## 🏃‍♂️ Início Rápido

### 1. Configurar Repositório Git
```bash
./setup-repo.sh
```

### 2. Iniciar Jenkins
```bash
./start-jenkins.sh
```

### 3. Acessar Jenkins
- **URL**: http://localhost:8080
- **Usuário**: `admin`
- **Senha**: `admin123`

### 4. Parar Jenkins
```bash
./stop-jenkins.sh
```

## 🏗️ Arquitetura

```
┌─────────────────┐    ┌─────────────────┐
│   Jenkins       │    │   Docker DIND   │
│   (Port 8080)   │◄──►│   (DinD)        │
└─────────────────┘    └─────────────────┘
         │                       │
         ▼                       ▼
┌─────────────────────────────────────┐
│        Docker Network              │
│     (jenkins-network)              │
└─────────────────────────────────────┘
```

## 📁 Estrutura de Arquivos

```
PlaywrightCICD/
├── docker-compose.yml          # Configuração do ambiente
├── Jenkinsfile                 # Pipeline principal
├── Jenkinsfile.sharded         # Pipeline com sharding
├── start-jenkins.sh            # Script de inicialização
├── stop-jenkins.sh             # Script de parada
├── setup-repo.sh               # Script de configuração Git
├── jenkins-config/             # Configurações automáticas
│   ├── 01-install-plugins.groovy
│   ├── 02-configure-docker.groovy
│   └── 03-create-playwright-job.groovy
└── README-JENKINS.md           # Esta documentação
```

## 🔧 Configuração Detalhada

### Jenkins Configurado Automaticamente

O ambiente inclui configuração automática de:

- ✅ **Plugins essenciais** (Pipeline, Git, HTML Publisher, JUnit, etc.)
- ✅ **Docker integration** (Docker-in-Docker)
- ✅ **Job Playwright** pré-configurado
- ✅ **Usuário admin** (admin/admin123)

### Plugins Instalados

- `workflow-aggregator` - Pipeline principal
- `git` - Integração Git
- `htmlpublisher` - Relatórios HTML
- `junit` - Resultados de teste
- `blueocean` - Interface moderna
- `docker-plugin` - Suporte Docker
- `timestamper` - Timestamps nos logs
- `build-timeout` - Timeout de builds
- `credentials-binding` - Gerenciamento de credenciais

## 🎯 Como Usar

### 1. Configurar Repositório

Após iniciar o Jenkins, configure seu repositório Git:

1. Acesse o job `playwright-tests`
2. Vá em **Configure**
3. Em **Pipeline**, configure:
   - **Definition**: Pipeline script from SCM
   - **SCM**: Git
   - **Repository URL**: Seu repositório Git
   - **Branch**: `*/main` ou `*/master`
   - **Script Path**: `Jenkinsfile`

### 2. Executar Pipeline

1. Clique em **Build Now**
2. Acompanhe o progresso em **Console Output**
3. Veja os resultados em **Test Results**
4. Acesse relatórios HTML em **HTML Reports**

### 3. Configurações Avançadas

#### Variáveis de Ambiente
Adicione no job:
```groovy
environment {
    CI = 'true'
    PLAYWRIGHT_TEST_BASE_URL = 'https://sua-app.com'
}
```

#### Timeout
```groovy
options {
    timeout(time: 60, unit: 'MINUTES')
}
```

#### Sharding (para projetos grandes)
Use `Jenkinsfile.sharded` como Script Path para execução paralela.

## 📊 Relatórios e Artefatos

### Relatórios Disponíveis

1. **HTML Report**: Relatório visual completo
2. **JUnit Results**: Para integração com outros sistemas
3. **Console Output**: Logs detalhados da execução
4. **Screenshots**: Capturas de tela de falhas
5. **Traces**: Rastreamento detalhado (se habilitado)

### Acessar Relatórios

- **HTML**: Página do build → **HTML Reports**
- **JUnit**: Página do build → **Test Results**
- **Screenshots**: Página do build → **Build Artifacts**

## 🐛 Troubleshooting

### Problemas Comuns

#### Jenkins não inicia
```bash
# Verificar logs
docker-compose logs jenkins

# Verificar se Docker está rodando
docker info
```

#### Pipeline falha
```bash
# Verificar console output
# Verificar se repositório Git está acessível
# Verificar se Docker está funcionando
```

#### Permissões Docker
```bash
# No Linux, adicionar usuário ao grupo docker
sudo usermod -aG docker $USER
# Reiniciar sessão
```

### Comandos Úteis

```bash
# Ver logs em tempo real
docker-compose logs -f jenkins

# Reiniciar apenas Jenkins
docker-compose restart jenkins

# Limpar volumes (CUIDADO: remove todos os dados)
docker-compose down -v

# Ver containers rodando
docker-compose ps

# Entrar no container Jenkins
docker-compose exec jenkins bash
```

## 🔒 Segurança

### Produção

Para ambiente de produção, considere:

1. **Alterar senhas padrão**
2. **Configurar HTTPS**
3. **Restringir acesso à rede**
4. **Usar secrets para credenciais**
5. **Backup regular dos dados**

### Exemplo de senha segura
```bash
# No docker-compose.yml
environment:
  - JENKINS_ADMIN_PASSWORD=sua_senha_segura_aqui
```

## 📈 Performance

### Otimizações

1. **Sharding**: Para projetos grandes
2. **Cache**: Dependências Node.js
3. **Paralelismo**: Múltiplos workers (cuidado com recursos)
4. **Timeout**: Ajustar conforme necessário

### Recursos Recomendados

- **CPU**: 4+ cores
- **RAM**: 8GB+
- **Disco**: 20GB+ (para Docker images)

## 🆘 Suporte

### Logs Importantes

```bash
# Jenkins logs
docker-compose logs jenkins

# Docker logs
docker system logs

# Pipeline logs
# Acesse: Jenkins → Job → Build → Console Output
```

### Informações do Sistema

```bash
# Versão Docker
docker --version

# Versão Docker Compose
docker-compose --version

# Informações do container Jenkins
docker-compose exec jenkins cat /etc/os-release
```

## 🎉 Próximos Passos

1. **Configure seu repositório Git**
2. **Execute o primeiro pipeline**
3. **Personalize os testes conforme necessário**
4. **Configure notificações (Slack, Email)**
5. **Implemente deploy automático**

---

**🎯 Agora você tem um ambiente Jenkins completo para Playwright CI/CD!**
