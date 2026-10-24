# 🎓 Student Management System — Spring Boot Full-Stack Application
> **Experiment 10:** Spring Boot MVC + Spring Data JPA + Hibernate + PostgreSQL + JSP (Full CRUD & Search)

---

## 📌 Project Overview
This repository contains a production-ready, full-stack **Student Management System** developed in accordance with **Experiment 10** for the Java Full Stack Development curriculum. 

The application implements an enterprise **Layered Architecture** adhering to Spring design patterns, incorporating:
* **Presentation Layer:** Spring MVC Controller routing HTTP requests and binding data to dynamic, responsive JSP views.
* **Service Layer:** Business logic handling data validation, transaction management, and search queries with Constructor-based Dependency Injection.
* **Persistence Layer:** Spring Data JPA Repository abstracting Hibernate ORM for relational persistence.
* **Database Layer:** Standalone PostgreSQL database engine running on port `5432`.

---

## ⚡ Key Features (Full CRUD & Search)

| Operation | HTTP Method | Route URL | Description |
| :--- | :--- | :--- | :--- |
| **Create (Add)** | `GET` / `POST` | `/` $\rightarrow$ `/saveStudent` | Renders registration form; persists new student into PostgreSQL. |
| **Read (View All)** | `GET` | `/students` | Retrieves all student records and renders them in a formatted table. |
| **Search (Filter)** | `GET` | `/students?keyword=...` | Case-insensitive search matching **Student Name** or **Register Number**. |
| **Update (Edit)** | `GET` / `POST` | `/editStudent/{regno}` $\rightarrow$ `/saveStudent` | Pre-fills form with existing student details; updates record upon submission. |
| **Delete** | `GET` | `/deleteStudent/{regno}` | Prompts a confirmation dialog and deletes the student by primary key (`regno`). |

---

## 🏗️ Technology Stack

* **Core Framework:** Spring Boot `3.4.3`
* **Web & MVC:** Spring Web MVC (`@Controller`, `@ModelAttribute`, `@PathVariable`, `@RequestParam`)
* **ORM & Data Access:** Hibernate `6.6.x` / Spring Data JPA (`JpaRepository`)
* **View Engine:** Embedded Apache Tomcat Jasper + Jakarta Servlet JSTL
* **Database Engine:** PostgreSQL (standalone engine on port `5432`)
* **Build System:** Apache Maven (configured with Maven Wrapper `mvnw.cmd`)
* **Java Runtime:** Java SE 17+ (compiled for Java 17 release compatibility)
* **IDE Compatibility:** Eclipse IDE for Enterprise Java and Web Developers / Spring Tool Suite (STS)

---

## 📂 Project Directory Structure

```text
StudentManagementSystem/
│
├── .mvn/wrapper/                       # Maven Wrapper binaries & properties
├── .settings/                          # Eclipse WTP & JDT compiler facet settings
├── .classpath                          # Eclipse project classpath configuration
├── .project                            # Eclipse project descriptor metadata
├── pom.xml                             # Maven build configuration & dependencies
├── README.md                           # Project documentation & execution guide
├── database.sql                        # PostgreSQL schema definition & DDL script
│
├── start-database.bat                  # 1-Click script to launch PostgreSQL on port 5432
├── stop-database.bat                   # 1-Click script to stop PostgreSQL
├── view-database.bat                   # 1-Click interactive psql console into 'college' DB
│
└── src/
    ├── main/
    │   ├── java/com/example/studentapp/
    │   │   ├── Student.java                    # JPA Entity mapped to 'student' table
    │   │   ├── StudentRepository.java          # Spring Data JPA interface
    │   │   ├── StudentService.java             # Service layer with CRUD & search logic
    │   │   ├── StudentController.java          # Spring MVC routing controller
    │   │   ├── StudentApplication.java         # Main Spring Boot entry point
    │   │   └── ServletInitializer.java         # WAR bootstrapper for embedded Tomcat JSP
    │   │
    │   ├── resources/
    │   │   └── application.properties          # DataSource, Hibernate & ViewResolver config
    │   │
    │   └── webapp/WEB-INF/views/
    │       ├── student-form.jsp                # Responsive form (Add & Update modes)
    │       └── student-list.jsp                # Responsive table (Search, Edit, Delete)
    │
    └── test/java/com/example/studentapp/
        └── StudentApplicationTests.java        # Test directory structure
```

---

## 🗄️ Database Architecture & Schema

### PostgreSQL Connection Details
* **Host / Port:** `localhost:5432`
* **Database Name:** `college`
* **Table Name:** `student`
* **Username:** `postgres`
* **Password:** `vmax`
* **JDBC URL:** `jdbc:postgresql://localhost:5432/college`

