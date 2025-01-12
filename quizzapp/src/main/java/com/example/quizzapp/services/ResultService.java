package com.example.quizzapp.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.quizzapp.models.Quiz;
import com.example.quizzapp.models.Result;
import com.example.quizzapp.models.User;
import com.example.quizzapp.repositories.ResultRepository;

@Service
public class ResultService {

    @Autowired
    private ResultRepository resultRepository;


    public Result saveResult(Result result) {
        return resultRepository.save(result);
    }


    public Result getResultById(Long id) {
        return resultRepository.findById(id).orElse(null);
    }


    public List<Result> getResultsByUser(User user) {
        return resultRepository.findByUser(user);
    }
    public Map<Quiz, Integer> getMaxScoresForUser(User user) {
        List<Object[]> Results = resultRepository.findMaxScoresByUser(user);
        Map<Quiz, Integer> maxScores = new HashMap<>();

        for (Object[] row : Results) {
            Quiz quiz = (Quiz) row[0];
            Integer maxScore = ((Number) row[1]).intValue();
            maxScores.put(quiz, maxScore);
        }

        return maxScores;
    }


    public List<Result> getResultsByQuiz(Quiz quiz) {
        return resultRepository.findByQuiz(quiz);
    }
    
    
    public Page<Result> getPaginatedResultsByUser(User user, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return resultRepository.findByUser(user, pageable);
    }
}
