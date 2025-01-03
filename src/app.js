import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import dotenv from "dotenv";
import cron from "node-cron";
import { schedulingLectureForToday } from "./controller/timeTable.controller.js";

const app = express();

dotenv.config();

app.use(
  // This is to give the access to everyone of database or to specific server.
  cors({
    origin: process.env.CORS_ORIGIN,
    credentials: true,
  })
);

//additonal middleware to work with the header.
// app.use((req, res, next) => {
//   if (req.method === "POST") {
//     req.headers["content-type"] = "application/json";
//   }
//   next();
// });

app.use(express.json()),
  app.use(express.urlencoded({ extended: true, limit: "1mb" })),
  app.use(express.static("public")),
  app.use(cookieParser());
app.use((err, req, res, next) => {
  let statusCode = 500;

  if (err.code === "ENOENT") {
    statusCode = 404;
  } else if (err.code === "EACCES") {
    statusCode = 403;
  } else if (err.code === "EPERM") {
    statusCode = 403;
  } else if (
    typeof err.code === "number" &&
    err.code >= 100 &&
    err.code < 600
  ) {
    statusCode = err.code;
  }

  res.status(statusCode).json({
    success: false,
    message: err.message,
  });
});

// import router

import studentsRouter from "./routes/students.router.js";
import teachersRouter from "./routes/teachers.routes.js";
import lecturesRouter from "./routes/lectures.router.js";
import testsRouter from "./routes/tests.router.js";
import notesRouter from "./routes/notes.router.js";
import marksRouter from "./routes/marks.router.js";
import adminsRouter from "./routes/admins.router.js";
import batchRouter from "./routes/batches.router.js";
import timeTableRouter from "./routes/timeTable.router.js";
// intialisation of router

app.use("/api/v1/student", studentsRouter);
app.use("/api/v1/teacher", teachersRouter);
app.use("/api/v1/lecture", lecturesRouter);
app.use("/api/v1/test", testsRouter);
app.use("/api/v1/notes", notesRouter);
app.use("/api/v1/marks", marksRouter);
app.use("/api/v1/admins", adminsRouter);
app.use("/api/v1/batches", batchRouter);
app.use("/api/v1/timetable", timeTableRouter);

// Run the schedule function when the app starts
// schedulingLectureForToday();

// Schedule the lecture function to run daily at midnight (00:00)
cron.schedule("0 0 * * *", async () => {
  console.log("Running automated lecture scheduling...");
  const currentDate = new Date();
  console.log(`Running scheduled task at: ${currentDate.toLocaleString()}`);
  try {
    await schedulingLectureForToday();
  } catch {
    console.error("Error in scheduled task:", error);
  }
});

export { app };
