#!/usr/bin/env bash
# envrn.sh - The ultimate bash task runner

# define each task as bash functions

gen_huge_csv() {
    echo | awk -f csv-generator/awk/gen.awk > ./testcases/test-x-3/game_score_log.csv
}

init() {
    cp .env.example .env
}

_exec_diff() {
    case=$1
    $EXEC_COMMAND ${case}/game_score_log.csv > ${case}/actual.txt
    result=`diff ${case}/expect.txt ${case}/actual.txt`
    if [ "$result" = "" ]; then
        printf "\033[32m%s\033[m\n" "テストを通過しました"
    else
        printf "\033[31m%s\033[m\n" "テストに失敗しました"
        echo ${result}
    fi
}

test() {
    # テストケースを取得
    testcases_path="./testcases/common/*"
    testcases=`find $testcases_path -type d`

    for case in $testcases;
    do
        printf "\033[1m%s\033[m\n" "${case} を実行します"
        _exec_diff $case
        echo $'\n'
    done
}

gen-csv() {
    echo | awk -f csv-generator/awk/gen.awk > ./testcases/extra/test-x-1/game_score_log.csv
}

testx() {
    case='./testcases/extra/test-x-1/'
    printf "\033[1m%s\033[m\n" "${case} を実行します"
    _exec_diff $case
    echo $'\n'
}

# add descriptions to each task

help() {
    cat << EOF
Usage: envrn.sh TASK|COMMAND [OPTIONS]

TASK:
    init: 初期セットアップ
    test: テスト実行
    testx: 拡張テスト実行
    get-csv: 巨大なcsvを生成
    help: このメッセージを表示する
COMMAND:
    any command that will be run with .env read into
EOF
}

# --------------- envrn.sh -----------------
# (C) 2021 Yuichiro Smith <contact@yu-smith.com>
# This script is distributed under the Apache 2.0 License
# See the full license at https://github.com/yu-ichiro/envrn.sh/blob/main/LICENSE

# save the original PWD
__PWD__=$PWD
# save the path of directory which ./envrn.sh is included
__DIR__="$(
  src="${BASH_SOURCE[0]}"
  while [ -h "$src" ]; do
    dir="$(cd -P "$(dirname "$src")" && pwd)"
    src="$(readlink "$src")"
    [[ $src != /* ]] && src="$dir/$src"
  done
  printf %s "$(cd -P "$(dirname "$src")" && pwd)"
)"
# move to __DIR__
cd -P $__DIR__

_load_env() {
    # load envs declared as ENV_VAR=VALUE in files, process substitutions without overriding existing envs
    files="$(cat "$@" <(echo) <(declare -x | sed -E 's/^declare -x //g'))"
    set -a; eval "$files"; set +a;
}

if [ -e '.env' ];then
    _load_env .env
fi

task=${1:-help}
shift
$task "$@"
