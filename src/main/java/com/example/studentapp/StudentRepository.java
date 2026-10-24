package com.example.studentapp;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA Repository for Student entity.
 * Provides out-of-the-box CRUD methods and custom query methods for search.
 */
@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {

    /**
     * Search students by name (case-insensitive substring match).
     */
    List<Student> findByNameContainingIgnoreCase(String name);
}
