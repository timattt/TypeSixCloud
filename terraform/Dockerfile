FROM hashicorp/terraform
LABEL authors="timat"

WORKDIR /

COPY ./other .
COPY ./scripts .

RUN mv /.terraformrc ~/.terraformrc
RUN terraform init

ENTRYPOINT terraform apply  -var="type-6-db-username=${TYPE6_DB_USERNAME}" \
                            -var="type-6-db-password=${TYPE6_DB_PASSWORD}" \
                            -var="type-6-folder-id=${TYPE6_FOLDER_ID}" \
                            -var="type-6-cloud-id=${TYPE6_CLOUD_ID}" \
                            -var="type-6-token=${TYPE6_TOKEN}" \
                            -state="/state/state.json" -auto-approve