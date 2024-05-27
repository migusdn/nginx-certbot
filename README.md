# 백엔드 서버 구성 자동화

> Docker Compose 를 이용한 Backend 서버 구성 자동화


## Installation
1. [Install docker-compose](https://docs.docker.com/compose/install/#install-compose).

2. Clone this repository: `git clone https://github.com/migusdn/nginx-certbot.git .`

3. Modify configuration:
- data/config 폴더 안의 docker compose config 와 nginx config 파일을 수정한다.
- ${} 로 감싸진 부분은 install.sh 파일에서 자동으로 변경된다.

4. Run the init script:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```  
      

5. Run the server:

        docker-compose up

## License
All code in this repository is licensed under the terms of the `MIT License`. For further information please refer to the `LICENSE` file.