### DDL Schema (`database.sql`)
```sql
CREATE DATABASE college;

-- Connect to 'college' database and execute:
CREATE TABLE IF NOT EXISTS student (
    regno INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cgpa DOUBLE PRECISION NOT NULL
);
```

---

## 🚀 Execution Guide (Eclipse IDE)

### Step 1: Ensure PostgreSQL is Running
PostgreSQL runs as a background service on port `5432`.
* If you recently rebooted your computer, open this folder in **Windows File Explorer** and double-click:
  ```text
  start-database.bat
  ```
* The script checks port `5432`, starts the engine if not already running, and outputs:
  ```text
  [SUCCESS] PostgreSQL is RUNNING and READY on port 5432!
  ```

---

### Step 2: Import Project into Eclipse
1. Launch **Eclipse IDE**.
2. Navigate to: **`File`** $\rightarrow$ **`Open Projects from File System...`**
3. Click **`Directory...`** and select the project directory:
   ```text
   C:\Users\shiro\OneDrive\Desktop\Education\4th Year\Java Full Stack Development\Ex10\StudentManagementSystem
   ```
4. Click **`Finish`**.
5. Eclipse will automatically load the project with pre-configured Maven dependencies and Eclipse Dynamic Web facets.

---

### Step 3: Launch the Application
1. In the Eclipse **Project Explorer**, expand:
   `StudentManagementSystem` $\rightarrow$ `src/main/java` $\rightarrow$ `com.example.studentapp`
2. Right-click on **`StudentApplication.java`**.
3. Select **`Run As`** $\rightarrow$ **`Java Application`** (or **`Spring Boot App`**).
4. Monitor the Eclipse **Console** tab until you see:
   ```text
   Tomcat started on port 8080 (http) with context path '/'
   Started StudentApplication in ... seconds
   ```

---

### Step 4: Access in Web Browser

* **Registration Form (Add Student):**  
  [http://localhost:8080/](http://localhost:8080/)
  * Fill in `Register Number`, `Name`, and `CGPA`.
  * Click **Register Student**.

* **Student Records Table (View / Search / Edit / Delete):**  
  [http://localhost:8080/students](http://localhost:8080/students)
  * **Search:** Type a name or register number into the search bar and click **Search**.
  * **Edit:** Click the **Edit** button on any row to open the pre-filled update form.
  * **Delete:** Click the **Delete** button to remove a record after browser confirmation.

---

## 🔍 How to Demonstrate Live Database Updates to Faculty

When the faculty asks to verify that records are genuinely updating inside PostgreSQL:

### Method 1: Interactive Terminal via `view-database.bat`
1. In Windows File Explorer, double-click **`view-database.bat`**.
2. A command window opens directly connected to the PostgreSQL `college` database, printing the live table.
3. Perform an Add, Edit, or Delete in your browser.
4. In the `view-database.bat` window, execute:
   ```sql
   SELECT * FROM student ORDER BY regno ASC;
   ```
5. The updated rows will be displayed directly from PostgreSQL.

### Method 2: Live Hibernate SQL in Eclipse Console
Because `spring.jpa.show-sql=true` and `spring.jpa.properties.hibernate.format_sql=true` are configured in `application.properties`, every action triggers formatted SQL logs in Eclipse:
* **Insert:** `insert into student (cgpa, name, regno) values (?, ?, ?)`
* **Update:** `update student set cgpa=?, name=? where regno=?`
* **Delete:** `delete from student where regno=?`

---

## ❓ Frequently Asked Viva / Oral Questions

* **Q: How are you running PostgreSQL without installing the full GUI software?**  
  * **Answer:** *"I am running the official standalone PostgreSQL engine as a background service listening on port 5432. Spring Boot connects to it directly through the standard JDBC driver (`jdbc:postgresql://localhost:5432/college`)."*
* **Q: Why is the packaging configured as `war` instead of `jar` in `pom.xml`?**  
  * **Answer:** *"Embedded Tomcat Jasper requires WAR packaging and a `SpringBootServletInitializer` to resolve and compile `.jsp` files reliably at runtime."*
* **Q: What is Dependency Injection (DI) and where is it used?**  
  * **Answer:** *"Spring automatically provides instantiated dependencies to classes rather than manually using the `new` keyword. Constructor injection is implemented in both `StudentService` (injecting `StudentRepository`) and `StudentController` (injecting `StudentService`)."*
* **Q: What is the difference between `@Controller` and `@RestController`?**  
  * **Answer:** *"A `@Controller` returns view names (such as JSP templates) to be rendered by a ViewResolver, whereas `@RestController` combines `@Controller` and `@ResponseBody` to return raw JSON or XML data directly to HTTP clients."*
