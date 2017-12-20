CREATE TABLE users_table ( 
user_id varchar2(10) not null, 
first_name varchar2(30) not null, 
last_name varchar2(30) not null, 
email_id varchar2(30), 
dob date not null, 
occupation varchar2(30), 
organization_name varchar2(30), 
purpose varchar2(30), 
number_of_followers number(10,0), 
constraint user_table_pk PRIMARY KEY (user_id) 
); 
 
CREATE TABLE exchange ( 
exchange_name varchar2(30) not null, 
current_composite_rate number (3,5) not null, 
constraint exchange_pk PRIMARY KEY (exchange_name) 
); 
 
CREATE TABLE company ( 
company_id varchar2 (10) not null, 
company_name varchar2(30) not null, 
constraint company_pk PRIMARY KEY (company_id) 
); 
 
CREATE TABLE table_share ( 
share_id varchar2(10) not null, 
company_id varchar2(10) not null, 
share_description varchar2 (99), 
exchange_name varchar2 (30) not null, 
constraint share_pk PRIMARY KEY (share_id), 
constraint share_fk1 FOREIGN KEY (company_id) REFERENCES company (company_id), 
constraint share_fk2 FOREIGN KEY (exchange_name) REFERENCES exchange (exchange_name) 
); 
 
 
CREATE TABLE transactions ( 
transaction_id varchar2 (10) not null, 
transaction_date_time date not null, 
share_id varchar2 (10) not null, 
user_id varchar2(10) not null, 
comments varchar2(30), 
constraint transactions_pk PRIMARY KEY (transaction_id), 
constraint transactions_fk1 FOREIGN KEY (share_id) REFERENCES table_share (share_id), 
constraint transactions_fk2 FOREIGN KEY (user_id) REFERENCES users_table (user_id) 
); 
  
CREATE TABLE transaction_buyin( 
transaction_ID varchar2(10) not null, 
buyin_amount number(10,5) not null, 
number_of_shares_bought number(10,5) not null, 
constraint transaction_buyin_pk PRIMARY KEY (transaction_ID), 
constraint transaction_buyin_fk FOREIGN KEY (transaction_ID) REFERENCES transactions (transaction_ID) 
); 
  
CREATE TABLE transaction_sell( 
transaction_ID varchar2 (10) not null, 
sell_amount number(10,5) not null, 
number_of_shares_sold number(10,0) not null, 
constraint transaction_sell_pk PRIMARY KEY (transaction_ID), 
constraint transaction_sell_fk FOREIGN KEY (transaction_ID) REFERENCES transactions (transaction_ID) 
); 
  
CREATE TABLE portfolio( 
portfolio_ID varchar2(10) not null, 
user_ID varchar2(10)  not null, 
current_invested_amount number(10,5) not null, 
balance_in_hand number(10,5) not null, 
Date_time date default sysdate not null, 
constraint portfolio_pk PRIMARY KEY (portfolio_ID), 
constraint portfolio_fk FOREIGN KEY (user_ID) REFERENCES users_table (user_ID) 
); 
  
CREATE TABLE company_information( 
company_ID varchar2(10) not null, 
EPS number(10,2) not null, 
P_E_Ratio number(10,2) not null, 
market_capital number(20,0) not null, 
dividends_declared_in_year number(10,2) not null, 
constraint company_information_pk PRIMARY KEY (company_ID), 
constraint company_information_fk FOREIGN KEY (company_ID) REFERENCES company(company_ID) 
); 
  
CREATE TABLE industry( 
industry_ID varchar2(10) not null, 
industry_name varchar2(30) not null, 
constraint industry_pk PRIMARY KEY (industry_ID) 
); 
  
CREATE TABLE news( 
company_ID varchar2(10) not null, 
news_description varchar2(1000) not null, 
constraint news_pk PRIMARY KEY (company_ID), 
constraint news_fk FOREIGN KEY (company_ID) REFERENCES company(company_ID) 
); 
  
CREATE TABLE formed_group( 
group_ID varchar2(10) not null, 
manager_ID varchar2(10), 
formed_date date default sysdate not null, 
number_of_members number(10,0) not null, 
group_name varchar2(30) not null, 
purpose varchar2(30), 
constraint group_pk PRIMARY KEY (group_ID) 
); 
  
CREATE TABLE users_of_group(  
group_ID varchar2(10) not null,  
user_ID varchar2 (10) not null,  
constraint group_users_pk1 PRIMARY KEY (group_ID,user_ID),  
constraint group_users_fk1 FOREIGN KEY (group_ID) REFERENCES formed_group(group_ID),  
constraint group_users_fk2 FOREIGN KEY (user_ID) REFERENCES users_table(user_ID)  
);  
  
CREATE TABLE competition( 
competition_ID varchar2(10) not null, 
prize number(10,0), 
description varchar2(1000), 
start_date date default sysdate not null, 
end_date date not null, 
constraint competition_pk PRIMARY KEY (competition_ID) 
); 
  
