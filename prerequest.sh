#!/bin/bash

# Запрашиваем пароль для sudo один раз и кэшируем его
sudo -v

# Функция для добавления заголовка и вывода команды в файл
add_section() {
    local title=$1
    local command=$2
    echo -e "***$title***\n" >> output.txt
    eval "$command" >> output.txt 2>&1
    echo -e "\n\n" >> output.txt
}

# Очистка файла output.txt перед началом записи
> output.txt

# Сбор информации о системе
add_section "CPU" "sudo grep 'MHz' /proc/cpuinfo | awk '{sum += \$4} END {print sum / NR}'"
add_section "RAM" "sudo free -h"
add_section "HDD /VAR" "sudo df -h /var"
add_section "HDD /HOME" "df -h ~"
add_section "OS" "sudo cat /etc/os-release"
add_section "mc" "mc --version"
add_section "nano" "nano --version"
add_section "docker" "docker --version"
add_section "make" "make --version"
add_section "time" "sudo timedatectl"

# Сообщаем пользователю, что операция завершена
echo "Информация о системе сохранена в файл output.txt. Передайте его."