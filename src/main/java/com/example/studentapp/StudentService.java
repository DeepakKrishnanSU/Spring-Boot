package com.example.studentapp;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;

/**
 * Service Layer for Student CRUD and Search operations.
 * Manages business logic and interacts with the StudentRepository.
 */
@Service
public class StudentService {

    private final StudentRepository studentRepository;

    // Constructor Injection (recommended Spring Boot practice)
    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    /**
     * Add or Update a student record in PostgreSQL.
     * @param student The student object to save or update.
     * @return Saved Student entity.
     */
    public Student saveStudent(Student student) {
        return studentRepository.save(student);
    }

    /**
     * Fetch all student records from PostgreSQL.
     * @return List of all students.
     */
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    /**
     * Find a student by their Register Number (Primary Key).
     * @param regno Register Number
     * @return Optional containing the Student if found.
     */
    public Optional<Student> getStudentByRegno(int regno) {
        return studentRepository.findById(regno);
    }

    /**
     * Delete a student by their Register Number.
     * @param regno Register Number
     */
    public void deleteStudent(int regno) {
        studentRepository.deleteById(regno);
    }

    /**
     * Search students by keyword (matches Register Number or Name).
     * @param keyword search keyword
     * @return List of matching students.
     */
    public List<Student> searchStudents(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return studentRepository.findAll();
        }

        String trimmed = keyword.trim();

        // If the search term is a numeric value, check if it matches a regno directly
        try {
            int regno = Integer.parseInt(trimmed);
            Optional<Student> studentOpt = studentRepository.findById(regno);
            if (studentOpt.isPresent()) {
                List<Student> results = new ArrayList<>();
                results.add(studentOpt.get());
                return results;
            }
        } catch (NumberFormatException ignored) {
            // Keyword is not an integer, proceed to name search
        }

        // Search by name (case-insensitive substring)
        return studentRepository.findByNameContainingIgnoreCase(trimmed);
    }
}
