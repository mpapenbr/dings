package cmd

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"os/signal"

	"github.com/spf13/cobra"
)

var addr string

func NewServerCmd() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "server",
		Short: "creates a server.",
		PreRunE: func(cmd *cobra.Command, args []string) error {
			return nil
		},
		Run: func(cmd *cobra.Command, args []string) {
			runServer(cmd.Context())
		},
	}

	cmd.Flags().StringVar(&addr, "addr", "localhost:8080",
		"server listen address")

	return cmd
}

func runServer(ctx context.Context) {
	ch := make(chan error)
	startServer := func() {
		fmt.Printf("Starting server on %s\n", addr)
		mux := http.NewServeMux()
		mux.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
			w.WriteHeader(http.StatusOK)
			fmt.Fprintf(w, "ok")
		})
		//nolint:gosec // by design
		server := &http.Server{
			Addr:    addr,
			Handler: mux,
		}

		err := server.ListenAndServe()
		ch <- err
	}
	go startServer()

	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, os.Interrupt)

	select {
	case <-ctx.Done():
		fmt.Printf("context closed\n")
	case v := <-sigChan:
		fmt.Printf("Got signal %v\n", v)
	case err := <-ch:
		fmt.Printf("Server terminated %s\n", err)
	}
}
