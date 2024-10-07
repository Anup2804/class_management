import mongoose, { Schema } from "mongoose";

const timetableSchema = new mongoose.Schema({
  standard: { 
    type: String, 
    required: true 
  },
  board: { 
    type: String, 
    required: true,
    uppercase: true 
  },
  adminEmail: {
    type: String,
    required: true,
    trim: true
  },
  days: [{
    day: { 
      type: String, 
      required: true 
    },
    lectures: [{
      lectureName: { 
        type: String, 
        required: true 
      },
      time: { 
        type: String, 
        required: true 
      },
      description: { 
        type: String 
      },
      byTeacher: {
        type: Schema.Types.ObjectId,
        ref: "teachers",
        required: true
      },
      teacherName:{
        type:String,
        required:true
      }
    }]
  }]
}, { timestamps: true });

export const Timetable = mongoose.model("Timetable", timetableSchema);
