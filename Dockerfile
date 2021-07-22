FROM alphine:3.10

RUN npm install --global --unsafe-perm @aws-amplify/cli

COPY amplify.sh /amplify.sh
ENTRYPOINT ["/amplify.sh"]