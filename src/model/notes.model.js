import mongoose, { Schema } from "mongoose";

const notesSchema = new mongoose.Schema(
  {
    byTeacher: {
      type: Schema.Types.ObjectId,
      ref: "teachers",
      required: true,
    },
    adminEmail: {
      type: String,
      trim: true,
      required: true,
    },
    subjectName: {
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
    notes: {
      type: String,
      required: true,
    },
    board: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

export const notes = mongoose.model("notes", notesSchema);
