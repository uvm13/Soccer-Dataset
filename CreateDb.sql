-- Create Database
CREATE DATABASE SoccerDB;
GO

-- Use the database
USE SoccerDB;
GO

-- Create Teams table
CREATE TABLE Teams (
    TeamID INT IDENTITY(1,1) PRIMARY KEY,
    TeamName NVARCHAR(100) NOT NULL,
    City NVARCHAR(100),
    FoundedYear INT
);
GO
----------- Insert Teams
INSERT INTO Teams (TeamName, City, FoundedYear)
VALUES 
('Manchester United', 'Manchester', 1878),
('Liverpool FC', 'Liverpool', 1892),
('Chelsea FC', 'London', 1905),
('Arsenal FC', 'London', 1886);
GO


-- Create Players table
CREATE TABLE Players (
    PlayerID INT IDENTITY(1,1) PRIMARY KEY,
    TeamID INT FOREIGN KEY REFERENCES Teams(TeamID),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    JerseyNumber INT,
    Nationality NVARCHAR(50),
    DateOfBirth DATE
);
GO
-------- Insert Players
INSERT INTO Players (TeamID, FirstName, LastName, Position, JerseyNumber, Nationality, DateOfBirth)
VALUES
(1, 'Marcus', 'Rashford', 'Forward', 10, 'England', '1997-10-31'),
(1, 'Bruno', 'Fernandes', 'Midfielder', 8, 'Portugal', '1994-09-08'),
(2, 'Mohamed', 'Salah', 'Forward', 11, 'Egypt', '1992-06-15'),
(2, 'Virgil', 'van Dijk', 'Defender', 4, 'Netherlands', '1991-07-08'),
(3, 'Raheem', 'Sterling', 'Forward', 7, 'England', '1994-12-08'),
(4, 'Bukayo', 'Saka', 'Midfielder', 7, 'England', '2001-09-05');
GO

-- Create Matches table
CREATE TABLE Matches (
    MatchID INT IDENTITY(1,1) PRIMARY KEY,
    HomeTeamID INT FOREIGN KEY REFERENCES Teams(TeamID),
    AwayTeamID INT FOREIGN KEY REFERENCES Teams(TeamID),
    MatchDate DATE,
    Stadium NVARCHAR(100),
    HomeScore INT DEFAULT 0,
    AwayScore INT DEFAULT 0
);
GO
----
-- Insert Matches
INSERT INTO Matches (HomeTeamID, AwayTeamID, MatchDate, Stadium, HomeScore, AwayScore)
VALUES
(1, 2, '2025-03-15', 'Old Trafford', 2, 1),
(3, 4, '2025-03-16', 'Stamford Bridge', 1, 1);
GO




-- Create Goals table
CREATE TABLE Goals (
    GoalID INT IDENTITY(1,1) PRIMARY KEY,
    MatchID INT FOREIGN KEY REFERENCES Matches(MatchID),
    PlayerID INT FOREIGN KEY REFERENCES Players(PlayerID),
    MinuteScored INT CHECK (MinuteScored BETWEEN 1 AND 120),
    IsOwnGoal BIT DEFAULT 0
);
GO


-- Insert Goals
INSERT INTO Goals (MatchID, PlayerID, MinuteScored)
VALUES
(1, 1, 23),
(1, 3, 45),
(1, 2, 78),
(2, 5, 60),
(2, 6, 75);
GO
