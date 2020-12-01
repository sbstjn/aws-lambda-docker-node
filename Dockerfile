FROM amazon/aws-lambda-nodejs:12

ARG FUNCTION_DIR="/var/task"

RUN mkdir -p ${FUNCTION_DIR}

COPY package.json ${FUNCTION_DIR}

COPY src ${FUNCTION_DIR}/src

RUN npm install

CMD [ "src/handler.run" ]