CREATE TABLE participant( 
competition_ID varchar2(10) not null, 
user_ID varchar2(10) not null, 
constraint participant_pk1 PRIMARY KEY (competition_ID,user_ID), 
constraint participant_fk1 FOREIGN KEY (competition_ID) REFERENCES competition (competition_ID), 
constraint participant_fk2 FOREIGN KEY (user_ID) REFERENCES users_table(user_ID) 
); 
  
CREATE TABLE watch_list( 
share_ID varchar2(10) not null, 
user_ID varchar2(10) not null, 
constraint watch_list_pk1 PRIMARY KEY (share_ID,user_ID), 
constraint watch_list_fk1 FOREIGN KEY(share_ID) REFERENCES table_share(share_ID), 
constraint watch_list_fk2 FOREIGN KEY(user_ID) REFERENCES users_table(user_ID) 
); 
 
  
  
CREATE TABLE industry_following( 
industry_ID varchar2 (10) not null, 
user_ID varchar2(10) not null, 
constraint industry_following_pk1 PRIMARY KEY (industry_ID,user_ID), 
constraint industry_following_fk1 FOREIGN KEY (industry_ID) REFERENCES industry(industry_ID), 
constraint industry_following_fk2 FOREIGN KEY (user_ID) REFERENCES users_table (user_ID) 
); 
  
CREATE TABLE discussion_forum_question( 
question_ID varchar2(10) not null, 
question_description varchar2(1000) not null, 
share_ID varchar2(10), 
user_ID varchar2(10) not null, 
industry_ID varchar2 (10), 
constraint discussion_forum_question_pk PRIMARY KEY (question_ID), 
constraint discussion_forum_question_fk1 FOREIGN KEY (share_ID) REFERENCES table_share(share_ID), 
constraint discussion_forum_question_fk2 FOREIGN KEY(user_ID) REFERENCES users_table(user_ID), 
constraint discussion_forum_question_fk3 FOREIGN KEY(industry_ID) REFERENCES industry(industry_ID) 
); 
  
CREATE TABLE discussion_forum_answers( 
answer_ID varchar2(10) not null, 
question_ID varchar2(10) not null, 
answer_description varchar2(1000) not null, 
user_ID varchar2(10) not null, 
rating number(2,0), 
constraint disucssion_forum_answers_pk PRIMARY KEY (answer_ID), 
constraint dicussion_forum_answers_fk1 FOREIGN KEY (question_ID) REFERENCES discussion_forum_question(question_ID), 
constraint discussion_forum_answers_fk2 FOREIGN KEY (user_ID) REFERENCES users_table(user_ID) 
); 
 
CREATE TABLE donation( 
donation_ID varchar2(10) not null, 
donation_date date default sysdate not null, 
user_ID varchar2(10) not null, 
donation_amount number(10,0) not null, 
donation_purpose varchar2(30), 
constraint donation_pk PRIMARY KEY (donation_ID), 
constraint donation_fk FOREIGN KEY (user_ID) REFERENCES users_table(user_ID) 
); 
 
CREATE TABLE individual_stock_performances( 
portfolio_ID varchar2(10) not null, 
share_ID varchar2(10) not null, 
current_price number(10,5) not null, 
number_of_shares_owned number(10,0) not null, 
average_buy_price number(10,5) not null, 
constraint individual_stock_performances_pk1 PRIMARY KEY (portfolio_ID,share_ID), 
constraint individual_stock_performances_fk1 FOREIGN KEY(portfolio_ID) REFERENCES portfolio(portfolio_ID), 
constraint individual_stock_performances_fk2 FOREIGN KEY(share_ID) REFERENCES table_share(share_ID) 
); 
 
  
  
CREATE TABLE share_current( 
share_ID varchar2(10) not null, 
current_value number(10,5) not null, 
number_of_shares_in_market number(10,0) not null, 
constraint share_current_pk PRIMARY KEY (share_ID), 
constraint share_current_fk FOREIGN KEY(share_ID) REFERENCES table_share(share_ID) 
); 
  
CREATE TABLE share_daily_summary(  
share_ID varchar2(10) not null,  
opening_value number(10,5) not null,  
closing_value number(10,5) not null,  
date_1 date default sysdate not null,  
constraint share_daily_summary_pk1 PRIMARY KEY (share_ID,date_1),  
constraint share_daily_summary_fk FOREIGN KEY(share_ID) REFERENCES table_share(share_ID)  
);  
  
CREATE TABLE share_detail_valuation( 
share_ID varchar2(10) not null, 
share_value number (10,5) not null, 
date_time date not null, 
constraint share_detail_valuation_pk1 PRIMARY KEY (share_ID,date_time), 
constraint share_detail_valuation_fk FOREIGN KEY (share_ID) REFERENCES table_share(share_ID) 
); 
 
CREATE TABLE followers_following( 
following_ID varchar2(10) not null, 
followers_ID varchar2(10) not null, 
constraint followers_following_pk1 PRIMARY KEY (following_ID,followers_ID), 
constraint followers_following_fk1 FOREIGN KEY(following_ID) REFERENCES users_table(user_ID), 
constraint followers_following_fk2 FOREIGN KEY (followers_ID) REFERENCES users_table(user_ID) 
); 
