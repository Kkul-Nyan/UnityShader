Shader "ShaderStudy/Test/Chapter3/ShaderFire2"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "black" {}
        _brightness("brigtness",range(0,1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Opaque"="Transparent" }


        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        sampler2D _MainTex;
        sampler2D _MainTex2;
        float _brightness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2-_Time.y );
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex + d.r - _brightness);
            o.Emission = c.rgb;
            o.Alpha = c.a  ;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
