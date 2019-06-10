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

