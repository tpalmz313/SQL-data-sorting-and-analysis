DROP TABLE IF EXISTS card_holder CASCADE;
DROP TABLE IF EXISTS merchant CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS transaction CASCADE;
DROP TABLE IF EXISTS merchant_category CASCADE;


-- Tables 
CREATE TABLE card_holder (
	id INT NOT NULL,
    name VARCHAR(30) NOT NULL,
	
    CONSTRAINT pk_card_holder PRIMARY KEY (id)
);

CREATE TABLE merchant (
    id INT  NOT NULL,
	name VARCHAR(40)  NOT NULL,
    id_merchant_category int   NOT NULL,
    CONSTRAINT pk_merchant PRIMARY KEY (id)
);

CREATE TABLE credit_card (
    card VARCHAR   NOT NULL,
    cardholder_id INT   NOT NULL,
    CONSTRAINT pk_credit_card PRIMARY KEY (card)
);

CREATE TABLE transaction (
    id INT   NOT NULL,
    date TIMESTAMP  NOT NULL,
    amount FLOAT   NOT NULL,
    card VARCHAR   NOT NULL,
    id_merchant INT   NOT NULL,
    CONSTRAINT pk_transaction PRIMARY KEY (id)
);

CREATE TABLE merchant_category (
    id INT   NOT NULL,
    Name VARCHAR   NOT NULL,
    CONSTRAINT pk_merchant_category PRIMARY KEY (id)
);

ALTER TABLE merchant ADD CONSTRAINT fk_merchant_id_merchant_category FOREIGN KEY(id_merchant_category)
REFERENCES merchant_category (id);

ALTER TABLE credit_card ADD CONSTRAINT fk_credit_card_cardholder_id FOREIGN KEY(cardholder_id)
REFERENCES card_holder (id);



ALTER TABLE transaction ADD CONSTRAINT fk_transaction_id_merchant FOREIGN KEY(id_merchant)
REFERENCES merchant (id);

ALTER TABLE transaction ADD CONSTRAINT fk_transaction_card FOREIGN KEY(card)
REFERENCES credit_card (card);

