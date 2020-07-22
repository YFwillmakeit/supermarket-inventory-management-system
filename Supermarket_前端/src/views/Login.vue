
<template>
	<div id="main">
		<div class="body">
			<div class="container">
				<div class="box">
					<h2>超市后台管理系统</h2>
					<form>
						<div class="inputBox">
							<input type="text" name="" required="">
							<label>用户名</label>
						</div>
						<div class="inputBox">
							<input type="password" name="" required="">
							<label>密码</label>
						</div>
						<div class="submit">
							<input type="submit" name="" value="登录"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
    export default {
        name: "Login"
    }

</script>

<style >
	body{
		margin: 0;
		
	}
	#main{
		margin: 0;
		padding: 0;
		font-family: sans-serif;
		background-image:url("../assets/img/supermaket.png");
		background-size: cover;
		height:100vh
	}
	

	
	.box {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 400px;
		padding: 40px;
		background: rgba(0, 0, 0, .8);
		box-sizing: border-box;
		box-shadow: 0 15px 25px rgba(0, 0, 0, .5);
		border-radius: 10px;
		/*登录窗口边角圆滑*/
	}
	
	.box h2 {
		margin: 0 0 30px;
		padding: 0;
		color: #fff;
		text-align: center;
	}
	
	.box .inputBox {
		position: relative;
	}
	
	.box .inputBox input {
		width: 100%;
		padding: 10px 0;
		font-side: 16px;
		color: #fff;
		letter-spacing: 1px;
		margin-bottom: 30px;
		/*输入框设置*/
		border: none;
		border-bottom: 1px solid #fff;
		outline: none;
		background: transparent;
	}
	
	.box .inputBox label {
		position: absolute;
		top: 0;
		left: 0;
		padding: 10px 0;
		font-size: 16px;
		color: #fff;
		pointer-events: none;
		transition: .5s;
	}
	
	.box .inputBox input:focus~label,
	.box .inputBox input:valid~label {
		top: -18px;
		left: 0;
		color: #03a9f4;
		font-size: 12px;
	}
	
	.box input[type="submit"] {
		background: transparent;
		border: none;
		outline: none;
		color: #fff;
		background: #03a9f4;
		padding: 10px 20px;
		cursor: pointer;
		border-radius: 5px;
	}
	
	.submit{
		text-align: center;
	}
</style>
<template>
	<div id="main">
		<div class="body">
			<div class="container">
				<div class="box">
					<h2>商店后台管理系统</h2>
					<div style="text-align: center;">
						<span style="color: red;">{{err}}</span>
					</div>
					<form>
						<div class="inputBox">
							<input type="text" name="" required="" v-model="userName">
							<label>用户名</label>
						</div>
						<div class="inputBox">
							<input type="password" name="" required="" v-model="password">
							<label>密码</label>
						</div>
						<div class="submit">
							 <!--  @click.prevent="btn"-->
							<input type="submit" value="登录" @click.prevent="login" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import http from '../util/http.js' 
    export default {
        name: "Login",
		data() {
			return{
				userName:'',
				password:'',
				err:''
			}
		},
		methods: {
			login(){
				http({
					method: 'post',
					url: 'login',
					params: {
						username: this.userName,
						password: this.password
					}
				}).then(res=> {
					console.log(res)
					if(res.data.code === 200){
						window.localStorage.setItem("userName", this.userName)
						this.$router.replace('/all')
						console.log(this.userName)
						console.log(this.password)
						console.log(typeof(this.userName))
					}
					else{
						this.err = "";
						this.$router.replace("/")
						this.err=this.err.concat("账号或密码错误")
					}
				}).catch(err=> {
					console.log("error")
					/* console.log(this.err) */
				})
				
				
			}
			
		},
		
		
		
		
		
		
		
		
		/* ,
		created() {
			let _this =  this;
			http({
				method: 'post',
				url: 'login',
				params: {
					username: "liuhai",
					password: "123456"
				}
			}).then(function(res) {
				console.log(res.data)
			}).catch(function() {
				console.log("error！");
			})
			
		} */
    }

</script>

<style scoped>
	body{
		margin: 0;

	}
	#main{
		margin: 0;
		padding: 0;
		font-family: sans-serif;
		background-image:url("../assets/img/supermaket.png");
		background-size: cover;
		height:100vh
	}



	.box {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 400px;
		padding: 40px;
		background: rgba(0, 0, 0, .8);
		box-sizing: border-box;
		box-shadow: 0 15px 25px rgba(0, 0, 0, .5);
		border-radius: 10px;
		/*登录窗口边角圆滑*/
	}

	.box h2 {
		margin: 0 0 30px;
		padding: 0;
		color: #fff;
		text-align: center;
	}

	.box .inputBox {
		position: relative;
	}

	.box .inputBox input {
		width: 100%;
		padding: 10px 0;
		font-side: 16px;
		color: #fff;
		letter-spacing: 1px;
		margin-bottom: 30px;
		/*输入框设置*/
		border: none;
		border-bottom: 1px solid #fff;
		outline: none;
		background: transparent;
	}

	.box .inputBox label {
		position: absolute;
		top: 0;
		left: 0;
		padding: 10px 0;
		font-size: 16px;
		color: #fff;
		pointer-events: none;
		transition: .5s;
	}

	.box .inputBox input:focus~label,
	.box .inputBox input:valid~label {
		top: -18px;
		left: 0;
		color: #03a9f4;
		font-size: 12px;
	}

	.box input[type="submit"] {
		background: transparent;
		border: none;
		outline: none;
		color: #fff;
		background: #03a9f4;
		padding: 10px 20px;
		cursor: pointer;
		border-radius: 5px;
	}

	.submit{
		text-align: center;
	}
</style>
