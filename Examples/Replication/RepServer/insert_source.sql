-------------------------------------------------
--   Load data
-------------------------------------------------

INSERT INTO SalesRep( rep_id, name ) VALUES ( 195,'Marc Dill' )
INSERT INTO SalesRep( rep_id, name ) VALUES ( 856,'Samuel Singer' )
INSERT INTO SalesRep( rep_id, name ) VALUES ( 949,'Pamela Savarino' )
INSERT INTO SalesRep( rep_id, name ) VALUES ( 1039,'Shih Lin Chao' )
go 
COMMIT WORK

go
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 104,'P.S.C.',1039 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 112,'McManus Inc.',856 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 113,'Lakes Inc.',856 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 123,'North Land Trading',949 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 126,'Golden Gate Active Wear',949 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 130,'Wyse Corp.',1039 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 135,'Hermanns',949 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 143,'Molly''s',856 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 163,'Mount Eastern Sports',856 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 165,'Moran''s Gift Shop',1039 )
INSERT INTO Customer ( cust_id, name, rep_id ) VALUES ( 166,'Hospital Gifts',949 )
go
COMMIT WORK
go

INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1097,'Salton Pepper',104 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1099,'Amit Singh',104 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1100,'Helen Chau',112 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1101,'Ella Mentary',113 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1102,'Sheng Chen',123 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1103,'Maio Chermak',123 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1104,'Ling Ling Andrews',123 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1105,'Li-Hui Jyh-Hwa',123 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1106,'Jen-Chang Chin',126 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1107,'Alfred Neumann',130 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1108,'Rosanna Beldov',135 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1109,'Marta Richards',135 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1110,'Randy Arlington',143 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1111,'Herbert Berejiklian',143 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1112,'Vartan Berenberg',143 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1113,'Sebouh Bensoul',143 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1114,'Thao Tenorio',163 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1115,'Serop Belmont',163 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1116,'Anoush Serafina',165 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1117,'Marilyn Nakagama',165 )
INSERT INTO Contact ( contact_id, name, cust_id) VALUES ( 1118,'Leilani Gardner',166 )
go
COMMIT WORK
go

INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 300,'Tee Shirt','Small','Casual Warehouse',28,9 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 301,'Tee Shirt','Medium','Casual Warehouse',25,14 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 302,'Tee Shirt','One size fits all','Casual Warehouse',12,14 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 400,'Baseball Cap','One size fits all','Sports Wholesalers',90,9 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 401,'Baseball Cap','One size fits all','Sports Wholesalers',32,10 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 500,'Visor','One size fits all','Sports Wholesalers',49,7 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 501,'Visor','One size fits all','Sports Wholesalers',75,7 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 600,'Sweatshirt','Large','Casual Warehouse',84,24 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 601,'Sweatshirt','Large','Casual Warehouse',93,24 )
INSERT INTO Product ( id, name, size, supplier, quantity, unit_price) VALUES ( 700,'Shorts','Medium','Sports Wholesalers',40,15 )
go

commit work
go

