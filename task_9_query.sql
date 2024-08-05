select * from sales

select product_id, sales, quantity, discount, profit from sales


select sum(sales) as total_sales, 
sum(profit) as total_profit,
(SUM(profit) / SUM(sales)) * 100 AS profit_percentage
from sales 
where product_id = 'FUR-TA-10000577'

create function total_sales_data(product_id_input varchar)
RETURNS TABLE( total_sales double precision,
    total_profit double precision,
    profit_percentage double precision) AS $$
BEGIN
 select SUM(sales), SUM(profit) INTO total_sales, total_profit
    from sales where sales.product_id = product_id_input;
    if 
	total_sales > 0 THEN
        profit_percentage := (total_profit / total_sales) * 100;
    else
        profit_percentage := 0;
    end if;
RETURN QUERY select total_sales, total_profit, profit_percentage; 
END;
$$ LANGUAGE plpgsql;


SELECT * from total_sales_data('OFF-ST-10000760')
SELECT * from total_sales_data('FUR-CH-10000454')