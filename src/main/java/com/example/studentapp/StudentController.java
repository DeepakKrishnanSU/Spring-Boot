package com.example.studentapp;

import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Spring MVC Controller handling HTTP requests for the Student application.
 * Supports complete CRUD (Create, Read, Update, Delete) and Search operations.
 */
@Controller
public class StudentController {

    private final StudentService studentService;

    // Constructor Injection
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    /**
     * 1. CREATE / ADD: Display the Student Registration Form (Empty).
     * Accessible at http://localhost:8080/
     */
    @GetMapping("/")
    public String showForm(Model model) {
        model.addAttribute("student", new Student());
        model.addAttribute("isEdit", false);
        return "student-form";
    }

    /**
     * Handles submission of both Add and Update forms.
     * Persists student details to PostgreSQL and redirects to the student list.
     */
    @PostMapping("/saveStudent")
    public String saveStudent(@ModelAttribute Student student) {
        studentService.saveStudent(student);
        return "redirect:/students";
    }

    /**
     * 2. READ / SEARCH: Retrieve all students or filter by keyword.
     * Accessible at http://localhost:8080/students
     */
    @GetMapping("/students")
    public String getStudents(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<Student> students;
        if (keyword != null && !keyword.trim().isEmpty()) {
            students = studentService.searchStudents(keyword);
            model.addAttribute("keyword", keyword.trim());
        } else {
            students = studentService.getAllStudents();
            model.addAttribute("keyword", "");
        }
        model.addAttribute("students", students);
        return "student-list";
    }

    /**
     * 3. UPDATE / EDIT: Display the form pre-populated with existing student data.
     * Accessible at http://localhost:8080/editStudent/{regno}
     */
    @GetMapping("/editStudent/{regno}")
    public String showEditForm(@PathVariable("regno") int regno, Model model) {
        Optional<Student> studentOpt = studentService.getStudentByRegno(regno);
        if (studentOpt.isPresent()) {
            model.addAttribute("student", studentOpt.get());
            model.addAttribute("isEdit", true);
            return "student-form";
        }
        // If not found, return to list
        return "redirect:/students";
    }

    /**
     * 4. DELETE: Remove student by Register Number.
     * Accessible at http://localhost:8080/deleteStudent/{regno}
     */
    @GetMapping("/deleteStudent/{regno}")
    public String deleteStudent(@PathVariable("regno") int regno) {
        studentService.deleteStudent(regno);
        return "redirect:/students";
    }
}
