# Olirum-Boys

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Repository for **ECM251 T3 & T4**.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This project consists on developing an **API** that connects a website for user-created reviews for games to a database that contains the reviews, games and users via **HTTP requests**.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Code languages being used by this project: **Kotlin**
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Frameworks being used in this project: **Ktor**

&nbsp;

---
## File structure
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the sake of a good organization, the code is divided into some folders for better readability and ease of use. In this section will be located the description for each folder inside the `DatabaseAPI/src/main/kotlin/com/example` directory.

* dao folder
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dao, or Data Access Object, contains the classes used to communicate with database.

* models folder
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Contains the data classes that builds the models for the Game, User and Review objects.

* plugins folder
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Contains the plugins being used by the ktor framework.

* routes folder
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Contains the routing for the HTTP requests.

* shared folder
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File containing the configuration for the database connection.

&nbsp;

---
## GenericDAO
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In this section, it will be disclosed the functions over all the DAO used to trade information with the database.

* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;idSearch() - Retrieves an object where the ID equals to the Integer received.
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;getAll() - Retrieves all the objects contained inside the table.
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;insert() - If the object being received by this function is the same one as the objects contained in this table, this new object will be inserted in the table with an unique id.
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;update() - Updates the object where the ID equals to the Integer received.
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;delete() - Deletes the object where the ID equals to the Integer received.

&nbsp;

---

## Olirum-boys API (Section in development)
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Using the **ktor** framework, it's now possible to retrieve database content via HTTP requests. 

### How to use the API

* Games database
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GET** `localhost:8080/game` - retrieves all the games from the database
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GET** `localhost:8080/game/{id}` - retrieves the game from the specified {id}

&nbsp;

---

## Ktor
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ktor is the framework used to build a **RESTful Application** to retrieve data from the database.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To use this framework, make sure the following dependencies are inside your maven file:

ktor sever core.
```
<dependency>
    <groupId>io.ktor</groupId>
    <artifactId>ktor-server-core</artifactId>
    <version>${ktor_version}</version>
</dependency>
```
ktor plugin for dealing with Json data.
```
<dependency>
    <groupId>io.ktor</groupId>
    <artifactId>ktor-gson</artifactId>
    <version>${ktor_version}</version>
</dependency>
```
Ktor plugin to serialize and deserialize Json data.
```
<dependency>
    <groupId>io.ktor</groupId>
    <artifactId>ktor-serialization</artifactId>
    <version>${ktor_version}</version>
</dependency>
```
Ktor server Netty.
```
<dependency>
    <groupId>io.ktor</groupId>
    <artifactId>ktor-server-netty</artifactId>
    <version>${ktor_version}</version>
</dependency>
```
Ktor for storing logs.
```
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>${logback_version}</version>
</dependency>
```
ktor testing.
```
<dependency>
    <groupId>io.ktor</groupId>
    <artifactId>ktor-server-tests</artifactId>
    <version>${ktor_version}</version>
    <scope>test</scope>
</dependency>
```
Kotlin testing.
```
<dependency>
    <groupId>org.jetbrains.kotlin</groupId>
    <artifactId>kotlin-test</artifactId>
    <version>${kotlin_version}</version>
    <scope>test</scope>
</dependency>
```

&nbsp;

---

## Database creation and connection guide
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In this section will be located how to set up a local database for testing the code. The applications used for this project are the **Oracle VM VirtualBox**, **MariaDB** and **DBeaver**
### Creating and connecting a MariaDB VM to DBeaver

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Start your **Oracle VM VirtualBox** application, click on *File (F)* -> *Import appliance* and select [MariaDB.ova](https://drive.google.com/file/d/1-sGSoNCKoXVH0sUQmkKuJAp3eN5YVJnf/view?usp=sharing).

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Now, select the **MariaDB VM** and click *start*.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;After the VM finishes booting. search for the ip address it's connected. It may appear like this: 192.168.56.XXX.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;With the VM running, open your **Dbeaver** application. Click on *New Database Connection*, and select *MariaDB*.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Write down on **Server Host** the IP address found in the VM, and fill in the authentication forms, then click *finish*.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If the connection was succesfull, on your database navigator, it will show a green icon with the IP address your VM is using.

### Creating the Database

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;With the VM online and connected to **DBeaver**, on database navigator, collapse the itens from the 192.168.56.XXX, right-click the *Databases* folder and select *Create New Database*. For the this project, name your database as olirum_boys.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you wish, you may create your database with the following SQL statement: `CREATE DATABASE olirum_boys`

### Creating the tables.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For this project, we will need three tables. One containing the **Users**, one for the **Reviews** and one for the **Games**.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To create the tables, right click the olirum_boys database on DBeaver, and select **create table**. Now, right click the table, and select *create columns*. Input all the necessary data for the table, and select *save* -> *persist*.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;As a remainder, here are the configuration for each table:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[*column name* [*datatype*] *characteristics* | *description*]

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

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you wish to create using the *SQL editor*, you may copy the following scripts.

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

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;With the database properly set up, to start using it with your code, you may need to make some changes to your code.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;On the *SharedPaths.kt* file, found on *src* -> *main* -> *kotlin* -> *com.example* -> *shared*. change the **JDBC_CONNECTION_STRING** host for the IP address of the VM and port for the port used by the DBeaver connection. Then, input your credentials in the specified place.

On the **pom.xml** file, add the following dependency:

```
<dependency>
    <groupId>org.mariadb.jdbc</groupId>
    <artifactId>mariadb-java-client</artifactId>
	<version>2.7.4</version>
</dependency>
```
