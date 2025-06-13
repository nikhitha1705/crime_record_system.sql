# Crime Record Management System (SQL Project)

##  Description
This project manages criminal records, FIRs, and case investigations using SQL. It includes officers, criminals, FIRs, and case tracking.

## Database Structure

- **Officers**: Officer details (ID, name, rank, department)
- **Criminals**: Criminal details (ID, name, age, gender, crime)
- **FIRs**: FIRs filed against criminals
- **Cases**: Case status and timeline (open/closed)
- **CaseUpdates**: Updates made to each case by officers

## Sample Queries
- Open cases with `NULL` close date handled using `IFNULL()`
- Case updates with officer names using `JOIN`
- FIRs with officer and criminal names
- Total cases filed by each officer

##  How to Run
Use any MySQL-compatible SQL execution environment. Remove `CREATE DATABASE` and `USE` lines if your platform doesn’t support them.

##  Author
**Nikhitha**  
Final Year B.Tech | Computer Science & AI  
nikhithak1705@gmail.com  

