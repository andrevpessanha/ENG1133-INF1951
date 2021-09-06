//--------------------------------------------------------------------------
//Function para incrementar a quantidade de vezes que um Quiz foi concluído
//--------------------------------------------------------------------------
Parse.Cloud.define('quizIncrementQtdCompleted', async (request) => {
  const query = new Parse.Query("Quiz");

  query.get(request.params.id, { useMasterKey: true }).then(function (quiz) {
    quiz.increment("qtdCompleted");
    quiz.save(null, { useMasterKey: true }).then(function () {
      console.log("success -> quizIncrementQtdCompleted");
    }, function (error) {
      console.error('Error: quizIncrementQtdCompleted' + error.message);
      throw new Error('Error: quizIncrementQtdCompleted' + error.message);
    });
  }, function (error) {
    throw new Error('quizIncrementQtdCompleted: Error: ' + error.code + ' : ' + error.message);
  });
})

//--------------------------------------------------------------------------
//Function para incrementar a quantidade de Quizzes concluídos por um Usuário
//--------------------------------------------------------------------------
Parse.Cloud.define('userIncrementQtdCompletedQuizzes', async (request) => {
  const query = new Parse.Query("User");

  query.get(request.params.id, { useMasterKey: true }).then(function (user) {
    user.increment("qtdCompletedQuizzes");
    user.save(null, { useMasterKey: true }).then(function () {
      console.log("success -> userIncrementQtdCompletedQuizzes");
    }, function (error) {
      console.error('Error: userIncrementQtdCompletedQuizzes' + error.message);
      throw new Error('Error: userIncrementQtdCompletedQuizzes' + error.message);
    });
  }, function (error) {
    throw new Error('userIncrementQtdCompletedQuizzes: Error: ' + error.code + ' : ' + error.message);
  });
})

