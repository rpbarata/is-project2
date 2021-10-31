# Integração de Sistemas

### Assignment #2 - Three-tier Programming with Object-Relational Mapping

In this project, students will develop a web application to manage a bus company. The set of operations of this application is essentially limited to the purchase of tickets. Next, we go through the requirements of this application. Feel free to add some more functionality that you may need:

**Requirements**

- [X] As an unregistered user, I want to create an account, and insert my personal information, including email.
- [ ] To create manager accounts the system should use a script, e.g., written in JPA.
- [X] As an unauthenticated user, I must only have access to the login/register screen.
- [X] As a user, I want to authenticate and start a session with my e-mail and password.
- [X] As a user, I want to logout from any location or screen.
- [X] As a user, I want to edit my personal information.
- [X] As a user, I want to delete my account, thus erasing all traces of my existence from the system, including my available items.
- [X] As a user, I want to list the available trips, providing date intervals.
- [X] As a user, I want to charge my wallet to be able to purchase tickets. (You may ignore the step that involves the payment itself)
- [X] As a user, I want to purchase a ticket. I should be able to select the place.
- [X] As a user, I may be able to return a ticket for future trips and get a reimbursement in my wallet.
- [X] As a user, I can list my trips.
- [ ] As a company manager, I want to create future bus trips, including the departure date and hour, departure point, destination, capacity, and price. You may assume that departure and destination points are limited.
- [ ] As a company manager, I want to delete future bus trips. The money of all tickets should be returned to the correct wallets, and the system should warn the affected users by email.
- [ ] As a company manager I want to list the passengers that have made more trips (e.g., the top 5).
- [ ] As a company manager I want to search for all bus trips sorted by date between two date limits.
- [ ] As a company manager I want to search for all bus trips occurring on a given date.
- [ ] As a company manager I want to list all passengers on a given trip listed during one of the previous searches.
- [ ] The system sends a daily summary of the revenues of that day’s trips to the managers.

**Additional Remarks**

Finally, the following points apply:

- **Passwords should not be stored in clear text**. Students should store hashed passwords in the database.
- **Students must use a logging tool**.
- Students should be very careful about choosing between stateless beans and stateful beans. Also, they should be very careful about `<ins>`not passing huge amounts of information between application layers (e.g., in queries)`</ins>`, when they don’t need to.
- Students should be careful to avoid violating layers, e.g., they must not perform business logic operations in the presentation layer.
- Students need to `<ins>`be careful about authentication `</ins>` when they access the EJBs. They must verify each access to protected resources, or otherwise anyone could do a lookup to invoke an EJB.
- Consider the possibility of developing an entire text-based interface, starting only the web tier after the implementation of the most important functionality. Please note that the weight of the web interface in the final grade is small.

## Setup with Docker (recommended)

1. Make sure you have your ssh keys in the home folder of the OS that is running docker

### Linux/Mac

1. Install `docker`, `docker-compose`, `VScode` (optional)
2. Install `Remote - Containers` VScode extension (optional)

### Windows

1. Follow https://docs.microsoft.com/en-us/windows/wsl/install-win10#manual-installation-steps` instructions
2. Install `Docker Desktop`, `VScode`
3. Clone project inside a WSL folder subsystem (\\\wsl$\Ubuntu)
4. Enable WSL Integration with the installed distro in Docker Desktop, Settings, Resourses, WSL Integration

### General

1. Ask for the .env file and paste it in the current folder
2. Open `VScode` and install `Remote - Containers` vscode extension
3. In the lower left corner, there will be a green area. Press it and select `Remote-Containers: Reopen in Container`
4. In the bottom right corner, there will be a popup to install the recommended extensions
5. A terminal should also be visible with 3 options, choose option `q`

## Setup without Docker

[TODO]

---

Try it at http://localhost:3000/

**Important**
Ask your team for the .env file

## Branch naming and MRs properties

- **Branch name** \<prefix\>/\<snake_cased_task_title\>
- **MR name** Task title
- **MR assignee** Person responsible for the MR code
- **MR label** Type

|    Types    |   Prefix   |                                      Description                                      |
| :---------: | :---------: | :-----------------------------------------------------------------------------------: |
|   Bugfix   |   bugfix   |                Code previously written that is not working as intended                |
|   Feature   |   feature   |                          Code to create a new functionality                          |
| Improvement | improvement | Code clean up or adaptations to improve code readability, organization or performance |
|   Styling   |   styling   |                         Code purely dedicated to stylization                         |

## Labeled commentaries

|  Types  |                                         Description                                         |
| :------: | :------------------------------------------------------------------------------------------: |
|   NOTE   |                              Description of how the code works                              |
|  REVIEW  |                                     Needs to be verified                                     |
|   HACK   |             Not very well written or malformed code to circumvent a problem/bug             |
|  FIXME  |                       This works, sort of, but it could be done better                       |
|   BUG   |                                   There is a problem here                                   |
|   TODO   | No problem, but additional code needs to be written, usually when you are skipping something |
| OPTIMIZE |                             No problem, but code can be improved                             |
|  FUTURE  |                          Changes that should be made in the future                          |
