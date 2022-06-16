fn main() {
    use rand::Rng;
    use chrono::{DateTime, Utc, TimeZone};

    let mut rng = rand::thread_rng();
    
    let mut n = 0;
    println!("create_timestamp,player_id,score");

    while n < 100 {
        let player_id: i32 = rng.gen_range(0..1000);
        let score: i32 = rng.gen_range(0..100);
        let create_timestamp: DateTime<Utc> = Utc.timestamp(rng.gen_range(1000000000..2000000000), 0);
        println!("{0},player{1},{2}",create_timestamp.format("%Y%m%d %H:%M:%S").to_string() , player_id, score);
        n += 1;
    }
}
