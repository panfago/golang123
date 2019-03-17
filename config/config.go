package config

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
	"strings"
	"unicode/utf8"

	"github.com/shen100/golang123/utils"
)

var jsonData map[string]interface{}

type mySqlDBConfig struct {
	Dialect      string
	Database     string
	User         string
	Password     string
	Host         string
	Port         int
	Charset      string
	URL          string
	MaxIdleConns int
	MaxOpenConns int
}

type postgresDBConfig struct {
	Dialect      string
	Database     string
	User         string
	Password     string
	Host         string
	Port         int
	Charset      string
	SSLMode      string
	ConnInfo     string
	MaxIdleConns int
	MaxOpenConns int
}

func initJSON() {
	bytes, err := ioutil.ReadFile("./config.json")
	if err != nil {
		fmt.Println("ReadFile: ", err.Error())
		os.Exit(-1)
	}

	configStr := string(bytes[:])
	// comment style 1
	reg := regexp.MustCompile(`/\*.*\*/`)
	configStr = reg.ReplaceAllString(configStr, "")
	bytes = []byte(configStr)

	if err := json.Unmarshal(bytes, &jsonData); err != nil {
		fmt.Println("invalid config: ", err.Error())
		os.Exit(-1)
	}
}

var PostgresDBConfig postgresDBConfig

// MysqlDBConfig 数据库相关配置
var MysqlDBConfig mySqlDBConfig

func initDBMysql() {
	var url = ""
	utils.SetStructByJSON(&MysqlDBConfig, jsonData["database_mysql"].(map[string]interface{}))
	url = fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=%s&parseTime=True&loc=Local",
		MysqlDBConfig.User, MysqlDBConfig.Password, MysqlDBConfig.Host, MysqlDBConfig.Port, MysqlDBConfig.Database, MysqlDBConfig.Charset)
	MysqlDBConfig.URL = url
	fmt.Println("url: " + url)

}

func initDBPostgres() {
	var connInfo = ""
	utils.SetStructByJSON(&PostgresDBConfig, jsonData["database_postgres"].(map[string]interface{}))
	connInfo = fmt.Sprintf("host=%s port=%d user=%s dbname=%s password=%s sslmode=%s",
		PostgresDBConfig.Host, PostgresDBConfig.Port, PostgresDBConfig.User, PostgresDBConfig.Database, PostgresDBConfig.Password, PostgresDBConfig.SSLMode)
	PostgresDBConfig.ConnInfo = connInfo
	fmt.Println("connInfo: " + connInfo)
}

type redisConfig struct {
	Host      string
	Port      int
	Password  string
	URL       string
	MaxIdle   int
	MaxActive int
}

// RedisConfig redis相关配置
var RedisConfig redisConfig

func initRedis() {
	utils.SetStructByJSON(&RedisConfig, jsonData["redis"].(map[string]interface{}))
	url := fmt.Sprintf("%s:%d", RedisConfig.Host, RedisConfig.Port)
	RedisConfig.URL = url
}

type mongoConfig struct {
	URL      string
	Database string
}

// MongoConfig mongodb相关配置
var MongoConfig mongoConfig

func initMongo() {
	utils.SetStructByJSON(&MongoConfig, jsonData["mongodb"].(map[string]interface{}))
}

type serverConfig struct {
	APIPoweredBy       string
	SiteName           string
	Host               string
	ImgHost            string
	Env                string
	LogDir             string
	LogFile            string
	APIPrefix          string
	UploadImgDir       string
	ImgPath            string
	MaxMultipartMemory int
	Port               int
	StatsEnabled       bool
	TokenSecret        string
	TokenMaxAge        int
	PassSalt           string
	LuosimaoVerifyURL  string
	LuosimaoAPIKey     string
	CrawlerName        string
	MailUser           string //域名邮箱账号
	MailPass           string //域名邮箱密码
	MailHost           string //smtp邮箱域名
	MailPort           int    //smtp邮箱端口
	MailFrom           string //邮件来源
	Github             string
	BaiduPushLink      string
}

// ServerConfig 服务器相关配置
var ServerConfig serverConfig

func initServer() {
	utils.SetStructByJSON(&ServerConfig, jsonData["go"].(map[string]interface{}))
	sep := string(os.PathSeparator)
	execPath, _ := os.Getwd()
	length := utf8.RuneCountInString(execPath)
	lastChar := execPath[length-1:]
	if lastChar != sep {
		execPath = execPath + sep
	}
	if ServerConfig.UploadImgDir == "" {
		pathArr := []string{"website", "static", "upload", "img"}
		uploadImgDir := execPath + strings.Join(pathArr, sep)
		ServerConfig.UploadImgDir = uploadImgDir
	}

	ymdStr := utils.GetTodayYMD("-")

	if ServerConfig.LogDir == "" {
		ServerConfig.LogDir = execPath
	} else {
		length := utf8.RuneCountInString(ServerConfig.LogDir)
		lastChar := ServerConfig.LogDir[length-1:]
		if lastChar != sep {
			ServerConfig.LogDir = ServerConfig.LogDir + sep
		}
	}
	ServerConfig.LogFile = ServerConfig.LogDir + ymdStr + ".log"
}

type statsdConfig struct {
	URL    string
	Prefix string
}

// StatsDConfig statsd相关配置
var StatsDConfig statsdConfig

func initStatsd() {
	utils.SetStructByJSON(&StatsDConfig, jsonData["statsd"].(map[string]interface{}))
}

func init() {
	initJSON()
	//initDBMysql()
	initDBPostgres()
	initRedis()
	initMongo()
	initServer()
	initStatsd()
}
