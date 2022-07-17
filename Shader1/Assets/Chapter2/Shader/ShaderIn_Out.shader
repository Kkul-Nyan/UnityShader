Shader "ShaderStudy/Test/Chapter2/ShaderIn_Out"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //텍스쳐를 입력받는 변수
        //Albedo(RGB) 는 알파값없이 RGB채널만 사용하겠다는 의미
        //2D는 이 인터페이스 2D "텍스쳐"를 받는다는 의미이다.
        //white는 이 텍스쳐 인터페이스가 처음 생겨서 아무값도 없으면(null)이면 white텍스쳐가 작동하라는것을 의미한다. 
        //여기서 입력받는 값은 "sampler2D"값이다. 2D텍스쳐를 받았으니 샘플러도 당연히 2D이다.
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        //CGPROGRAM과 ENDCG사이에 값이 존재해야한다. 다른 클래스나 구조체내에서 선언되면 안되고 섭세이더 내부에서 선언되어야한다.
        //텍스쳐는 UV와 만나기 전까지 그냥 메모리상 존재하는 텍스쳐일뿐이다.
        
        struct Input //UV를 받아온다. 그래픽카드 데이터를 가져오는부분
        //UV 는 vertax가 정보를 가지고 있다. 그리고 이 vertex 내부에 있는 정보를 엔진에게 내놓으라고 명령할때 이 Input 구조체를 사용한다
        //UV 는 U와 V라는 2개의 숫자 정보이고, 이는 당연히 float2임.
        {
            float2 uv_MainTex;
            //이 uv는 _sampler2D _MainTex의 UV 정보를 엔진에서 가져온걸 알수있다.
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //tex2D라는 텍스쳐를 연산하는 함수를 사요ㅗㅇ해서 텍스쳐의 컬러를 화면에 출력
            //tex2D(sampler2D name, In.uv값);
            //In쓰는것은 클래스에서 Input 구조체 값을 받아오기위해 미리 구조체를 In으로 선언해둠. 따라서 uv_MainTex는 구조체 안의 앖이니  In으로 구조체안에서 가져온단든걸 명시해두는것.
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
