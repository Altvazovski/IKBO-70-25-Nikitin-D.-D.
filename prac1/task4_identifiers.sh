#!/bin/bash
# Задача 4: вывести все уникальные идентификаторы (по правилам


if [ $# -ne 1 ]; then
    echo "Использование: $0 <файл>" >&2
    exit 1
fi

FILE="$1"

if [ ! -r "$FILE" ]; then
    echo "Ошибка: файл '$FILE' не найден или недоступен для чтения" >&2
    exit 1
fi

grep -oE '[A-Za-z_][A-Za-z0-9_]*' "$FILE" | sort -u | tr '\n' ' ' | sed 's/ $/\n/'
