#!/bin/bash
# Задача 10: вывести названия всех пустых текстовых файлов
# в указанной директории.
#
# Использование: ./task10_empty_files.sh <каталог>

if [ $# -ne 1 ]; then
    echo "Использование: $0 <каталог>" >&2
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Ошибка: '$DIR' не является каталогом" >&2
    exit 1
fi

# find "$DIR" -maxdepth 1     -- только файлы внутри указанной директории
#                                (без рекурсии в подкаталоги)
# -type f -empty              -- обычный файл нулевого размера
# -exec file --mime-type ... -- проверяем, что MIME-тип файла текстовый
#                                (пустой файл обычно определяется как
#                                inode/x-empty; такие файлы тоже считаем
#                                текстовыми, т.к. в них нет никаких
#                                бинарных данных)
while IFS= read -r -d '' f; do
    mime=$(file -b --mime-type -- "$f")
    if [[ "$mime" == text/* || "$mime" == inode/x-empty ]]; then
        echo "$f"
    fi
done < <(find "$DIR" -maxdepth 1 -type f -empty -print0)
