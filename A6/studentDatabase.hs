-- File Name: studentDatabase.hs
-- Author: David Kreiser
-- Class: CMPT 340 Tutorial 5
-- NB: Incomplete - to be completed during lab 5 (see slides 10-11)

-- Define some type synonyms to make values more clear
type Name = String
type NSID = String
type IDNum = Integer

type Grade = Integer
type Total = Integer

type Marks = [(Grade,Total)]

-- Define a new Student data type with two types of students
data Student = Active Name NSID IDNum Marks
             | Withdrawn Name NSID IDNum

-- Define our own show function for the Student datatype
instance Show Student where
    show (Active a b c d)  = "Name: " ++ a ++ " | NSID: " ++ b ++ " | IDNum: " ++ (show c) ++ " | Status: Active Student | Marks: " ++ (show d)
    show (Withdrawn a b c) = "Name: " ++ a ++ " | NSID: " ++ b ++ " | IDNum: " ++ (show c) ++ " | Status: Withdrawn Student"

-- Define a Course data type with only one possible value. Each course has a Name string and a list of Students
data Course = Course Name [Student]

-- Define our own show function for the Course datatype
instance Show Course where
    show (Course a b) = "Course: " ++ a ++ " -- " ++ (printStudentsByLine b "Students Enrolled:\n")

-- Helper function which prints a lists of students indented and each on a separate line
printStudentsByLine :: [Student] -> String -> String
printStudentsByLine [] s = s
printStudentsByLine (x:xs) s = printStudentsByLine xs ( s ++ "    " ++ (show x) ++ "\n" )

-- 2. Define what "equality" means for Student and Course types

instance Eq Student where
	(==) = studentEquality 

studentEquality :: Student -> Student -> Bool
studentEquality (Active _ _ id1 _) (Active _ _ id2 _)       = id1 == id2
studentEquality (Withdrawn _ _ id1) (Withdrawn _ _ id2) = id1 == id2


-- Define some students for testing purposes
sarah :: Student
sarah   = Active "Sarah Smith" "sas343" 11121364 [(10,10),(6,6),(0,10),(8,10)]

alex :: Student
alex    =  Active "Alex Murphy" "aum400" 11121489 [(8,10),(4,6),(3,10),(4,10)]

emily :: Student
emily   = Active "Emily Lam" "eol223" 11142109 [(2,10),(5,6),(9,10),(8,10)]

nathan :: Student
nathan  = Active "Nathan Martin" "nem055" 11199032 [(9,10),(5,6),(2,10),(8,10)]

emma :: Student
emma    = Active "Emma Brown" "emb675" 11149502 [(5,10),(4,6),(5,10),(10,10)]

david :: Student 
david   = Active "David Roy" "dlr120" 11173800 [(7,10),(3,6),(6,10),(6,10)]

jessica :: Student
jessica = Withdrawn "Jessica Tremblay" "jet747" 11184823 

hannah :: Student
hannah  = Withdrawn "Hannah Wilson" "haw002" 11103953

-- Define some courses for testing purposes
cmpt340 :: Course
cmpt340 = Course "CMPT 340" [sarah,alex,emily,nathan,emma,david,jessica,hannah]

cmpt498 :: Course
cmpt498 = Course "CMPT 498" [hannah,emma,david,sarah]

-- 3. Write a function which checks if a student is Active or Withdrawn
isActive :: Student -> Bool
isActive (Active _ _ _ _) = True
isActive _                   = False


-- 4. Write a function which displays a student's marks
getMarks :: Student -> Marks
getMarks (Active _ _ _ m) = m
getMarks (Withdrawn _ _ _) = []



-- 5. Write a function which calculates the percentage value for each of a Student's marks (e.g. (5,10) would become 50.0)
getPercentMarks :: Student -> [Double]
getPercentMarks s = calculatePercentage (getMarks s) 
      where calculatePercentage :: Marks -> [Double]
            calculatePercentage []     = []
            calculatePercentage (x:xs) = (divPair x) * 100 : (calculatePercentage xs)
            divPair :: (Grade,Total) -> Double
            divPair (a,b) = (fromIntegral a) / (fromIntegral b)
           

-- 6. Write a function which calculates a Student's average mark as a percentage
getAverage :: Student -> Double
getAverage s = calculateAverage (getPercentMarks s)
       where calculateAverage :: [Double] -> Double
             calculateAverage [] = 0 
             calculateAverage marks = (sum marks) / (fromIntegral(length marks))


-- 7. Write a function which calculates the average of a Course as a percentage (average of all the Student averages in the class)
courseAverage :: Course -> Double
courseAverage (Course _ []) = 0
courseAverage (Course _ StudentList) = calculateCourseAverage studentList 0.0
        where 





