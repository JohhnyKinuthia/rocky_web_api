---Riders API Queries
  ---Get all riders
SELECT id_number, surname, other_name, mobile_number, loan_amount, loan_status, status_note 
FROM applicant NATURAL JOIN loan;
  ---Get riders by ID
SELECT id_number, surname, other_name, mobile_number, loan_amount, loan_status, status_note 
FROM applicant NATURAL JOIN loan WHERE id_number=$id;
  ---Get the rider's guarantors and return them
  ---Requires the rider's ID as a parameter
SELECT applicant.id_number, surname, other_name, applicant.mobile_number, guarantor_id, name, guarantor.mobile_number 
FROM applicant, guaranteed_loans, guarantor 
WHERE id_number=$id AND applicant.id_number=guaranteed_loans.applicant_id 
AND guaranteed_loans.guarantor_id=guarantor.id_number;
  ---Update the riders details TODO!!

---Guarantors API Queries
  ---Guaranteed loans summary
SELECT guarantor_id, name, guarantor.mobile_number, relationship, applicant_id, surname, other_name, applicant.mobile_number 
FROM applicant, guaranteed_loans, guarantor 
WHERE applicant.id_number=guaranteed_loans.applicant_id 
AND guarantor_id=guarantor.id_number;

  ---Get guarantors Details
SELECT * FROM guarantor;

  ---Get guarantors Details by id
SELECT * FROM guarantor WHERE id_number=$id

  ---Get all riders who the guarantor has guaranteed
SELECT guarantor_id, name, guarantor.mobile_number, relationship, applicant_id, surname, other_name, applicant.mobile_number 
FROM applicant, guaranteed_loans, guarantor 
WHERE applicant.id_number=guaranteed_loans.applicant_id 
AND guarantor_id=guarantor.id_number
AND guarantor_id=$id;
  ---Create a new guarantor
INSERT INTO guarantor VALUES ($id, $name, $mobile_number)

---Loans API Queries
SELECT loan_id, loan_amount, purpose, interest_rate, issue_date, loan_status, status_note, id_number 
FROM loan;
  
  ---Get loan by ID
SELECT loan_id, loan_amount, purpose, interest_rate, issue_date, loan_status, status_note, id_number 
FROM loan WHERE loan_id=$id;

---SQL CREATE
CREATE TABLE IF NOT EXISTS applicant(
    id_number INT PRIMARY KEY,
    surname VARCHAR(20) NOT NULL,
    other_name VARCHAR(50) NOT NULL,
    nationality VARCHAR(20) DEFAULT 'Kenyan',
    no_of_dependents INT DEFAULT 0,
    mobile_number VARCHAR(20),
    alternative_number VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS applicant_address_details(
    postal_address int primary key,
    city VARCHAR(50) NOT NULL,
    code VARCHAR(50) NOT NULL,
    physical_address VARCHAR(30) NOT NULL,
    house_no VARCHAR(20),
    road VARCHAR(80),
    town VARCHAR(50) NOT NULL,
    period_at_current_address int , --in years
    rented NUMERIC(1) NOT NULL,
    id_number int REFERENCES applicant(id_number)
);

CREATE TABLE IF NOT EXISTS loan(
    loan_id INT PRIMARY KEY,
    loan_amount NUMERIC(6, 2),
    purpose TEXT NOT NULL,
    interest_rate NUMERIC(5, 5) NOT NULL DEFAULT 5,
    repayment_period int not null,
    issue_date DATE NOT NULL DEFAULT CURRENT_DATE,
    id_number INT REFERENCES applicant(id_number),
    loan_status VARCHAR(20) CHECK(loan_status IN('approved', 'pending', 'declined')),
    status_note TEXT
);

CREATE TABLE IF NOT EXISTS guarantor(
    id_number INT PRIMARY KEY,
    name text not null,
    mobile_number VARCHAR(13)
);

---Really ambiguous???? Should we put the guarantor id in the loans table instead??
CREATE TABLE IF NOT EXISTS guaranteed_loans(
    applicant_id int REFERENCES applicant(id_number),
    guarantor_id INT REFERENCES guarantor(id_number),
    reationship TEXT NOT NULL,
    PRIMARY KEY(applicant_id, guarantor_id)
);

CREATE TABLE IF NOT EXISTS bank(
    bank_name VARCHAR(80), CHECK(bank_name IN ('Equity bank', 'Cooperative Bank', 'DTB')),--to-be-completed 
    PRIMARY KEY(bank_name)   
);

CREATE TABLE IF NOT EXISTS account_details(
    id int REFERENCES applicant(id_number),
    bank_name VARCHAR(80)  REFERENCES bank(bank_name),
    PRIMARY KEY (id, bank_name)
);

CREATE TABLE IF NOT EXISTS next_of_kin(
    id_number INT PRIMARY KEY,
    surname VARCHAR(50) NOT NULL,
    other_name VARCHAR(80),
    occupation VARCHAR(50),
    place_of_work VARCHAR(50),
    mobile_number VARCHAR(13) NOT NULL
);

CREATE TABLE IF NOT EXISTS applicant_relationship(
    applicant_id_number INT REFERENCES applicant(id_number),
    nok_id_number INT REFERENCES next_of_kin(id_number), --next of kin ID number
    relationship VARCHAR(50) NOT NULL,
    PRIMARY KEY(applicant_id_number, nok_id_number)
);

CREATE TABLE IF NOT EXISTS loan_repayment(
    loan_id INT REFERENCES loan(loan_id),
    paid_amount NUMERIC(9, 2) NOT NULL,
    date_paid DATE NOT NULL,
    paid_by VARCHAR(80) NOT NULL,
    PRIMARY KEY(loan_id)
);

CREATE TABLE IF NOT EXISTS loan_defaulters(
    loan_id INT REFERENCES loan(loan_id),
    amount_due NUMERIC(9, 2),
    days_overdue INT NOT NULL
);
`