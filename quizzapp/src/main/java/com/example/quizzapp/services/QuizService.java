package com.example.quizzapp.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.example.quizzapp.models.Category;
import com.example.quizzapp.models.Quiz;
import com.example.quizzapp.models.User;
import com.example.quizzapp.repositories.QuizRepository;

@Service
public class QuizService {

    @Autowired
    private QuizRepository quizRepo;

    public List<Quiz> getAllPublicQuizzes() {
        return quizRepo.findByIsPrivateFalse();
    }


    public void createQuiz(Quiz quiz, User creator) {
        quiz.setCreator(creator);  
        quizRepo.save(quiz);  
    }

    public Quiz findById(Long id) {
        return quizRepo.findById(id).orElse(null);
    }

    public Quiz findByCode(String code) {
        return quizRepo.findByCode(code);
    }
    
    public void update(Quiz quiz) {
        quizRepo.save(quiz);
    }
    
    public List<Quiz> getLatestQuizzes(User user) {
        return quizRepo.findTop3ByCreatorOrderByCreatedAtDesc(user);
    }
    
    public List<Quiz> getQuizzesByCreatorId(Long creatorId) {
        return quizRepo.findByCreatorId(creatorId);
    }
    
    
    
    
    public List<Quiz> findAllQuizzes() {
        return quizRepo.findAll();
    }
    
    
    
    
    public void delete(Long id) {
        if (quizRepo.existsById(id)) {
            quizRepo.deleteById(id); 
        } else {
            throw new IllegalArgumentException("Quiz not found");
        }
    }

    
    public boolean isCreator(Long quizId, Long userId) {
        Quiz quiz = quizRepo.findById(quizId).orElse(null);
        return quiz != null && quiz.getCreator().getId().equals(userId);
    }
    
    

// Method to get paginated concessions, sorted by createdAt descending
    public Page<Quiz> getPaginatedQuizzes(User user, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Order.desc("createdAt")));
        
        if (user != null) {
            // Fetch quizzes created by the user, paginated
            return quizRepo.findByCreatorOrderByCreatedAtDesc(user, pageable);
        } else {
            // Fetch all quizzes, paginated
            return quizRepo.findAllByOrderByCreatedAtDesc(pageable);
        }
    }
    
 // category
    
    public List<Quiz> getQuizzesByCategory(Category category) {
        return quizRepo.findByCategory(category);
    }

    
}