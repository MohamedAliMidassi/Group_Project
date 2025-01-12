package com.example.quizzapp.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.quizzapp.models.Question;
import com.example.quizzapp.repositories.QuestionRepository;

@Service
public class QuestionService {
	@Autowired
    private QuestionRepository questionRepository;

    public Question create(Question question) {
        return questionRepository.save(question); 
    }
}