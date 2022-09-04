package main

import (
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"

	"github.com/360EntSecGroup-Skylar/excelize/v2"
	uuid "github.com/satori/go.uuid"
)

// excel 格式
// 礼包ID	兑换类型	生成个数	起始时间（时间戳）	截止时间（时间戳）
// 10001	1	2	1234	223
// 10002	2	3	1234	223
// 10003	3	4	1234	223
// 10004	4	5	1234	223
// 10005	5	6	1234	223
// 10006	6	7	1234	223

const Usage string = `usage : gen.exe
Warning: must has file named custom_code.xlsx for parse
format: reward_id gift_type num star_time end_time`

const ConfigFile string = "custom_code.xlsx"
const GenFile string = "gen.txt"

type CustomData struct {
	RewardId  int
	GiftType  int
	GenNum    int
	StartTime int
	EndTime   int
	Codes     []string
}

func main() {
	rfile, err := excelize.OpenFile(ConfigFile)
	if err != nil {
		fmt.Println(err.Error())
		fmt.Println(Usage)
		return
	}

	sheet_name := rfile.GetSheetName(0)
	rows, err := rfile.GetRows(sheet_name)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	if len(rows) < 2 {
		fmt.Println("No Data To Parse")
		return
	}

	var datas []CustomData

	// 解析数据
	for i := 1; i < len(rows); i++ {
		var data CustomData
		var e error
		data.RewardId, e = strconv.Atoi(rows[i][0])
		if e != nil {
			fmt.Printf("row line:%d, err:%s\n", i+1, e.Error())
			continue
		}
		data.GiftType, e = strconv.Atoi(rows[i][1])
		if e != nil {
			fmt.Printf("row line:%d, err:%s\n", i+1, e.Error())
			continue
		}
		data.GenNum, e = strconv.Atoi(rows[i][2])
		if e != nil {
			fmt.Printf("row line:%d, err:%s\n", i+1, e.Error())
			continue
		}
		data.StartTime, e = strconv.Atoi(rows[i][3])
		if e != nil {
			fmt.Printf("row line:%d, err:%s\n", i+1, e.Error())
			continue
		}
		data.EndTime, e = strconv.Atoi(rows[i][4])
		if e != nil {
			fmt.Printf("row line:%d, err:%s\n", i+1, e.Error())
			continue
		}

		datas = append(datas, data)
	}

	//fmt.Printf("Total Num:%d Data For Gen\n", len(datas))
	// fmt.Println(datas)

	for k := range datas {
		GenCode(&datas[k])
	}

	// 对应礼包码写入文件
	wfile, err := os.OpenFile(GenFile, os.O_CREATE|os.O_RDWR|os.O_TRUNC, 0644)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	defer wfile.Close()

	var total_cnt int
	for _, v := range datas {
		for _, code := range v.Codes {
			s1 := fmt.Sprintf("%s\t%d\t%d\t%d\t%d\t%d\n", code, v.RewardId, v.GiftType, 1, v.StartTime, v.EndTime)
			io.WriteString(wfile, s1)

			total_cnt += 1
		}
	}

	fmt.Printf("Config Source: %d Numer Data Parse To %d Code\n", len(datas), total_cnt)
}

// todo generate unique code
func GenCode(p *CustomData) {
	for i := 0; i < p.GenNum; i++ {
		s1 := GenUUid()
		p.Codes = append(p.Codes, s1)
	}
}

func GenUUid() string {
	var err error
	u1 := uuid.Must(uuid.NewV4(), err)
	s1 := u1.String()
	us := strings.ToUpper(s1)
	return us
}
