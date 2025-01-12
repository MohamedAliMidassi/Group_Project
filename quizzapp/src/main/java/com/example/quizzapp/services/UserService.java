package com.example.quizzapp.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.example.quizzapp.models.LoginUser;
import com.example.quizzapp.models.User;
import com.example.quizzapp.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepo;

    // Register method
    public User register(User newUser, BindingResult result) {
        
        // Check if the email is already taken
    	Optional<User> userLookUp = userRepo.findByEmail(newUser.getEmail());
    	if (userLookUp.isPresent()) {
    		result.rejectValue("email", "Unique", "Account with this email already exists.");
    	}
        
        // Check if password and confirm password match
    	if (!newUser.getPassword().equals(newUser.getConfirm())) {
    	    result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
    	}
        
        // Return null if there are validation errors
    	if (result.hasErrors()) {
    		return null;
    	}
    
        // Hash the password and save the user
    	String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
    	newUser.setPassword(hashed);
    	
    	newUser = userRepo.save(newUser);
    	System.out.println("New user created with ID: " + newUser.getId());
    	
        return newUser;
    }
    
    // Login method
    public User login(LoginUser newLogin, BindingResult result) {
        
        // Find the user by email
    	Optional<User> userLookUp = userRepo.findByEmail(newLogin.getEmail());
    	if (!userLookUp.isPresent()) {
    		result.rejectValue("email", "MissingAccount", "No account found.");
    		return null;
    	}
    	User user = userLookUp.get();
        
        // Check if the password matches
    	if (!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
    	    result.rejectValue("password", "Matches", "Invalid Password!");
    	}
    	
        // Return null if there are validation errors
    	if (result.hasErrors()) {
    		return null;
    	}
    	
        // Return the user if login is successful
        return user;
    }

    // Helper method to find user by email
	public User findByEmail(String email) {
		return userRepo.findByEmail(email).orElse(null);
	}
	
    // Helper method to find user by ID
	public User findById(Long id) {
        return userRepo.findById(id).orElse(null); // Return null if user is not found
    }
	//update method
//	public void updateUser(User user) {
//	    Optional<User> existingUser = userRepo.findById(user.getId());
//	    if (existingUser.isPresent()) {
//	        User u = existingUser.get();
//	        u.setUsername(user.getUsername());
//	        u.setEmail(user.getEmail());
//	        userRepo.save(u);
//	    }
//	}
	public void updateUser(User user) {
	    // Ensure that the user object is valid before attempting database operations
	    if (user != null && user.getUsername() != null && user.getEmail() != null) {
	        // Proceed with updating the user in the database
	        userRepo.save(user);
	    }
	}


	

}
