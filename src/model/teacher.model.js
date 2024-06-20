import mongoose, {Schema} from "mongoose";


const hiredSubject = new mongoose.Schema(
    {
        subjectName:{
            type:String
        }
    }
)



const teacherSchema = new mongoose.Schema(
    {
        fullName:{
            type:String,
            required:true
        },
        qualification:{
            type:String,
            
        },
        email:{
            type:String,
            required:true
        },
        password:{
            type:String,
            required:true
        },
        hiredForSubject:{
            type:[hiredSubject],
            
        }   
    },{timestamps:true}
)


export const Teachers = mongoose.model('Teachers',teacherSchema)