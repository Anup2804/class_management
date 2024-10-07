import mongoose, { Schema } from "mongoose";

const attendenceSchema = new mongoose.Schema(
  {
      studentId:{
          type: String,
          required:true
      },
      isPresent:{
          type:String,
          required:true
      }

  }
);


const batchesSchema = new mongoose.Schema(
  {
    lectureId: {
      type: mongoose.Types.ObjectId,
      ref: "lectures",
      required: true,
    },
    adminName: {
      type: String,
      trim: true,
      lowercase: true,
      required: true,
    },
    studentData:{
      type: [attendenceSchema],
      required:true
    },
    date: {
      type: Date,
      // required: true,
    },
    inTime: {
      type: Date,
      // required: true,
    },
    inLocation: {
      type: {
        latitude: {
          type: Number,
          // required: true,
          min: -90,
          max: 90,
        },
        longitude: {
          type: Number,
          // required: true,
          min: -180,
          max: 180,
        },
      },
      // required: true,
    },
    outTime: {
      type: Date,
    },
    outLocation: {
      type: {
        latitude: {
          type: Number,
          required: true,
          min: -90,
          max: 90,
        },
        longitude: {
          type: Number,
          required: true,
          min: -180,
          max: 180,
        },
      },
    },
    byTeacher: {
      type: String,
      required:true
    },
  },
  { timestamps: true }
);

export const batches = mongoose.model("batches", batchesSchema);
