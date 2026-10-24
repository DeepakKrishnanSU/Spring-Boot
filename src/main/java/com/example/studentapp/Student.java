package com.example.studentapp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * Entity class representing a Student record.
 * Mapped to the 'student' table in the 'college' database.
 */
@Entity
@Table(name = "student")
public class Student {

    @Id
    @Column(name = "regno", nullable = false)
    private int regno;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "cgpa", nullable = false)
    private double cgpa;

    // Default No-Argument Constructor required by JPA
    public Student() {
    }

    // Parameterized Constructor
    public Student(int regno, String name, double cgpa) {
        this.regno = regno;
        this.name = name;
        this.cgpa = cgpa;
    }

    // Getters and Setters
    public int getRegno() {
        return regno;
    }

    public void setRegno(int regno) {
        this.regno = regno;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getCgpa() {
        return cgpa;
    }

    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }

    @Override
    public String toString() {
        return "Student{" +
                "regno=" + regno +
                ", name='" + name + '\'' +
                ", cgpa=" + cgpa +
                '}';
    }
}
