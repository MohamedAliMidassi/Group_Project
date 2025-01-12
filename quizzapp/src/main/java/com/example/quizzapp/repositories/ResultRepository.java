package com.example.quizzapp.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.quizzapp.models.Quiz;
import com.example.quizzapp.models.Result;
import com.example.quizzapp.models.User;

public interface ResultRepository extends JpaRepository<Result, Long> {


    List<Result> findByUser(User user);
    Page<Result> findByUser(User user, Pageable pageable);

    
    List<Result> findByQuiz(Quiz quiz);
    
    @Query("SELECT r.quiz AS quiz, MAX(r.score) AS maxScore FROM Result r WHERE r.user = :user GROUP BY r.quiz")
    List<Object[]> findMaxScoresByUser(@Param("user") User user);

}