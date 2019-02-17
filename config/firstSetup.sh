#!/bin/sh
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Скрипт для настройки SwiftLint & git hooks
# Для исполнения используйте комманду ‘bash firstSetup.sh’

# В процессе запуска должны установится следующие элементы:
# 1) Установится HomeBrew, если еще не установлен
# 2) Установится SwiftLint
# 3) Добавится `.swiftlint.yml` конфиг файл для `SwiftLint`
# 4) Добавится `pre-commit` & `commit-msg` hook-и в папку hooks

# Directories
PROJECT_GIT_HOOKS_DIRECTORY=../.git/hooks
TEMPLATE_GIT_HOOKS_DIRECTORY=$(pwd)/template-hooks

# Hooks Messages
SUCCESS_MESSAGE="Hooks successfully moved to .git/hooks"
ERROR_MESSAGE="Could not find .git/hooks folder, please contact your Dana Beknar"

# -- 1 -- Installing HomeBrew
echo "1. Running HomeBrew:"
which -s brew
if [[ $? != 0 ]] ; then
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "brew installed"
else
brew update
echo "brew updated"
fi

# -- 2 -- Installing SwiftLint
echo "2. Running SwiftLint:"
which -s swiftLint
if [[ $? != 0 ]] ; then
brew install swiftlint
echo "swiftlint installed"
else 
echo "swiftlint already installed"


fi

# -- 3 -- Move `.swiftLint.yml`
# Копируем `.swiftLint.yml` конфиг файл в основную папку
echo "3. Moving .swiftlint.yml:"
cp .swiftlint.yml ../


if [[ $? != 0 ]] ; then
echo ".swiftlint.yml moving failed"
else 
echo ".swiftlint.yml moved successfully"
fi

###

# -- 4 -- Move hooks
# Копируем готовые hook-и корневую в .git/hooks папку
echo "4. Running Git Hooks:"
if [ -e $PROJECT_GIT_HOOKS_DIRECTORY ]; then
cp $TEMPLATE_GIT_HOOKS_DIRECTORY/pre-commit $TEMPLATE_GIT_HOOKS_DIRECTORY/commit-msg $PROJECT_GIT_HOOKS_DIRECTORY 
chmod +x $PROJECT_GIT_HOOKS_DIRECTORY/*
echo $SUCCESS_MESSAGE
else
echo $ERROR_MESSAGE
fi

echo "Script was ended"
echo "Questions? Ask Dana Beknar"