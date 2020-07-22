// 验证各种输入数据

const validator={
	// 验证输入字符长度为,接收两个参数,一个为字符值val,第二个为需要验证的最小长度minlen和最大字符长度maxlen,正确返回true否则返回false
	vCharLength:function(val,minlen,maxlen){
		val=val.trim();
		if(val.length>maxlen || val.length<minlen) return false
		else return true
	}
}

export default validator
