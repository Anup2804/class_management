import mongoose from "mongoose";
import {asyncHandler} from '../utils/asyncHandler.js';
import {apiError} from '../utils/apiError.js';
import { apiResponse } from "../utils/apiResponse.js";
import { teachers } from "../model/teachers.model.js";
import {students} from "../model/students.model.js";
import { lectures } from "../model/lecture.model.js";


const postBatches = asyncHandler(async(req,res)=>{
    
})



export {}
