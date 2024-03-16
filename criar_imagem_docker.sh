#!/bin/bash

if ! service docker status > /dev/null; then
    sudo service docker start
    if [ $? -ne 0 ]; then
        echo "Erro ao iniciar o serviço Docker. Verifique as permissões ou a instalação do Docker."
        exit 1
    fi
fi

read -p "Informe o nome da TAG para imagem: " TAG_NAME
read -p "Informe o caminho do Dockerfile (por exemplo, '.' é o diretório atual): " DOCKERFILE_PATH

docker build -t $TAG_NAME $DOCKERFILE_PATH

read -p "Informe a porta do contêiner: " PORT_CONTAINER
read -p "Informe a porta da imagem: " PORT_IMAGE

docker run -dit -p $PORT_CONTAINER:$PORT_IMAGE --name $TAG_NAME $TAG_NAME

echo "ID do Container:"
docker ps -qf "name=$TAG_NAME"
