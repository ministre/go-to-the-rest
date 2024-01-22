package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
)

type Config struct {
	URL    string `json:"url"`
	Method string `json:"method"`
	Token  string `json:"token"`
}

func main() {
	// Read config.json
	data, err := os.ReadFile("config.json")
	if err != nil {
		panic(err)
	}

	// Unpack config
	var config Config
	err = json.Unmarshal(data, &config)
	if err != nil {
		panic(err)
	}

	// Sending request to backend
	jsonStr := []byte(`{}`)
	req, err := http.NewRequest(config.Method, config.URL, bytes.NewBuffer(jsonStr))
	req.Header.Set("Content-Type", "application/json")
	if config.Token != "" {
		req.Header.Set("Authorization", config.Token)
	}
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			panic(err)
		}
	}(resp.Body)

	// Print response
	fmt.Println("response Status:", resp.Status)

}
