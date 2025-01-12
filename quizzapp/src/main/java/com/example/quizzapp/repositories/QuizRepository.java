package com.example.quizzapp.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.quizzapp.models.Category;
import com.example.quizzapp.models.Quiz;
import com.example.quizzapp.models.User;

@Repository
public interface QuizRepository extends CrudRepository<Quiz, Long> {
    List<Quiz> findAll();

    Quiz findByCode(String code);

    List<Quiz> findByIsPrivateFalse();  
    List<Quiz> findByIsPrivateFalseAndQuestionsIsNotEmpty();
    List<Quiz> findTop3ByIsPrivateFalseAndQuestionsIsNotEmptyOrderByCreatedAtDesc();

    
    @Query("SELECT q FROM Quiz q WHERE q.creator = :creator ORDER BY q.createdAt DESC")
    List<Quiz> findTop3ByCreatorOrderByCreatedAtDesc(@Param("creator") User creator);
    
    @Query("SELECT q FROM Quiz q WHERE q.creator.id = :creator_id")
    
    
    
    List<Quiz> findByCreatorId(@Param("creator_id") Long creatorId);
    public Page<Quiz> findAllByOrderByCreatedAtDesc(Pageable pageable);

	Page<Quiz> findByCreatorOrderByCreatedAtDesc(User user, Pageable pageable);
	
	//category
    List<Quiz> findByCategory(Category category);
    
    void deleteById(Long id);

}
