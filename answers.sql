-- Question 1: Achieving 1NF (First Normal Form) 🛠️
-- Transform the table into 1NF by ensuring each product has a separate row
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
  ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
ORDER BY OrderID, n.n;

-- Question 2: Achieving 2NF (Second Normal Form) 🧩
  -- Step 1: Create the Orders Table (store OrderID and CustomerName):
  CREATE TABLE Orders (
      OrderID INT PRIMARY KEY,
      CustomerName VARCHAR(100)
  );

  -- Step 2: Insert Data into Orders Table:

  INSERT INTO Orders (OrderID, CustomerName)
  SELECT DISTINCT OrderID, CustomerName
  FROM OrderDetails;

  -- Step 3: Create the OrderDetails Table (store OrderID, Product, and Quantity):

  CREATE TABLE OrderDetails (
      OrderID INT,
      Product VARCHAR(100),
      Quantity INT,
      PRIMARY KEY (OrderID, Product),
      FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
  );

  -- Step 4: Insert Data into OrderDetails Table:

  INSERT INTO OrderDetails (OrderID, Product, Quantity)
  SELECT OrderID, Product, Quantity
  FROM OrderDetails;
