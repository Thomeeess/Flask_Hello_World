jobs:
  preview:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build Docker image
        run: docker build -t flask-preview .

      - name: Install ngrok
        run: |
          curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
          echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
          sudo apt update && sudo apt install ngrok -y

      - name: Run Flask and Ngrok
        run: |
          docker run -d --name flask-server -p 5000:5000 flask-preview
          ngrok http 5000 --log=stdout &
          sleep 5
          curl -s http://127.0.0.1:4040/api/tunnels | jq
