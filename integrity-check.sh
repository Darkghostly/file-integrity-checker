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

HASH_FILE="hashes.db"

case "$ACTION" in
    init)
        echo "[*] Iniciando a criação da linha de base para: $TARGET"
        
        if [ -d "$TARGET" ]; then
            find "$TARGET" -type f -exec sha256sum {} + > "$HASH_FILE"
            echo "[+] Hashes gerados com sucesso para os arquivos do diretório e salvos em $HASH_FILE."
            
        elif [ -f "$TARGET" ]; then
            sha256sum "$TARGET" > "$HASH_FILE"
            echo "[+] Hash gerado com sucesso para o arquivo e salvo em $HASH_FILE."
        fi
        ;;
        
    check)
        echo "[*] Verificando a integridade de: $TARGET"
        
        if [ ! -f "$HASH_FILE" ]; then
            echo "Erro: Arquivo de baseline ($HASH_FILE) não encontrado. Execute o 'init' primeiro."
            exit 1
        fi

        if [ -f "$TARGET" ]; then
            
            CURRENT_HASH=$(sha256sum "$TARGET" | awk '{print $1}')
            
            SAVED_HASH=$(grep "$TARGET" "$HASH_FILE" | awk '{print $1}')
            
            if [ -z "$SAVED_HASH" ]; then
                echo "Status: Arquivo Novo (Não consta na baseline)"
                
            elif [ "$CURRENT_HASH" == "$SAVED_HASH" ]; then
                echo "Status: Unmodified"
                
            else
                echo "Status: Modified (Hash mismatch) - ALERTA DE ADULTERAÇÃO!"
            fi
            
        else
            echo "Erro: O alvo precisa ser um arquivo válido para a verificação."
        fi
        ;;
    update)
        echo "[*] Atualizando o hash salvo para: $TARGET"
        
        if [ ! -f "$HASH_FILE" ]; then
            echo "Erro: Arquivo de baseline ($HASH_FILE) não encontrado."
            exit 1
        fi

        if [ -f "$TARGET" ]; then  
            grep -v "$TARGET" "$HASH_FILE" > temp_hashes.db
            mv temp_hashes.db "$HASH_FILE"
            sha256sum "$TARGET" >> "$HASH_FILE"
            
            echo "[+] Hash atualizado com sucesso no banco de dados!"
            
        else
            echo "Erro: O alvo precisa ser um arquivo válido para a atualização."
        fi
        ;;
        
    *)
        echo "Erro: Ação '$ACTION' desconhecida."
        echo "Ações válidas: init, check, update"
        exit 1
        ;;
esac