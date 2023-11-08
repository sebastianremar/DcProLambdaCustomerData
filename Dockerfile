# Use the provided AWS Lambda Go runtime as the base image
FROM public.ecr.aws/lambda/go:1

# Copy the Go executable binary to the container image.
COPY main ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler (assuming your module is named 'lambda-function')
CMD [ "lambda-function" ]
