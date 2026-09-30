#!/bin/bash
# Задача 7: найти файлы-дубликаты (файлы с одинаковым содержимым,

if [ $# -ne 1 ]; then
    echo "Использование: $0 <каталог>" >&2
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Ошибка: '$DIR' не является каталогом" >&2
    exit 1
fi

find "$DIR" -type f -print0 2>/dev/null \
    | xargs -0 md5sum 2>/dev/null \
    | sort \
    | awk '
        {
            hash = $1
            $1 = ""
            sub(/^ /, "")
            file = $0
            if (hash == prev_hash) {
                if (count == 1) {
                    print "Дубликаты (md5=" hash "):"
                    print "  " prev_file
                }
                print "  " file
                count++
            } else {
                count = 1
            }
            prev_hash = hash
            prev_file = file
        }
    '
