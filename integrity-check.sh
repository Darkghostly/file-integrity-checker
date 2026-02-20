ACTION=$1
TARGET=$2

if [ "$#" -ne 2 ]; then
    echo "Erro: Faltam argumentos."
    echo "Uso correto: ./integrity-check.sh <ação> <alvo>"
    exit 1
fi

if [ ! -e "$TARGET" ]; then
    echo "Erro: O alvo '$TARGET' não existe."
    exit 1
fi

# Definindo o nome do nosso banco de dados
HASH_FILE="hashes.db"

# O 'Cérebro' do Menu: A estrutura CASE avalia a variável ACTION
case "$ACTION" in
    init)
        echo "[*] Iniciando a criação da linha de base para: $TARGET"
        
        # Se o alvo for uma pasta (-d)
        if [ -d "$TARGET" ]; then
            # O comando 'find' procura todos os arquivos (-type f) dentro da pasta
            # e executa o 'sha256sum' em cada um deles. O '>' salva o resultado no HASH_FILE.
            find "$TARGET" -type f -exec sha256sum {} + > "$HASH_FILE"
            echo "[+] Hashes gerados com sucesso para os arquivos do diretório e salvos em $HASH_FILE."
            
        # Se o alvo for um arquivo único (-f)
        elif [ -f "$TARGET" ]; then
            sha256sum "$TARGET" > "$HASH_FILE"
            echo "[+] Hash gerado com sucesso para o arquivo e salvo em $HASH_FILE."
        fi
        ;;
        
    check)
        echo "[*] Função 'check' será construída em breve..."
        ;;
        
    update)
        echo "[*] Função 'update' será construída em breve..."
        ;;
        
    *)
        # Se o usuário não digitar init, check ou update
        echo "Erro: Ação '$ACTION' desconhecida."
        echo "Ações válidas: init, check, update"
        exit 1
        ;;
esac