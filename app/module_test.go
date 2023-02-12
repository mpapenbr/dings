package app

import (
	"testing"
)

func TestModuleName(t *testing.T) {
	if ProjectName() != "dings" {
		t.Errorf("Project name `%s` incorrect", ProjectName())
	}
}
