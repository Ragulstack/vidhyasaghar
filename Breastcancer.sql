--Average avg of patient
/*select avg(cast(age as int)) as AVG_age
from dbo.Breast_Cancer*/

-- What is the distribution of age types in the dataset?

SELECT Agetype, COUNT(*) AS Agetype_Count
FROM Dbo.Breast_Cancer
GROUP BY Agetype;


-- How does the TStage vary across different age types?

SELECT Agetype, TStage, COUNT(*) AS Tstage_Age_Count
FROM Dbo.Breast_Cancer
GROUP BY Agetype, TStage;


-- How does the NStage vary across different age types?

SELECT Agetype, NStage, COUNT(*) AS Nstage_Age_Count
FROM Dbo.Breast_Cancer
GROUP BY Agetype, NStage;


-- Is there a relationship between age type and TumorSize?

SELECT Agetype, avg(cast(TumorSize as float)) AS Average_TumorSize
FROM Dbo.Breast_Cancer
GROUP BY Agetype;


-- Are there any differences in TStage or NStage based on race or MaritalStatus?

SELECT Race, MaritalStatus, TStage, NStage
FROM Dbo.Breast_Cancer;

-- Is there a correlation between the grade of the tumor and the TStage or NStage?

SELECT Grade, TStage, NStage
FROM Dbo.Breast_Cancer;


-- How does the survival months differ based on TStage and NStage?

SELECT TStage, NStage, AVG(cast(SurvivalMonths as float)) AS Average_Survival_Months
FROM Dbo.Breast_Cancer
GROUP BY TStage, NStage;


--Is there a relationship between the estrogen/progesterone status and TStage or NStage?

SELECT EstrogenStatus, ProgesteroneStatus, TStage, NStage
FROM Dbo.Breast_Cancer;


--How many regional nodes were examined for each age type?

SELECT Agetype, SUM(cast(RegionalNodeExamined as int)) AS Total_Regional_Nodes
FROM Dbo.Breast_Cancer
GROUP BY Agetype;


-- Are there any patterns or relationships between TStage, NStage, and the differentiation grade?

SELECT TStage, NStage, Differentiate, Grade
FROM Dbo.Breast_Cancer;


/*CREATE VIEW BreastCancerAnalysisView AS
SELECT 
    Agetype,
    COUNT(*) AS AgeDistribution,
    TStage AS TStageVariation,
    NStage AS NStageVariation,
    AVG(CAST(TumorSize AS FLOAT)) AS Average_TumorSize,
    Race,
    MaritalStatus,
    TStage AS TStageNStage,
    NStage AS NStageNStage,
    Grade,
    AVG(CAST(SurvivalMonths AS FLOAT)) AS Average_Survival_Months,
    EstrogenStatus,
    ProgesteroneStatus,
    Agetype AS Total_Regional_Nodes_Agetype,
    SUM(CAST(RegionalNodeExamined AS INT)) AS Total_Regional_Nodes,
    TStage AS TStageDifferentiateGrade,
    NStage AS NStageDifferentiateGrade,
    Differentiate
FROM dbo.Breast_Cancer
GROUP BY 
    Agetype,
    TStage,
    NStage,
    Grade,
    Race,
    MaritalStatus,
    EstrogenStatus,
    ProgesteroneStatus,
    Differentiate;*/






