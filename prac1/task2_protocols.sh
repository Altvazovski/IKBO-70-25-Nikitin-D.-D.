#!/bin/bash
# Задача 2: вывести 5 записей с наибольшими номерами портов (протоколов)


FILE="${1:-/etc/protocols}"
N="${2:-5}"

if [ ! -r "$FILE" ]; then
    echo "Ошибка: файл '$FILE' не найден или недоступен для чтения" >&2
    exit 1
fi

grep -vE '^#|^$' "$FILE" | awk '{print $2, $1}' | sort -rn | head -n "$N"
