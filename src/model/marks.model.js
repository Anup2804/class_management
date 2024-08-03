import mongoose, { Schema } from "mongoose";

const marksSchema = new mongoose.Schema(
  {
    byTeacher: {
      type: Schema.Types.ObjectId,
      ref: "teachers",
      required: true,
    },
    adminName: {
      type: String,
      trim: true,
      lowercase: true,
      required: true,
    },
    subjectName: {
      type: String,
      required: true,
    },
    board: {
      type: String,
      required: true,
    },
    chapterNo: {
      type: String,
      required: true,
    },
    standard: {
      type: String,
      required: true,
    },
    file: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
  },
  { timestamps: true }
);

export const marks = mongoose.model("marks", marksSchema);
