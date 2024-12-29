import mongoose, { Schema } from "mongoose";

const lectureSchema = new mongoose.Schema(
  {
    byTeacher: {
      type: Schema.Types.ObjectId,
      ref: "teachers",
      required: true,
    },
    adminEmail:{
      type:String,
      trim:true,
      required:true
    },
    lectureName: {
      type: String,
      required: true,
    },
    standard: {
      type: String,
      required: true,
    },
    date: {
      type: String,
      required: true,
      default:"Everyday"
    },
    startTime: {
      type: String,
      required: true,
    },
    endTime: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
    board: {
      type: String,
      required: true,
      uppercase:true
    },
  },
  { timestamps: true }
);

export const lectures = new mongoose.model(
  "lectures",
  lectureSchema
);
