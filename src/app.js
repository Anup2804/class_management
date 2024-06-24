import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import dotenv from "dotenv";

const app = express();

dotenv.config();

app.use(
  // This is to give the access to everyone of database or to specific server.
  cors({
    origin: process.env.CORS_ORIGIN,
    credentials: true,
  })
);

app.use(express.json({ limit: "1mb" })),
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

import studentRouter from "./routes/student.router.js";
import teacherRouter from "./routes/teacher.routes.js";
import lectureRouter from "./routes/lecture.router.js";
import testRouter from "./routes/test.router.js";
// intialisation of router

app.use("/api/v1/student", studentRouter);
app.use("/api/v1/teacher", teacherRouter);
app.use("/api/v1/teacher/lecture", lectureRouter);
app.use("/api/v1/teacher/test", testRouter);

export { app };
