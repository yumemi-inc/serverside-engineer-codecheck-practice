import sys
import csv

def main(lines):
    #プレイログの行数
    len_lines = len(lines)
    #参加者リスト players[0,1,2] = id, score_sum, play_num
    players = []

    #参加者の情報をplayersに入れる
    #lines[0] = 1行目はヘッダなので無視
    for i in range(1,len_lines):
        line = lines[i]
        player_id = line[1]
        score = int(line[2])
        played = 0

        #過去に参加したことがある場合 -> (played = 1)
        for j in players:
            #jはリスト[id,scoresum,playnum]
            if player_id in j:
                j[1] += score
                j[2] += 1
                played = 1
        if not played:
            first_play = [player_id,score,1]
            players.append(first_play)

    #playersから、点数集計リストscoreboardを作成
    lp = len(players)
    scoreboard = [[0 for _ in range(2)] for _ in range(lp)]

    for i in range(lp):
        #参加者リスト players[0,1,2] = id, score_sum, play_num
        #0回の人を除外
        if players[i][2]:
            scoreboard[i][0] = players[i][1]/players[i][2]
            scoreboard[i][1] = players[i][0]
    scoreboard.sort(reverse=True)

    #出力
    #1行目はヘッダとして、rank,player_id,mean_scoreを出力する
    print("rank,player_id,mean_score")
    for i in range(min(lp,10)):
        print(i+1,scoreboard[i][1],scoreboard[i][0])


if __name__ == '__main__':
    #ファイル名をsys.argvで指定する。
    args = sys.argv
    filename = args[1]

    #ファイルを読み込み、入力をリストlinesに入れる
    # （入力が長いと読み込みが遅いかもしれない）
    lines = []
    with open(filename, 'r') as f:
        for i in csv.reader(f):
            lines.append(i)

    # main() を実行する
    main(lines)