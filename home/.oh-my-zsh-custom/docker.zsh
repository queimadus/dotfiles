if [[ "$OSTYPE" = darwin* ]]; then
  export DOCKER_TLS_VERIFY="0"
  export DOCKER_HOST="tcp://192.168.99.100:2376"
  export DOCKER_CERT_PATH="/Users/bruno/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
fi

