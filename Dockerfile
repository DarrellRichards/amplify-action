FROM node:lts

RUN npm install --global --unsafe-perm @aws-amplify/cli

COPY amplify.sh /amplify.sh
ENTRYPOINT ["/amplify.sh"]