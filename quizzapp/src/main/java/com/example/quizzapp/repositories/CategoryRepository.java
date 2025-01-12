package com.example.quizzapp.repositories;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.quizzapp.models.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
	// category
    Optional<Category> findByName(String name);

}
