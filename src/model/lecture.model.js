import mongoose,{Schema} from "mongoose";


const lectureSchema = new mongoose.Schema(
    {
        byTeacher:{
            type:Schema.Types.ObjectId,
            ref:'teachers',
            required:true
        },
        lectureName:{
            type:String,
            required:true
        },
        standard:{
            type:String,
            required:true
        },
        time:{
            type:String,
            required:true
        }
    },{timestamps:true}
)


export const lectureNotices = new mongoose.model('lectureNotices',lectureSchema)