Shader "ShaderStudy/Test/Chapter1/testShader1"
{
    Properties
    {
        _Name ("TestRange",Range(0,2)) = 1.0
        _Name1 ("TestFloat",Float) = 0.5
        _Name2 ("Test_Int", int) = 1
        _TestColor("TestColor!",Color) = (1,1,1,1)
        _Test2Color("TestColorVector", Vector) =(1,1,1,1)
        _TestTexture("TestTexture", 2D) = "black" {}
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
//---------------------------------------------------------------------------------//
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
//---------------------------------------------------------------------------------//
        CGPROGRAM //설정부분,전처리 snippet 쉐이더의 조명계산설정이나 세부적인 분기를 관리.
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
//---------------------------------------------------------------------------------//
        sampler2D _MainTex;
//---------------------------------------------------------------------------------//
        struct Input //엔진으로부터 받아와야 할 데이터들이 들어간다. c#의 struct와 동일한듯. 
        {
            float2 uv_MainTex;
        };
//---------------------------------------------------------------------------------//
        //함수부분 변수를 선언해주고 메서드를 작성, 색상이나 이미지가 출력되는 부분을 민들수 있다.
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
             

            float4 test =float4(1,0,0,0.5);

            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = test.bgr; //rgb의 순서는 바꾸면 Red,Green.Blue값의 위치가 바뀐다.  rrr처럼적어서 흰색으로 만들수있다(r값이 1이고, rrr은 1,1,1이 된다.)
            //o.Albedo = c.rgb;  
            //빛의 영향을 받지않는다 = 그림자등 명암이 존재X,  
           
            // Metallic and smoothness come from slider variables
            // (0,0,0) * (0,0,0) 등 사칙연산은 같은자리수 끼리 영향을 받는다. 다른 자리에는 영향X 
            // 단, float3(0,0,0)+1같이 한자리수와 연산하면 (0+1,0+1,0+1)로 계산된다.

            o.Alpha = c.a;
        }
//---------------------------------------------------------------------------------//
        ENDCG
    }
    FallBack "Diffuse"
}
