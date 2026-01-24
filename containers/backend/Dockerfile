FROM ruby:3.2.2

#===================
# packageセットアップ
#===================
RUN apt-get update && apt-get install -y \
  nodejs \
  npm \
  default-mysql-client \
  less \
  vim \
  curl \
  sudo

RUN npm i -g n && n 24.0.0

#======================
# プロジェクトセットアップ
#======================
WORKDIR /app

# gem
COPY volumes/backend/Gemfile* .
RUN bundle install

# entrypoint
COPY containers/backend/scripts/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

CMD ["/entrypoint.sh"]

EXPOSE 3000
