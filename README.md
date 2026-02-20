# File Integrity Monitor (FIM) - Bash Edition
* **Ideia do projeto: https://roadmap.sh/projects/file-integrity-checker

Uma ferramenta de linha de comando leve e eficiente para Monitoramento de Integridade de Arquivos (FIM), escrita totalmente em Bash. Projetada para atuar como uma camada de defesa em ambientes Linux, esta ferramenta utiliza hashes criptográficos (SHA-256) para criar uma linha de base (baseline) de arquivos de log ou diretórios críticos, permitindo a detecção rápida de alterações não autorizadas.

Ideal para operações de Blue Team, auditoria de sistemas e fortalecimento de práticas de DevSecOps.

## 🚀 Funcionalidades

* **Inicialização (`init`):** Calcula e armazena de forma segura os hashes SHA-256 de todos os arquivos em um diretório ou de um arquivo individual.
* **Verificação (`check`):** Compara o estado atual dos arquivos com a linha de base armazenada, alertando imediatamente sobre arquivos modificados (Possível adulteração).
* **Atualização (`update`):** Permite a redefinição manual do hash de um arquivo específico após uma alteração legítima pelo administrador.

## 📁 Estrutura do Projeto

```text
FILE-INTEGRITY-CHECKER/
├── integrity-check.sh    # Script principal da aplicação
├── hashes.db             # Banco de dados local gerado pelo script (Ignorado no Git)
├── .gitignore            # Arquivo para ignorar arquivos gerados dinamicamente
└── test_logs/            # Diretório de laboratório para testar a ferramenta com segurança
```

## 🛠️ Como Usar

Antes do primeiro uso, certifique-se de conceder permissão de execução ao script:
```bash
chmod +x integrity-check.sh
```

### 1. Criar a Linha de Base (Baseline)
Para mapear um diretório inteiro (ex: sua pasta de logs de teste) ou um arquivo específico:
```bash
./integrity-check.sh init ./test_logs
```

### 2. Checar a Integridade
Para verificar se algum arquivo foi adulterado desde a criação da baseline:
```bash
./integrity-check.sh check ./test_logs/sys_test.log
```
### 3. Atualizar um Hash
Caso um arquivo de log tenha recebido novas entradas de forma legítima, atualize seu registro:
```bash
./integrity-check.sh update ./test_logs/sys_test.log
```

## 👨‍💻 Autor
Desenvolvido por **Gustavo Bueno da Silva (Darkghostly)**. <br>
Focado no desenvolvimento de soluções em Cybersecurity e especialização em DevSecOps.
