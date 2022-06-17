BEGIN {
        srand(100);
        printf("create_timestamp,player_id,score\n");
        for(i=1; i<=50000000; i++){
		player_id = "player" int(rand()*10000)
                printf("%s,%s,%d\n",
			"2021/01/01 12:00",
			player_id,
			substr(rand(), 3) );
        }
}
