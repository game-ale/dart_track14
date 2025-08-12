1️⃣ The Core Idea to Remember
Think of it like ordering injera at a restaurant 🍽️:

async = “This function might take time, but I’ll come back with your order.”

await = “I’ll wait here until the food arrives before moving on.”

2️⃣ The Rule
Mark the function with async → Use await inside it → await only works on Futures.

3️⃣ Memory Formula
📌 3 ***Steps — "Mark → Wait → Get"***

Mark the function with async

Wait for the Future with await

Get the result when it’s ready


async = you tell your brain, “This conversation may take time.”

await = you pause until your friend replies.

6️⃣ Common Mistakes to Avoid
❌ Forgetting async when using await → compile error.
❌ Not using await → the function returns a Future before the value is ready.
❌ Blocking main thread with sync work → defeats async benefits.