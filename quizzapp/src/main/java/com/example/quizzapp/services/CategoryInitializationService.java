package com.example.quizzapp.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.quizzapp.models.Category;
import com.example.quizzapp.repositories.CategoryRepository;

import jakarta.annotation.PostConstruct;

@Service
public class CategoryInitializationService {

    @Autowired
    private CategoryRepository categoryRepository;

    private final List<Category> predefinedCategories = List.of(
            new Category("General Knowledge", "/images/General_Knowledge.png"),
            new Category("Science", "/images/Science.jpg"),
            new Category("History", "/images/History.png"),
            new Category("Geography", "/images/Geography.jfif"),
            new Category("Sports", "/images/Sports.jpg"),
            new Category("Technology", "/images/Technology.jpg"),
            new Category("Mathematics", "/images/Maths.jpeg"),
            new Category("Music", "/images/Music.jpg"),
            new Category("Movies and TV Shows", "/images/Movie.jfif"),
            new Category("Food and Drink", "/images/Foods.jpg"),
            new Category("Animals and Nature", "/images/animals_nature.jpg"),
            new Category("Space and Astronomy", "/images/space_astronomy.jpg"),
            new Category("Comics and Cartoons", "/images/comics_cartoons.jpg"),
            new Category("Video Games", "/images/video_games.jfif"),
            new Category("Travel", "/images/travel.jpg"),
            new Category("Other", "/images/travel.jpg")
    );

    @PostConstruct
    public void initializeCategories() {
        if (categoryRepository.count() == 0) {
            categoryRepository.saveAll(predefinedCategories);
        }
    }
}