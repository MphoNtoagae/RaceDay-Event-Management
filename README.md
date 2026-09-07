# RaceDay Event Management System

## Project Overview

RaceDay is a web-based event management system designed for running, walking, and cycling events in South Africa. The system allows organisers to manage events, categories, participant enrolments and results, while participants can register for events and view their results.

## Part 1 – System Planning and Database

This repository contains the planning and database work completed for Part 1 of the RaceDay project.

### Included Work

- Entity Relationship Diagram (ERD)
- API Endpoint Plan
- SQL Server Database Script
- Database tables, relationships and constraints
- Sample data for organisers, participants, events, categories, enrolments and results

## Database

The database was developed using Microsoft SQL Server and includes the following main entities:

- Role
- User
- Event
- Category
- Enrollment
- Result
- EventWeather

The database uses primary keys, foreign keys, unique constraints, NOT NULL constraints and default values to maintain data integrity.

## API

The API Endpoint Plan covers:

- User registration and login
- User profiles
- Event management
- Event categories
- Participant enrolments
- Event results

## Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- GitHub
- REST API planning

## Project Structure

```text
RaceDay-Event-Management/
├── docs/
│   ├── RaceDay_ERD.png
│   ├── API_Endpoint_Plan.docx
│   └── RaceDay_Database.sql
├── .github/
│   └── workflows/
└── README.md
