package handler

import (
	"admin_management_service/internal/models"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
)

func (h *Handler) UpdateVideoDoc() func(c *gin.Context) {
	return func(c *gin.Context) {
		var err error
		defer func() {
			if err != nil {
				log.Println(err.Error())
			}
		}()

		body := models.VideoDocDto{}
		if err = c.ShouldBindJSON(&body); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "can't bind JSON"})
			return
		}

		if err = h.videoDocIndex.Update(body.ID, body.VideoDoc); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "can't update the video document"})
			return
		}

		c.JSON(http.StatusOK, gin.H{"message": "update the video document successfully"})
	}
}