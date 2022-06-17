import sys
import csv
import pandas as pd

def main(lines):
    #プレイログの行数
    len_lines = len(lines)

    #lines[0] = 1行目はヘッダなので無視
    for i in range(1,len_lines):
        line = lines.split(",")


    #出力
    #score_means = df["score"].groupby("player_id").mean()
    #print(score_means)

    #1行目はヘッダとして、rank,player_id,mean_scoreを出力する


if __name__ == '__main__':
    #ファイル名をsys.argvで指定する。
    args = sys.argv
    filename = args[1]

    #ファイルを読み込み、入力をリストlinesに入れる
    # （入力が長いと読み込みが遅いかもしれない）
    lines = []
    with open(filename, 'r') as f:
        #pandasの環境構築に失敗した
        #df = pd.read_csv(f)
        
        for i in csv.reader(f):
            lines.append(i)

    # main() を実行する
    main(lines)