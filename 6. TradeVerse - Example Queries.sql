--Top 5 donor users
select user_ID
from donation
group by user_ID
having sum(donation_amount) in (
select sum(donation_amount) from (
select sum(donation_amount)
from donation
group by user_ID
order by sum(donation_amount) desc)where rownum<=5);

--The most transacted (number of transactions) share
select share_ID
from transactions
group by share_ID
having count(transaction_ID) in(
select*from(
select count(transaction_ID)
from transactions
group by share_ID
order by count(transaction_ID) desc)where rownum<=1);

--Most trading user
select user_ID
from transactions
group by user_ID
having count(transaction_ID) in(
select*from(
select count(transaction_ID)
from transactions
group by user_ID
order by count(transaction_ID) desc)where rownum<=1);

--Top 10 portfolio
select portfolio_ID
from portfolio
group by portfolio_ID
having sum(current_invested_amount+balance_in_hand) in(
select*from(
select sum(current_invested_amount+balance_in_hand) as "Trading Amount"
from portfolio
group by portfolio_ID
order by sum(current_invested_amount+balance_in_hand) desc)where rownum<=10);
