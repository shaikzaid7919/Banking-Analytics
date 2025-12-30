-- created index for CustomerID and CustomerName
CREATE INDEX idx_customer_id
ON debit_credit_banking_data (CustomerID);

CREATE INDEX idx_customer_name
ON debit_credit_banking_data (CustomerName);
 
-- Total transaction amount per customer
SELECT CustomerID, CustomerName,
       ROUND(SUM(Amount)) AS Total_Transaction_Amount
FROM debit_credit_banking_data
GROUP BY CustomerID, CustomerName;

-- Total deposits and withdrawals
SELECT TransactionType, round(SUM(Amount)) as Total_transaction_amount
FROM debit_credit_banking_data
GROUP BY TransactionType;

-- Customers with balance greater than avg balance
SELECT DISTINCT CustomerID, CustomerName, Balance
FROM debit_credit_banking_data
WHERE Balance > (
    SELECT AVG(Balance)
    FROM debit_credit_banking_data
);

-- Number of transactions per branch
SELECT Branch,
       COUNT(*) AS Total_Transactions
FROM debit_credit_banking_data
GROUP BY Branch;

-- Transactions done using Credit card/ Bank Transfer/ Debit card
SELECT TransactionMethod,
       COUNT(*) AS No_of_Transactions
FROM debit_credit_banking_data
GROUP BY TransactionMethod;

-- Monthly transaction summary
SELECT 
    YEAR(TransactionDate) AS Year,
    MONTH(TransactionDate) AS Month,
    ROUND(SUM(Amount)) AS Total_Amount
FROM debit_credit_banking_data
GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)
ORDER BY Year, Month;

-- Rank customers based on total transaction amount
SELECT CustomerID, CustomerName,
       ROUND(SUM(Amount)) AS Total_Amount,
       RANK() OVER (ORDER BY SUM(Amount) DESC) AS Rank_No
FROM debit_credit_banking_data
GROUP BY CustomerID, CustomerName;

-- Highest transaction amount per customer
SELECT CustomerName,
       ROUND(MAX(Amount)) AS Highest_Transaction
FROM debit_credit_banking_data
GROUP BY CustomerName
ORDER BY Highest_Transaction DESC;

-- Bank Wise total balance
SELECT BankName, ROUND(SUM(Balance)) AS Total_balance
FROM debit_credit_banking_data
GROUP BY BankName
ORDER BY Total_balance DESC;

-- Created befor insert trigger for Amount 
INSERT INTO debit_credit_banking_data
(CustomerID, CustomerName, Amount)
VALUES (102, 'Amit Kumar', -7500);

select * from debit_credit_banking_data;

delete from debit_credit_banking_data where CustomerName = 'Amit Kumar';
set sql_safe_updates = 0;
