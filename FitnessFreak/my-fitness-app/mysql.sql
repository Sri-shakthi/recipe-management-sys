CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    gender TEXT NOT NULL,
    age INTEGER NOT NULL,
    height FLOAT  NOT NULL,
    weight FLOAT NOT NULL,
    bmi FLOAT NOT NULL,
    goal TEXT NOT NULL,
    goal_weight FLOAT NOT NULL,
    goal_in_days INTEGER NOT NULL,
    allergies TEXT NOT NULL,
    membership BOOL NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/*
INSERT INTO users (username, password, email)
VALUES
  ('sri shakthi', 'srishakthi1', 'srishakthi32@gmail.com'),
  ('user1', 'password1', 'user1@example.com'),
  ('user2', 'password2', 'user2@example.com'),
  ('user3', 'password3', 'user3@example.com'),
  ('user4', 'password4', 'user4@example.com'),
  ('user5', 'password5', 'user5@example.com'),
  ('user6', 'password6', 'user6@example.com'),
  ('user7', 'password7', 'user7@example.com'),
  ('user8', 'password8', 'user8@example.com'),
  ('user9', 'password9', 'user9@example.com'),
  ('user10', 'password10', 'user10@example.com');
*/

/*
SELECT *
FROM users
*/

/*
CREATE TABLE recipes (
    recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    ingredients TEXT,
    instructions TEXT,
    category TEXT,
    cusine TEXT ,
    user_id INTEGER,
    nutrients TEXT, 
    recipe_url TEXT,
    rating REAL DEFAULT 0,           
    ratingCount INTEGER DEFAULT 0,
    reviewCount INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
*/

/*
INSERT INTO recipes (title, description, ingredients, instructions, category, nutrients, recipe_url)
VALUES
    ('Dosa', 'South Indian Crepe made from fermented rice and lentil batter', '1 cup rice, 1/2 cup urad dal, salt, water', '1. Soak rice and urad dal separately for 6 hours. 2. Grind them to a smooth batter. 3. Ferment the batter overnight. 4. Heat a skillet and pour a ladle of batter. 5. Spread it in a circular motion. 6. Cook until golden brown. 7. Serve hot with chutney and sambar.', 'Breakfast', 'Carbohydrates: 20g, Protein: 5g, Fat: 2g, Fiber: 3g', 'https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_auto,w_610,h_407/k%2FPhoto%2FSeries%2F2020-07-South-Indian-Chritra-Agrawal%2FDosa%20Making%20-%20How%20to%20steps%2FShot_21_-_Finished_dosas'),
    ('Idli', 'Steamed rice cake made from fermented rice and lentil batter', '2 cups rice, 1 cup urad dal, salt, water', '1. Soak rice and urad dal separately for 6 hours. 2. Grind them to a smooth batter. 3. Ferment the batter overnight. 4. Grease idli molds and pour batter into them. 5. Steam for 10-12 minutes. 6. Serve hot with chutney and sambar.','Breakfast', 'Carbohydrates: 20g, Protein: 5g, Fat: 2g, Fiber: 3g', 'https://glutenfreeindian.com/wp-content/uploads/2017/09/PUL_8798-1024x684.jpg'),
    ('Sambar', 'South Indian lentil stew made with vegetables and spices', '1/2 cup toor dal, 1 onion, 2 tomatoes, 1 carrot, 1 potato, tamarind pulp, sambar powder, salt, water', '1. Cook toor dal until soft. 2. Add chopped vegetables and cook until tender. 3. Add tamarind pulp and sambar powder. 4. Simmer until flavors blend. 5. Serve hot with rice or idli.', 'Breakfast', 'Carbohydrates: 20g, Protein: 5g, Fat: 2g, Fiber: 3g', 'https://t3.ftcdn.net/jpg/05/07/96/54/360_F_507965420_AGUCtnt8VqSBkE0gyJD0LFr2XjIsPQo9.jpg'),
    ('Pancakes', 'Fluffy American pancakes served with maple syrup', '1 cup all-purpose flour, 2 tbsp sugar, 1 tsp baking powder, 1/2 tsp baking soda, 1 cup milk, 1 egg, 2 tbsp melted butter, maple syrup', '1. In a bowl, mix flour, sugar, baking powder, and baking soda. 2. In another bowl, whisk together milk, egg, and melted butter. 3. Combine wet and dry ingredients. 4. Heat a skillet and pour batter. 5. Cook until bubbles form, then flip. 6. Serve hot with maple syrup.', 'Breakfast', 'Carbohydrates: 30g, Protein: 6g, Fat: 4g, Fiber: 1g', 'https://www.allrecipes.com/thmb/FE0PiuuR0Uh06uVh1c2AsKjRGbc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/21014-Good-old-Fashioned-Pancakes-mfs_002-0e249c95678f446291ebc9408ae64c05.jpg'),
    ('Omelette', 'Classic fluffy omelette with fillings of your choice', '2 eggs, salt, pepper, fillings (e.g., cheese, vegetables, ham)', '1. Beat eggs with salt and pepper. 2. Heat a non-stick skillet over medium heat. 3. Pour egg mixture into skillet. 4. Cook until edges are set. 5. Add fillings. 6. Fold omelette in half and cook until golden brown. 7. Serve hot.', 'Breakfast', 'Carbohydrates: 1g, Protein: 8g, Fat: 5g, Fiber: 0g', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJmvGHVighw0KZPy9MYhI7PoU5qp3JNcn2Xw&usqp=CAU'),
    ('French Toast', 'Sliced bread soaked in eggs and milk, then fried until golden brown', '4 slices bread, 2 eggs, 1/2 cup milk, 1 tsp vanilla extract, butter, maple syrup', '1. Whisk together eggs, milk, and vanilla extract. 2. Dip bread slices in the egg mixture. 3. Fry bread slices in butter until golden brown on both sides. 4. Serve hot with maple syrup.', 'Breakfast', 'Carbohydrates: 25g, Protein: 7g, Fat: 3g, Fiber: 1g', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1wDSMB_dx2TGze-mCeFbisRFwO4LLRzP-_A&usqp=CAU');



*/



--DELETE FROM users;
