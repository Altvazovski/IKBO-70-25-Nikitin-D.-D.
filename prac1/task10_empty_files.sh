#!/bin/bash
# Задача 10: вывести названия всех пустых текстовых файлов

if [ $# -ne 1 ]; then
    echo "Использование: $0 <каталог>" >&2
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Ошибка: '$DIR' не является каталогом" >&2
    exit 1
fi


while IFS= read -r -d '' f; do
    mime=$(file -b --mime-type -- "$f")
    if [[ "$mime" == text/* || "$mime" == inode/x-empty ]]; then
        echo "$f"
    fi
done < <(find "$DIR" -maxdepth 1 -type f -empty -print0)
