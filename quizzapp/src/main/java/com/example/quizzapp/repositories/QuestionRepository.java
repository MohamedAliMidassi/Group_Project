package com.example.quizzapp.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.quizzapp.models.Question;

@Repository
public interface QuestionRepository extends CrudRepository<Question, Long> {}