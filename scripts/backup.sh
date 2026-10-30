#!/bin/bash

# Выходим при ошибке
set -euo pipefail

# Переменные
BACKUP_DIR="./backups"
DB_CONTAINER="kelnik-infra-lab-db-1"
DB_USER="kelnik_user"
DB_PASS="kelnik_pass"
DB_NAME="kelnik_db"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="${BACKUP_DIR}/${DB_NAME}_${DATE}.sql"

# Создаем папку для бэкапов, если её нет (флаг -p не ругается, если папка уже есть)
mkdir -p "${BACKUP_DIR}"

echo "Начинаю резервное копирование базы данных ${DB_NAME}..."

# Выполняем mysqldump внутри контейнера и сохраняем на хост
docker exec "${DB_CONTAINER}" mysqldump -u"${DB_USER}" -p"${DB_PASS}" "${DB_NAME}" > "${FILENAME}"

echo "Бэкап успешно создан: ${FILENAME}"

# Проверка, что файл не пустой
if [ -s "${FILENAME}" ]; then
    echo "Проверка пройдена: файл не пустой."
else
    echo "ОШИБКА: Файл бэкапа пустой!"
    exit 1
fi
