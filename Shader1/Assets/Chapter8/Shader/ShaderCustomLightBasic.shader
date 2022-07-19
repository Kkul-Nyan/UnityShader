Shader "ShaderStudy/Test/Chapter8/ShaderCustomLightBasic"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test noambient

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        
        float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten)
        // Lighting + 함수이름 구서이야지 커스텀라이트 함수로 받아들여진다. 
        // SurfaceOutput,lightDir,atten 외에는 Properties로 입력받은 값만을 입력값으로 가져올수있다. 이외에는 사용할수없다.
        // SurfaceOutput = Normal,Emission,Specular,Gloss,Alpha값을 가져온다. 다른말로는 o.Albedo안에 넣어둔 값 s.ALbedo로 꺼내와서 쓸수있다.
        // lightDir은 Normalized되고, 뒤집혀진 백터 값이다.
        // atten은 attenuation의 준말 거리가 멀어짌후록 흐려지는 부분
        // void가 아닌 float4를 반환한다고 정의했으니 float4값을 반환해준다.
        { 
            return float4(1,1,0,1);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
