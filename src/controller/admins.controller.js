import mongoose from "mongoose";
import { admins } from "../model/admins.model.js";
import { asyncHandler } from "../utils/asyncHandler.js";
import { apiError } from "../utils/apiError.js";
import { apiResponse } from "../utils/apiResponse.js";

const generateAccessTokenAndRefreshToken = async (userId) => {
  // This function generates the access token for user after login.
  try {
    const admin = await admins.findById(userId);
    const generateAccessToken = admin.generateAccessToken();
    const generateRefreshToken = admin.generateRefreshToken();

    admin.refreshToken = generateRefreshToken;
    await admin.save({ validateBeforeSave: false });

    return { generateAccessToken, generateRefreshToken };
  } catch (err) {
    throw new apiError(500, "something went worng");
  }
};

const adminRegister = asyncHandler(async (req, res) => {
  const { name, email, password } = req.body;

  if (!name && !email && !password) {
    throw new apiError(402, "name ,email or password is required.");
  }

  const adminData = await admins.findOne({ name: name });

  if (adminData) {
    throw new apiError(405, "admin with this name already exist.");
  }

  const admin = await admins.create({
    adminName: name,
    email,
    password,
  });

  if (!admin) {
    throw new apiError(405, "error in creating the admin.");
  }

  const adminDetail = await admins
    .findOne(admin._id)
    .select("-password -refereshToken");

  return res
    .status(200)
    .json(new apiResponse(200, adminDetail, "admin created."));
});

const adminLogin = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  if (!email && !password) {
    throw new apiError(402, "email or password is required.");
  }

  const getadmin = await admins.findOne({ email });

  if (!getadmin) {
    throw new apiError(402, "user with email does not exist.");
  }

  const passwordValid = await getadmin.isPasswordCorrect(password);

  if (!passwordValid) {
    throw new apiError(404, "password is invaild.");
  }

  const { generateAccessToken, generateRefreshToken } =
    await generateAccessTokenAndRefreshToken(getadmin._id);

  const loggedInAdmin = await admins
    .findById(getadmin._id)
    .select("-password -refreshToken");

  const option = {
    httpOnly: true,
    secure: true,
  };

  return res
    .status(200)
    .cookie("accessToken", generateAccessToken, option)
    .cookie("refreshToken", generateRefreshToken, option)
    .json(
      new apiResponse(
        200,
        {
          adminDetails: loggedInAdmin,
          generateAccessToken,
          generateRefreshToken,
        },
        "admin login successful."
      )
    );
});

const adminLogout = asyncHandler(async(req,res)=>{
    req.admin._id;
    // console.log(req.user)
    await admins.findByIdAndUpdate(
      req.admin._id,
      {
        $set: {
          refreshToken: "",
        },
      },
      {
        new: true,
      }
    );
  
    const option = {
      httpOnly: true,
      secure: true,
    };
  
    return res
      .status(200)
      .clearCookie("accessToken", option)
      .clearCookie("refreshToken", option)
      .json(new apiResponse(200, {}, "User logout successful"));
  });

export { adminRegister, adminLogin ,adminLogout};
