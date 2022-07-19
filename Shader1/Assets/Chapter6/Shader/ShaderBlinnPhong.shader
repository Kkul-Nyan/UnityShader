Shader "ShaderStudy/Test/Chapter6/ShaderBlinnPhong"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
        _SpecColor("Specular Color", color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf BlinnPhong

        sampler2D _MainTex;
        // float4 _SpecColor 가 없는 이유는 BlinnPhong 내부에서 자동으로 받고 있기 떄문이다. 오히려 적어주면 에러가 난다.
        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Specular = 0.5; //0~1사이,Specular의 크기를 의미하낟. 0일수록 커지고, 1일수록 작아진다 
            o.Gloss = 1; //0~1사이,Specular의 강도를 의미한다. 0이면 둔탁, 1이면 매끄러운재질 
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
