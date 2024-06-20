import { app } from "./app.js";
import connectDB from "./db/index.js";
import dotenv from "dotenv";

dotenv.config({
  path: "./.env",
});

connectDB()
  .then((port = process.env.PORT || 8000) => {
    app.listen(port, () => {
      console.log(`connectd to port ${port}`);
    });
  })
  .catch((err) => {
    console.log("connection failed!!", err);
  });
