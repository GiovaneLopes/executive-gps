import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
const auth = admin.auth();


exports.deleteUser = functions.https.onCall(
  async (data: any) => {
    const uid = data.data.uid as string;

    if (!uid) {
      throw new functions.https.HttpsError("invalid-argument", "Uid required.");
    }

    try {
      await auth.deleteUser(uid);
      return {success: true};
    } catch (error) {
      console.error("Erro ao deletar o usuário com UID: ${uid}", error);
      throw new functions.https.HttpsError("internal", "Error.", error);
    }
  });

exports.createUserByAdmin = functions.https.onCall(
  async (data: any) => {
    console.log("Dados recebidos para criação de usuário:", data);
    const email = data.data.email as string;
    const password = data.data.password as string;

    if (!email || !password) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "E-mail e senha são obrigatórios."
      );
    }

    try {
      const user = await auth.createUser({
        email: email,
        password: password,
      });

      return {uid: user.uid};
    } catch (error) {
      console.error("Erro ao criar novo usuário:", error);
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }
      throw new functions.https.HttpsError(
        "internal",
        "Ocorreu um erro ao tentar criar o usuário."
      );
    }
  });
