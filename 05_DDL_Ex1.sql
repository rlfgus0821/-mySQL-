use testdb1;
alter table product add (prdStock int, prdDate date);
alter table product modify prdCompany varchar(30) not null;
alter table publisher add column (pubPhone varchar(15), pubAddress varchar(30));
alter table publisher drop pubPhone;