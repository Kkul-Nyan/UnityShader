Shader "ShaderStudy/Test/Chapter1/ShaderUpdate"
{
    Properties
    {
        _TestColor("TestColor",Color) =(1,1,1,1)
        
        _Red("Red",Range(0,255)) =255
        _Green("Green",Range(0,255)) =255
        _Blue("Blue",Range(0,255)) =255
        _BrightDark("BrightDark",Range(-1,1)) =1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows 

        struct Input
        {
            float4 color : Color;
        };

        float4 _TestColor;
        float _Red;
        float _Green;
        float _Blue;
        float _BrightDark;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float Red1 = float (_Red/255);
            float Green1 =float (_Green/255);
            float Blue1 =float (_Blue/255);
   
            o.Albedo = float3(Red1,Green1,Blue1) + _BrightDark ;

            o.Alpha = _TestColor.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
