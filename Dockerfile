FROM 628053151772.dkr.ecr.sa-east-1.amazonaws.com/awslambda/nodejs12.x-runtime:beta

ARG FUNCTION_DIR="/var/task"

RUN mkdir -p ${FUNCTION_DIR}

COPY package.json ${FUNCTION_DIR}

COPY src ${FUNCTION_DIR}/src

RUN npm install

CMD [ "src/handler.run" ]