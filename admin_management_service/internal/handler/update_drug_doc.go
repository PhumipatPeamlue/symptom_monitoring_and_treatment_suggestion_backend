package handler

import (
	"admin_management_service/internal/models"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"time"
)

func (h *Handler) UpdateDrugDoc() func(c *gin.Context) {
	return func(c *gin.Context) {
		var err error
		defer func() {
			if err != nil {
				log.Println(err.Error())
			}
		}()

		body := models.DrugDocDto{}
		if err = c.ShouldBindJSON(&body); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "can't bind JSON"})
			return
		}

		statusCode, err, getResult := h.drugDocIndex.Get(body.ID)
		if statusCode == 500 {
			h.handleInternalServerError(c)
			return
		}
		if statusCode == 404 {
			h.handleNotFound(c, body.ID)
			return
		}
		if statusCode != 200 {
			c.JSON(statusCode, gin.H{"message": err.Error()})
			return
		}

		body.DrugDoc.CreateAt = getResult.Source.CreateAt
		body.DrugDoc.UpdateAt = time.Now()
		statusCode, err = h.drugDocIndex.Update(body.ID, body.DrugDoc)
		if statusCode == 500 {
			h.handleInternalServerError(c)
			return
		}
		if statusCode == 404 {
			h.handleNotFound(c, body.ID)
			return
		}
		if statusCode != 200 {
			c.JSON(statusCode, gin.H{"message": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"message": "update the drug document successfully"})
	}
}
