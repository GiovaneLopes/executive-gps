"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
admin.initializeApp();
const auth = admin.auth();
exports.deleteUser = functions.https.onCall(async (data) => {
    const uid = data.data.uid;
    if (!uid) {
        throw new functions.https.HttpsError("invalid-argument", "Uid required.");
    }
    try {
        await auth.deleteUser(uid);
        return { success: true };
    }
    catch (error) {
        console.error("Erro ao deletar o usuário com UID: ${uid}", error);
        throw new functions.https.HttpsError("internal", "Error.", error);
    }
});
exports.createUserByAdmin = functions.https.onCall(async (data) => {
    console.log("Dados recebidos para criação de usuário:", data);
    const email = data.data.email;
    const password = data.data.password;
    if (!email || !password) {
        throw new functions.https.HttpsError("invalid-argument", "E-mail e senha são obrigatórios.");
    }
    try {
        const user = await auth.createUser({
            email: email,
            password: password,
        });
        return { uid: user.uid };
    }
    catch (error) {
        console.error("Erro ao criar novo usuário:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Ocorreu um erro ao tentar criar o usuário.");
    }
});
//# sourceMappingURL=index.js.map