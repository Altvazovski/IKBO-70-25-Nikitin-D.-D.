#!/bin/bash
# Задача 8: найти все файлы в текущем (или указанном) каталоге

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Использование: $0 <расширение> [каталог]" >&2
    exit 1
fi

EXT="$1"
DIR="${2:-.}"
ARCHIVE="${EXT}_files.tar"

if [ ! -d "$DIR" ]; then
    echo "Ошибка: '$DIR' не является каталогом" >&2
    exit 1
fi

mapfile -d '' -t files < <(find "$DIR" -type f -name "*.${EXT}" -print0)

if [ "${#files[@]}" -eq 0 ]; then
    echo "Файлы с расширением .$EXT не найдены в '$DIR'" >&2
    exit 1
fi

tar -cf "$ARCHIVE" "${files[@]}"

echo "Создан архив '$ARCHIVE', файлов внутри: ${#files[@]}"
