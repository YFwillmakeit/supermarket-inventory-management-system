//http://47.94.160.46:8080/swagger-ui.html
// module.exports = {
//     devServer: {
//         proxy: {
//             '/api/': {
//                 target: 'http://47.94.160.46:8080/',
//                 changeOrigin: true, //是否选择性改变跨域
//                 pathRewrite:{
//                     '^/api':''  //做替换
//                 }
//             }
//         }
//     }
// };
module.exports={
    devServer:{
        proxy:{
            '/api':{
                target:"http://172.17.1.206:8080/",
                pathRewrite:{
                    "^/api":''
                },
                changeOrigin:true
            }
        }
    }
}
