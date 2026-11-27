#Builder Stage

FROM ubuntu:latest AS builder

WORKDIR /app

RUN echo "Multi-Stage build is Successfull" > message.txt

# Stage 2 or Final image

FROM ubuntu:latest AS final

WORKDIR /app

COPY --from=builder /app/message.txt .

CMD ["cat","message.txt"]

