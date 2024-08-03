import mongoose, { Schema } from "mongoose";

const testNoticeSchema = new mongoose.Schema(
  {
    byTeacher: {
      type: Schema.Types.ObjectId,
      ref: "teachers",
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
    time: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
    board: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

export const testNotices = new mongoose.model("testNotices", testNoticeSchema);
