# Olirum-Boys
Repository for ECM251 T3 & T4.
This project consists on developing an API that connects a website for user-created reviews for games to a database that contains the reviews, games and users written in Kotlin.

---

## Database creation and connection guide

### Creating and connecting a MariaDB VM to DBeaver

Start your **Oracle VM VirtualBox** application, click on **File (F)** -> **Import appliance** and select [MariaDB.ova](https://drive.google.com/file/d/1-sGSoNCKoXVH0sUQmkKuJAp3eN5YVJnf/view?usp=sharing).
Now, select the MariaDB VM and click start.

After the VM finishes booting. search for the ip address it's connected. It may appear like this: 192.168.56.XXX.

With the VM running, open your **Dbeaver** application. Click on *New Database Connection*, and select MariaDB.
Write down on **Server Host** the IP address found in the VM, and fill in the authentication forms, then click finish.

If the connection was succesfull, on your database navigator, it will show a green icon with the IP address your VM is using.

### Creating the Database

With the VM online and connected to DBeaver, on database navigator, collapse the itens from the 192.168.56.XXX, right-click the *Databases* folder and select **Create New Database**. For the sake of this project, name your database as olirum_boys.

If you wish, you may create your database with the following SQL statement: `CREATE DATABASE olirum_boys`

### Creating the tables.

For this project, we will need three tables. One containing the Users, one for the Reviews and one for the Games.

To create the tables, right click the olirum_boys database on DBeaver, and select **create table**. Now, right click the table, and select **create columns**. Input all the necessary data for the table, and select *save* -> *persist*.

As a remainder, here are the configuration for each table:
[*column name [datatype] characteristics | description*]

**Games:**
* game_id [INT] not null, auto increment | ID for game identification
* game_name [varchar] not null | Name of the game
* developer [varchar] | Developer of the game
* genre [varchar] | Game genre

**Reviews**
* review_id [INT] not null, auto increment | ID for review identification
* user_id [INT] not null | ID of the user who created the review
* game_id [INT] not null | ID of the game being reviewed
* review_body [TEXT] | Contain the content of the review
* score [INT] not null | Review score of the game

**Users**
* user_id [INT] not null, auto increment | ID for user identification
* user_name [varchar] not null | Username
* user_pwd [varchar] not null | Password

If you wish to create using the SQL editor, you may copy the following scripts.

##### Games table

```
CREATE TABLE olirum_boys.Games (
 	game_id INT(11) NOT NULL AUTO_INCREMENT,
 	game_name varchar(100) NOT NULL,
 	developer varchar(100),
 	genre varchar(100),
 	PRIMARY KEY (game_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
```

##### Reviews table

```
CREATE TABLE olirum_boys.Reviews (
	review_id INT(11) NOT NULL AUTO_INCREMENT,
	user_id INT(11) NOT NULL,
	game_id INT(11) NOT NULL,
	review_body TEXT,
	score INT(11) NOT NULL,
	PRIMARY KEY (review_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
```

##### Users table

```
CREATE TABLE olirum_boys.Users (
 	user_id INT(11) NOT NULL AUTO_INCREMENT,
	user_name varchar(100) NOT NULL,
	user_pwd varchar(100) NOT NULL,
	PRIMARY KEY (user_id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
```

### Connecting your code with the database.

With the database properly set up, to start using it with your code, you may need to make some changes to your code.

On the *SharedPaths.kt* file, found on src -> main -> kotlin -> shared. change the **JDBC_CONNECTION_STRING** host for the IP address of the VM and port for the port used by the DBeaver connection. Then, input your credentials in the specified place.

On the **pom.xml** file, add the following dependency:

```
<dependency>
    <groupId>org.mariadb.jdbc</groupId>
    <artifactId>mariadb-java-client</artifactId>
	<version>2.7.4</version>
</dependency>
```