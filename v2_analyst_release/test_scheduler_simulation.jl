include("src/Scheduler.jl")
using .Scheduler
using Dates

println("🤖 Teacher Mode: Activated")
println("👨‍🏫 Teacher: Hello! I see you want to learn how to code. Let's make a plan.")
println("👨‍🏫 Teacher: I can help you with Julia, Python, or General Coding concepts.")

# Simulate User Choice
user_choice_lang = "Julia"
println("\n👤 Student: I want to learn $user_choice_lang.")

println("👨‍🏫 Teacher: Excellent choice! Julia is high-performance and great for data science.")
println("👨‍🏫 Teacher: Now, to make this work for you, tell me your availability.")
println("👨‍🏫 Teacher: For example, 'Mondays and Fridays' or 'Weekends'.")

# Simulate User Availability
user_choice_days = [1, 3, 5] # Mon, Wed, Fri
println("\n👤 Student: I can study on Mondays, Wednesdays, and Fridays.")

println("👨‍🏫 Teacher: Perfect. Consistency is key! 🔑")
println("👨‍🏫 Teacher: Generating your personalized timetable starting from today...")

# Generate
start_date = today()
schedule, lang = Scheduler.generate_schedule(user_choice_lang, start_date, user_choice_days)

println("\n✨ --- Your Personal Learning Plan --- ✨")
println("Subject: $(uppercase(lang))")
println("Start Date: $start_date")
println("Schedule: Mon, Wed, Fri")
println("---------------------------------------")

for (i, sess) in enumerate(schedule)
    if i > 5 
        println("... [$(length(schedule)-5) more sessions] ...")
        break 
    end
    println("📅 $(sess.date) | 📘 $(sess.topic)")
    println("   ↳ $(sess.description)")
end

println("---------------------------------------")
println("👨‍🏫 Teacher: I've created a full file for you to track your progress.")

# Save
filename = "Julia_Mastery_Schedule.md"
Scheduler.save_schedule_to_file(schedule, lang, filename)
println("💾 File saved: $filename")

println("\n👨‍🏫 Teacher: You're all set! Let's start with the first topic on $(schedule[1].date).")
println("👨‍🏫 Teacher: Remember, I'm here to help you explain any of these topics!")
