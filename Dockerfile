FROM --platform=linux/arm64 public.ecr.aws/sam/build-python3.9:1.62.0

RUN mkdir /tmp/layer
WORKDIR /tmp/layer
ADD requirements.txt /tmp/layer/requirements.txt

CMD ["pip", "install", "-r", "requirements.txt", "-t", "python"]
