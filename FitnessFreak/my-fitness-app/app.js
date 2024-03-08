require('dotenv').config()

const express = require("express");
const path = require("path");
const { open } = require("sqlite");
const sqlite3 = require("sqlite3");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken")


const dbPath = path.join(__dirname, "recipeSwvil.db");
const app = express();

const PORT = process.env.PORT || 1344;
app.use(express.json());

let db = null;

const initializeDBAndServer = async () => {
  try {
    db = await open({
      filename: dbPath,
      driver: sqlite3.Database,
    });
    app.listen(PORT , () => {
      console.log(`Server Running at http://localhost:${PORT}/`);
    });
  } catch (e) {
    console.log(`DB Error: ${e.message}`);
    process.exit(1);
  }
};

initializeDBAndServer();


function authenticateToken(request, response, next) {
  let jwtToken;
  const authHeader = request.headers["authorization"];
  if (authHeader !== undefined) {
    jwtToken = authHeader.split(" ")[1];
  }
  if (jwtToken === undefined) {
    response.status(401);
    response.send("Invalid JWT Token");
  } else {
    jwt.verify(jwtToken, "MY_SECRET_TOKEN", async (error, payload) => {
      if (error) {
        response.status(401);
        response.send("Invalid JWT Token");
      } else {
        next();
      }
    });
  }
}

// LOGIN USER 

app.post("/login/", async (request, response) => {
  const { username, password } = request.body;
  const selectUserQuery = `SELECT * FROM users WHERE username = '${username}';`;
  const databaseUser = await db.get(selectUserQuery);
  if (databaseUser === undefined) {
    response.status(400);
    response.send("Invalid user");
  } else {
    const isPasswordMatched = await bcrypt.compare(
      password,
      databaseUser.password
    );
    if (isPasswordMatched === true) {
      const payload = {
        username: username,
      };
      const jwtToken = jwt.sign(payload, "MY_SECRET_TOKEN");
      response.send({ jwtToken });
    } else {
      response.status(400);
      response.send("Invalid password");
    }
  }
});


// REGISTER USER

app.post("/users/", async (request, response) => {
  const { username, password, email } = request.body;
  const saltRounds = 15; // Number of salt rounds (can be adjusted based on your security requirements)
  const hashedPassword = await bcrypt.hash(password, saltRounds);

  const selectUserQuery = `SELECT * FROM users WHERE username = '${username}'`;
  const dbUser = await db.get(selectUserQuery);
  if (dbUser === undefined) {
    const createUserQuery = `
      INSERT INTO 
        users (username, password, email) 
      VALUES 
        (
          '${username}', 
            '${hashedPassword}', 
            '${email}'
        )`;
    const dbResponse = await db.run(createUserQuery);
    const newUserId = dbResponse.lastID;
    response.send(`Created new user with ${newUserId}`);
  } else {
    response.status = 400;
    response.send("User already exists");
  }
});


app.get("/recipes/:recipeId", authenticateToken, async (request, response) => {
  const { recipeId } = request.params;
  const getRecipeQuery = `
    SELECT 
      *
    FROM 
      recipes
    WHERE 
      recipe_id = ${recipeId}
  `;
  const recipe = await db.get(getRecipeQuery);
  response.send(recipe);
});

app.post("/recipes/", authenticateToken, async (request, response) => {
  const {
    title,
    description,
    rating,
    ratingCount,
    reviewCount,
    ingredients,
    instructions,
    recipeUrl,
    nutrients,
    category
  } = request.body;

  try {
    const addRecipeQuery = `
      INSERT INTO 
        recipes (title, description, rating, ratingCount, reviewCount, ingredients, instructions, recipe_url, nutrients, category)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    await db.run(addRecipeQuery, [
      title,
      description,
      rating,
      ratingCount,
      reviewCount,
      ingredients,
      instructions,
      recipeUrl,
      nutrients,
      category
    ]);
    response.send({ success: true });
  } catch (error) {
    console.error("Error adding recipe:", error);
    response.status(500).send({ error: "Error adding recipe" });
  }
});


app.put("/recipes/:recipeId", authenticateToken ,async (request, response) => {
  const { recipeId } = request.params;
  const recipeDetails = request.body;
  const {
    title,
    description,
    rating,
    ratingCount,
    reviewCount,
    ingredients,
    instructions,
    recipeUrl,
    nutrients,
    category
  } = recipeDetails;

  try {
    const updateRecipeQuery = `
      UPDATE recipes
      SET
        title = ?,
        description = ?,
        rating = ?,
        ratingCount = ?,
        reviewCount = ?,
        ingredients = ?,
        instructions = ?,
        recipe_url = ?,
        nutrients = ?,
        category = ?
      WHERE
        recipe_id = ?;
    `;
    await db.run(updateRecipeQuery, [
      title,
      description,
      rating,
      ratingCount,
      reviewCount,
      ingredients,
      instructions,
      recipeUrl,
      nutrients,
      category,
      recipeId
    ]);
    response.send({ success: true });
  } catch (error) {
    console.error("Error updating recipe:", error);
    response.status(500).send({ error: "Error updating recipe" });
  }
});


app.delete("/recipes/:recipeId", authenticateToken, async (request, response) => {
  const { recipeId } = request.params;

  const deleteRecipeQuery = `
    DELETE FROM recipes
    WHERE
      recipe_id = ${recipeId};
  `;

  try {
    await db.run(deleteRecipeQuery);
    response.send({ success: true });
  } catch (error) {
    response.status(500).send({ error: "Error deleting recipe" });
  }
});


app.get("/recipes/", authenticateToken , async (request, response) => {
  const {
    offset = 0,
    limit = 10,
    order = "ASC",
    order_by = "recipe_id",
    category = "", // Add category parameter
    search_q = "",
  } = request.query;

  let categoryFilter = "";
  if (category) {
    categoryFilter = `AND category = '${category}'`; // Add category filter
  }

  const getRecipesQuery = `
    SELECT
      *
    FROM
      recipes
    WHERE
      title LIKE '%${search_q}%'
      ${categoryFilter}  -- Include category filter
    ORDER BY ${order_by} ${order}
    LIMIT ${limit} OFFSET ${offset};`;
  
  const recipesArray = await db.all(getRecipesQuery);
  response.send(recipesArray);
});




