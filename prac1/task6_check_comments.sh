#!/bin/bash
# Задача 6: проверить, есть ли комментарий в первой строке файлов


if [ $# -ne 1 ]; then
    echo "Использование: $0 <каталог>" >&2
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Ошибка: '$DIR' не является каталогом" >&2
    exit 1
fi

while IFS= read -r -d '' file; do
    first_line=$(head -n 1 -- "$file")
    ext="${file##*.}"
    has_comment="нет"

    case "$ext" in
        c|js)
            if [[ "$first_line" =~ ^[[:space:]]*(//|/\*) ]]; then
                has_comment="да"
            fi
            ;;
        py)
            if [[ "$first_line" =~ ^[[:space:]]*# ]]; then
                has_comment="да"
            fi
            ;;
    esac

    printf '%s: комментарий в первой строке - %s\n' "$file" "$has_comment"
done < <(find "$DIR" -type f \( -name '*.c' -o -name '*.js' -o -name '*.py' \) -print0)
