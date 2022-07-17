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
        CGPROGRAM //�����κ�,��ó�� snippet ���̴��� �����꼳���̳� �������� �б⸦ ����.
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
//---------------------------------------------------------------------------------//
        sampler2D _MainTex;
//---------------------------------------------------------------------------------//
        struct Input //�������κ��� �޾ƿ;� �� �����͵��� ����. c#�� struct�� �����ѵ�. 
        {
            float2 uv_MainTex;
        };
//---------------------------------------------------------------------------------//
        //�Լ��κ� ������ �������ְ� �޼��带 �ۼ�, �����̳� �̹����� ��µǴ� �κ��� �ε�� �ִ�.
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
            o.Albedo = test.bgr; //rgb�� ������ �ٲٸ� Red,Green.Blue���� ��ġ�� �ٲ��.  rrró����� ������� ������ִ�(r���� 1�̰�, rrr�� 1,1,1�� �ȴ�.)
            //o.Albedo = c.rgb;  
            //���� ������ �����ʴ´� = �׸��ڵ� ����� ����X,  
           
            // Metallic and smoothness come from slider variables
            // (0,0,0) * (0,0,0) �� ��Ģ������ �����ڸ��� ���� ������ �޴´�. �ٸ� �ڸ����� ����X 
            // ��, float3(0,0,0)+1���� ���ڸ����� �����ϸ� (0+1,0+1,0+1)�� ���ȴ�.

            o.Alpha = c.a;
        }
//---------------------------------------------------------------------------------//
        ENDCG
    }
    FallBack "Diffuse"
}
