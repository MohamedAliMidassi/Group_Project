package com.example.quizzapp.controllers;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.quizzapp.models.Category;
import com.example.quizzapp.models.LoginUser;
import com.example.quizzapp.models.Question;
import com.example.quizzapp.models.Quiz;
import com.example.quizzapp.models.Result;
import com.example.quizzapp.models.User;
import com.example.quizzapp.repositories.QuestionRepository;
import com.example.quizzapp.repositories.QuizRepository;
import com.example.quizzapp.repositories.ResultRepository;
import com.example.quizzapp.services.CategoryService;
import com.example.quizzapp.services.EmailService;
import com.example.quizzapp.services.QuestionService;
import com.example.quizzapp.services.QuizService;
import com.example.quizzapp.services.ResultService;
import com.example.quizzapp.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private ResultRepository resultRepository;

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private QuestionRepository questionRepository;
    
    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private ResultService resultService;
    
    @Autowired
    private EmailService emailService;
    
    // Visitor page
    @GetMapping("/")
    public String visitorPage() {
        return "visitor.jsp"; 
    }
    // Display login page
    @GetMapping("/login")
    public String showLoginPage(Model model) {
        model.addAttribute("newLogin", new LoginUser());
        return "login.jsp";
    }
    // Display registration page
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("newUser", new User());
        return "register.jsp";
    }  

    // Handle user registration
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, 
            BindingResult result, Model model, HttpSession session) {
        User user = userService.register(newUser, result);
        if(result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "register.jsp";
        }
        session.setAttribute("userId", user.getId());
        return "redirect:/home";
    }

    // Handle user login
    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
            BindingResult result, Model model, HttpSession session) {
        User user = userService.login(newLogin, result);
        if(result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "login.jsp";
        }
        session.setAttribute("userId", user.getId());
        return "redirect:/home";
    }

    // Display the home page
    @GetMapping("/home")
    public String home(Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/"; 
        }

        User user = userService.findById((Long) session.getAttribute("userId"));

        List<Quiz> latestQuizzes = quizRepository.findTop3ByIsPrivateFalseAndQuestionsIsNotEmptyOrderByCreatedAtDesc();

        List<Category> categories = categoryService.getAllCategories();
        System.out.println("Latest Quizzes: " + latestQuizzes);
        System.out.println("Number of latest public quizzes with questions: " + latestQuizzes.size());

        System.out.println("User : " + user);
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("quizzes", latestQuizzes);  
            model.addAttribute("quizCode", ""); 
            model.addAttribute("categories", categories);
        }

        return "home.jsp"; 
    }
    @GetMapping("/profile")
    public String getUserDashboard(
            Model model,
            HttpSession session,
            @RequestParam(defaultValue = "0") int page, // For quizzes pagination
            @RequestParam(defaultValue = "3") int size, // For quizzes pagination
            @RequestParam(defaultValue = "0") int resultsPage, // For results pagination
            @RequestParam(defaultValue = "3") int resultsSize // For results pagination
    ) {
        // Check if the user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        // Fetch current user
        User currentUser = userService.findById(userId);
        if (currentUser == null) {
            session.invalidate();
            return "redirect:/login";
        }
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        session.setAttribute("user", currentUser);

        // Fetch paginated quizzes
        Page<Quiz> paginatedLists = quizService.getPaginatedQuizzes(currentUser ,page, size);
        model.addAttribute("quizzList", paginatedLists.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", paginatedLists.getTotalPages());
        model.addAttribute("totalItems", paginatedLists.getTotalElements());

        // Fetch all results and find max scores per quiz
        List<Result> allResults = resultService.getResultsByUser(currentUser);
        Map<Quiz, Result> maxScoreResults = allResults.stream()
                .collect(Collectors.toMap(
                        Result::getQuiz,
                        Function.identity(),
                        (existing, replacement) -> existing.getScore() > replacement.getScore() ? existing : replacement
                ));

        // Convert maxScoreResults to a List and paginate it
        List<Result> bestResults = new ArrayList<>(maxScoreResults.values());
        int start = resultsPage * resultsSize;
        int end = Math.min(start + resultsSize, bestResults.size());
        List<Result> paginatedBestResults = bestResults.subList(start, end);

        // Add attributes for paginated results
        model.addAttribute("results", paginatedBestResults);
        model.addAttribute("resultsCurrentPage", resultsPage);
        model.addAttribute("resultsTotalPages", (int) Math.ceil((double) bestResults.size() / resultsSize));

        Map<Quiz, Integer> maxScores = maxScoreResults.values().stream()
                .collect(Collectors.toMap(Result::getQuiz, Result::getScore));
        model.addAttribute("maxScores", maxScores);

        return "profile.jsp";
    }


    
//    @GetMapping("/my-quizzes")
//    public String getUserQuizzes(Model model, HttpSession session) {
//        Long userId = (Long) session.getAttribute("userId");
//        if (userId == null) {
//            return "redirect:/";
//        }
//
//        List<Quiz> userQuizzes = quizService.getQuizzesByCreatorId(userId);
//
//        if (userQuizzes.isEmpty()) {
//            model.addAttribute("message", "You haven't created any quizzes yet.");
//        }
//        model.addAttribute("userQuizzes", userQuizzes);
//
//        return "myquizzes.jsp";
//    }




    // Handle user logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "redirect:/"; 
    }

    // Display the page for creating a new quiz
    @GetMapping("/quiz/create")
    public String createQuizPage(Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/"; 
        }
        System.out.println("User is logged in");
        model.addAttribute("newQuiz", new Quiz());
        model.addAttribute("categories", categoryService.getAllCategories());
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "createQuiz.jsp"; 
    }

    @PostMapping("/quiz/create")
    public String createQuiz(
            @Valid @ModelAttribute("newQuiz") Quiz quiz,
            BindingResult result,Model model,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login"; 
        }

        User user = userService.findById(userId);
        if (user == null) {
            return "redirect:/"; 
        }

        String difficulty = quiz.getDifficulty();
        if (difficulty != null) {
            switch (difficulty.toLowerCase()) {
                case "easy":
                    quiz.setNumQuestions(5);
                    break;
                case "medium":
                    quiz.setNumQuestions(10);
                    break;
                case "hard":
                    quiz.setNumQuestions(18);
                    break;
                case "challenge":
                    quiz.setNumQuestions(25);
                    break;
                default:
                    result.rejectValue("difficulty", "Invalid", "Invalid difficulty level.");
                    break;
            }
        } else {
            result.rejectValue("difficulty", "Invalid", "Difficulty cannot be null or empty.");
        }
        model.addAttribute("categories", categoryService.getAllCategories());

        if (result.hasErrors()) {
            return "createQuiz.jsp"; 
        }

        quiz.setCreator(user);

        quizRepository.save(quiz);
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "redirect:/quiz/" + quiz.getId() + "/add-questions";
    }


    // Show the add questions form
    @GetMapping("/quiz/{id}/add-questions")
    public String addQuestionsForm(@PathVariable Long id, Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/"; 
        }
        Quiz quiz = quizRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid quiz ID"));
        model.addAttribute("quiz", quiz);
        model.addAttribute("newQuestion", new Question());  
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "addQuestions.jsp";  
    }

    @PostMapping("/quiz/{id}/add-question")
    public String addQuestion(@PathVariable Long id, @ModelAttribute("quiz") Quiz quiz, Model model) {
        Quiz existingQuiz = quizRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid quiz ID"));

        for (Question question : quiz.getQuestions()) {
            if (!(question.getOptionA().equals(question.getCorrectAnswer()) ||
                  question.getOptionB().equals(question.getCorrectAnswer()) ||
                  question.getOptionC().equals(question.getCorrectAnswer()) ||
                  question.getOptionD().equals(question.getCorrectAnswer()))) {
                
                model.addAttribute("error", "Correct answer must be one of the options.");
                model.addAttribute("quiz", existingQuiz);  
                model.addAttribute("newQuestion", new Question());  

                return "addQuestions.jsp";  
            }

            question.setQuiz(existingQuiz);  
            questionRepository.save(question);  
        }

        model.addAttribute("quiz", existingQuiz);  
        model.addAttribute("newQuestion", new Question());  
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);

        return "redirect:/home";  
    }



    // Display a quiz and its questions
    @GetMapping("/quiz/{id}")
    public String showQuiz(@PathVariable("id") Long quizId, Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/"; 
        }

        Quiz quiz = quizService.findById(quizId);
        if (quiz == null) {
            return "redirect:/home"; 
        }

        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", quiz.getQuestions()); 
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "quizPage.jsp"; 
    }

    // Submit answers and show results
    @PostMapping("/quiz/{id}/submit")
    public String submitQuiz(@PathVariable("id") Long quizId, 
                             @RequestParam Map<String, String> answers, 
                             HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/"; 
        }

        Quiz quiz = quizService.findById(quizId);
        if (quiz == null) {
            return "redirect:/home"; 
        }

        User user = userService.findById((Long) session.getAttribute("userId"));
        if (user == null) {
            return "redirect:/"; 
        }

        int score = 0;
        List<Question> questions = quiz.getQuestions();
        System.out.println("Number of questions in quiz: " + questions.size());

        for (Question question : questions) {
            String correctAnswer = question.getCorrectAnswer(); 
            
            String userAnswer = answers.get("question-" + question.getId());

            String userSelectedAnswerContent = null;
            if (userAnswer != null) {
                switch (userAnswer) {
                    case "A":
                        userSelectedAnswerContent = question.getOptionA();
                        break;
                    case "B":
                        userSelectedAnswerContent = question.getOptionB();
                        break;
                    case "C":
                        userSelectedAnswerContent = question.getOptionC();
                        break;
                    case "D":
                        userSelectedAnswerContent = question.getOptionD();
                        break;
                }
            }

            System.out.println("Question ID: " + question.getId());
            System.out.println("Correct Answer: " + correctAnswer);
            System.out.println("User Answer: " + userAnswer + " (Content: " + userSelectedAnswerContent + ")");

          
            if (correctAnswer != null && userSelectedAnswerContent != null && correctAnswer.equals(userSelectedAnswerContent)) {
                score++;
            }
        }

        Result result = new Result(user, quiz, score);
        resultRepository.save(result);

        model.addAttribute("quiz", quiz);
        model.addAttribute("score", score);
        model.addAttribute("totalQuestions", questions.size());

        return "result.jsp"; 
    }
    
    @GetMapping("/quizzes/{id}/details")
    public String editQuizForm(@PathVariable Long id, Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }
        Quiz quiz = quizService.findById(id);
        if (quiz == null) {
            return "redirect:/home";
        }
        model.addAttribute("quiz", quiz);
        model.addAttribute("categories", categoryService.getAllCategories());
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "quizDetails.jsp"; 
    }

    @PostMapping("/quizzes/{id}/update")
    public String updateQuiz(@PathVariable Long id, @Valid @ModelAttribute("quiz") Quiz quiz, 
                             BindingResult result, Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }
        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.getAllCategories());
            System.out.println("Validation errors: " + result.getAllErrors());
            return "quizDetails.jsp";
        }
        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.getAllCategories());
            return "quizDetails.jsp";
        }
        Quiz existingQuiz = quizService.findById(id);
        if (existingQuiz == null) {
            return "redirect:/home";
        }
        existingQuiz.setTitle(quiz.getTitle());
        existingQuiz.setDescription(quiz.getDescription());
        existingQuiz.setDifficulty(quiz.getDifficulty());
        existingQuiz.setCategory(quiz.getCategory());
        quizService.update(existingQuiz);
        return "redirect:/home";
    }
    
    
    
    @PostMapping("/sendQuizCode")
    public String sendQuizCode(@RequestParam("email") String email, @RequestParam("quizCode") String quizCode) {
        String subject = "Your Quiz Code";
        String body = "Here is your quiz code: " + quizCode;
        emailService.sendEmail(email, subject, body);
        return "redirect:/quizDetails";
    }
  



 // Display a private quiz using a code
    @GetMapping("/quiz/access")
    public String accessQuiz(@RequestParam("code") String code, Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/"; 
        }

        Quiz quiz = quizService.findByCode(code); 
        if (quiz != null) {
            model.addAttribute("quiz", quiz); 
            model.addAttribute("questions", quiz.getQuestions()); 
            return "quizPage.jsp"; 
        } else {
            model.addAttribute("error", "Invalid quiz code"); 
            List<Category> categories = categoryService.getAllCategories();
            model.addAttribute("categories", categories);
            return "home.jsp"; 
        }
    }
    
    
    @GetMapping("/all-quizzes")
    public String getAllQuizzes(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        List<Quiz> allQuizzes = quizService.findAllQuizzes(); 

        if (allQuizzes.isEmpty()) {
            model.addAttribute("message", "No quizzes are available at the moment.");
        }
        model.addAttribute("allQuizzes", allQuizzes); 
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);

        return "allQuizzes.jsp";
    }
    
    @GetMapping("/take-quizz")
    public String takeQuizze(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";

        }
        
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "takeQuizz.jsp";
    }


    @GetMapping("/private")
    public String privateQuizz(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        User currentUser = userService.findById(userId);
        if (currentUser == null) {
            session.invalidate();
            return "redirect:/login";
        }

        session.setAttribute("user", currentUser);
        System.out.println("Current User: " + currentUser);

        List<Quiz> latestQuizzes = quizService.getLatestQuizzes(currentUser);
        model.addAttribute("latestQuizzes", latestQuizzes);

        List<Result> allResults = resultService.getResultsByUser(currentUser);
        Map<Long, Result> bestResultsMap = new HashMap<>();
        for (Result result : allResults) {
            Long quizId = result.getQuiz().getId();
            if (!bestResultsMap.containsKey(quizId) || result.getScore() > bestResultsMap.get(quizId).getScore()) {
                bestResultsMap.put(quizId, result);
            }
        }

        List<Result> bestResults = new ArrayList<>(bestResultsMap.values());

        model.addAttribute("results", bestResults); 

        // max result
        Map<Quiz, Integer> maxScores = bestResults.stream()
            .collect(Collectors.toMap(Result::getQuiz, Result::getScore));
        model.addAttribute("maxScores", maxScores);
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);

        return "privateQuizz.jsp";
    }   
    
    
  //category
    @GetMapping("/category/{categoryName}")
    public String getCategoryQuizzes(
            @PathVariable("categoryName") String categoryName, 
            Model model, 
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        Optional<Category> categoryOptional = categoryService.getCategoryByName(categoryName);
        if (categoryOptional.isEmpty()) {
            model.addAttribute("errorMessage", "Category not found.");
            return "error.jsp"; 
        }

        Category category = categoryOptional.get();
        List<Quiz> quizzes = quizService.getQuizzesByCategory(category);

        model.addAttribute("category", category);
        model.addAttribute("quizzes", quizzes);
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);

        return "categoryQuizzes.jsp";
    }
    
    //update user info
    @GetMapping("/account/edit")
    public String showUpdateForm(HttpSession session, Model model) {
        
        User user = (User) session.getAttribute("user"); // Assuming user is stored in session
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        return "update-account.jsp"; 
    }

    @PostMapping("/account/updateAccount")
    public String updateAccount(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
        if (result.hasErrors()) {
            
            System.out.println("Validation errors: " + result.getAllErrors());
            
            
            return "update-account.jsp";  
        }

        userService.updateUser(user);

        session.setAttribute("user", user);

        
        return "redirect:/profile"; 
    }
    
    @PostMapping("quizzes/delete/{id}")
    public String deleteQuiz(@PathVariable Long id, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null || !quizService.isCreator(id, userId)) {
            return "error"; 
        }

        quizService.delete(id);
        return "redirect:/profile";  
    }
    
    @GetMapping("quizzes/{id}/viewCode")
    public String viewQuizCode(@PathVariable("id") Long id, Model model) {
        Quiz quiz = quizService.findById(id);
        
        model.addAttribute("quiz", quiz);
        
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        
        return "QuizCode.jsp";  
    }



}


