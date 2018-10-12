DROP​​ TABLE​ office_hours; --Delete the table if it was previously created

--Create the new table for office hours schedule
CREATE ​​TABLE​ office_hours ( 
        id ​INT​​ IDENTITY​(​1​,​1​) ​PRIMARY ​​KEY​,     
        faculty_name ​VARCHAR​(​64​) NOT NULL,      
        faculty_position ​VARCHAR​(​32​) ​DEFAULT​​ 'TA'​,      
        location ​VARCHAR​(​64​) NOT NULL,      
        weekday ​VARCHAR​(​2​) NOT NULL,      
        start_time ​TIME​ NOT NULL,      
        end_time ​TIME​ NOT NULL,​ 
    CONSTRAINT CHK_non_empty_values ​CHECK​(     
        LEN(faculty_name) > ​0​ AND      
        LEN(location) > ​0​ AND      
        LEN(faculty_position) > ​0  
    ),​
    --Only accept weekday values corresponding to Monday through Friday
​    CONSTRAINT​ CHK_weekday_value ​CHECK​ (weekday IN (​'M'​, ​'T'​, ​'W'​, ​'TR'​, ​'F'​)),
    ​--Only accept start_time and end_time which differ by at least 30 minutes​
    CONSTRAINT​ CHK_time_duration ​CHECK​ (DATEDIFF(​minute​, start_time, end_time) >= ​30​)
);

--Insert an entry into the table
INSERT​​ INTO​ office_hours (faculty_name, location, weekday, start_time, end_time) 
    ​VALUES​ (​'Taras Basiuk'​, ​'DEH 115'​, ​'M'​, ​'12:00:00'​, ​'13:00:00');

--Insert multiple records at once
INSERT​​ INTO​ office_hours (faculty_name, location, weekday, start_time, end_time)
VALUES 
    (​'Taras Basiuk'​, ​'DEH 115'​, ​'W'​, ​'12:00:00'​, ​'13:00:00'​), 
    (​'Taras Basiuk'​, ​'DEH 115'​, ​'F'​, ​'12:00:00'​, ​'13:00:00'​), 
    (​'Naveen Kumar'​, ​'DEH 115'​, ​'T'​, ​'10:00:00'​, ​'10:45:00'​), 
    (​'Naveen Kumar'​, ​'DEH 115'​, ​'T'​, ​'10:00:00'​, ​'10:45:00'​), 
    (​'Naveen Kumar'​, ​'DEH 115'​, ​'TR'​, ​'14:00:00'​, ​'14:45:00'​), 
    (​'Naveen Kumar'​, ​'DEH 115'​, ​'TR'​, ​'14:00:00'​, ​'14:45:00'​), 
    (​'Le Gruenwald'​, ​'DEH 233'​, ​'M'​, ​'15:00:00'​, ​'16:00:00'​), 
    (​'Le Gruenwald'​, ​'DEH 233'​, ​'W'​, ​'15:00:00'​, ​'16:00:00'​);

--Insert multiple records at once
INSERT ​​INTO​ office_hours 
    (faculty_name, faculty_position, location, weekday, start_time, end_time)
VALUES 
    (​'Humberlito Borges'​, ​'Striker'​, ​'DEH 115'​, ​'M'​, ​'09:00:00'​, ​'10:00:00'​), 
    (​'John Bahnsen'​, ​'General'​, ​'DEH 115'​, ​'F'​, ​'11:00:00'​, ​'12:00:00'​), 
    (​'Vidya Beniwal'​, ​'Politician'​, ​'DEH 115'​, ​'TR'​, ​'08:00:00'​, ​'09:30:00'​);
    
--List all the records in the table
SELECT​ * ​FROM​ office_hours;

--Let’s update and clean some things up
UPDATE​ office_hours
SET​ faculty_position = ​'Professor'
WHERE​ faculty_name = ​'Le Gruenwald'​;

/*
DELETE ​​FROM​ office_hours
WHERE​ faculty_position NOT IN (​'Professor'​, ​'TA'​);


--Let’s make sure only professors and TAs are added from now on
ALTER ​​TABLE​ office_hours
ADD​​ CONSTRAINT​ CHK_faculty_position ​CHECK​ (   
    faculty_position IN (​'Professor'​, ​'TA'​)
);

--Let’s find office hours appointment on a given day within some time interval
DECLARE​ @day ​varchar​ = ​'W'​;
DECLARE​ @from ​time​ = ​'12:30:00'​;
DECLARE​ @to ​time​ = ​'17:00:00'​;

SELECT   
    max_meeting_duration_mins = DATEDIFF(​minute​, start_time, end_time)       
        - IIF(DATEDIFF(​minute​, start_time, @from) > ​0​, DATEDIFF(​minute​, start_time,
            @from), ​0​)       
        - IIF(DATEDIFF(​minute​, @to, end_time) > ​0​, DATEDIFF(​minute​, @to, end_time), ​0​),   
    faculty_name,   
    faculty_position,   
    location,   
    start_time,   
    end_time
FROM​ office_hours
WHERE​ weekday = @day AND start_time < @to AND end_time > @from
ORDER ​​BY​ max_meeting_duration_mins ​DESC​; 
​--Return results in descending order of max meeting duration*/