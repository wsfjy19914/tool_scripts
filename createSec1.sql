use tse_d_yf;

create table if not exists sec1(
		code_id string,
		date_s string,
		openning int,
		high int,
		low int,
		closing int,
		turnover int,
		closing_adjusted float
)
partitioned by (code_id string)
row format delimited
fields terminated by ','
lines terminated by '\n';



