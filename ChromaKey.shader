Shader "Custom/ChromaKeyURP"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _KeyColor("Key Color", Color) = (0, 0, 1, 1) // Blue color
        _Threshold("Threshold", Range(0, 1)) = 0.1
    }
    SubShader
    {
        Tags { "RenderPipeline" = "UniversalRenderPipeline" }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            // Declare texture and sampler
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            float4 _KeyColor;
            float _Threshold;

            struct Attributes
            {
                float4 positionOS : POSITION; // Object-space position
                float2 uv : TEXCOORD0;       // UV coordinates
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION; // Homogeneous clip-space position
                float2 uv : TEXCOORD0;           // Pass UV coordinates
            };

            // Vertex shader
            Varyings vert(Attributes v)
            {
                Varyings o;
                // Transform object-space position to homogeneous clip-space
                o.positionHCS = TransformObjectToHClip(v.positionOS.xyz);
                o.uv = v.uv;
                return o;
            }

            // Fragment shader
            half4 frag(Varyings i) : SV_Target
            {
                // Sample the texture using the texture object and sampler state
                float4 texColor = _MainTex.Sample(sampler_MainTex, i.uv);

                // Compute the distance between the texture color and the key color
                float diff = distance(texColor.rgb, _KeyColor.rgb);

                // Make pixels transparent if they match the key color within the threshold
                if (diff < _Threshold)
                {
                    discard; // Remove the pixel
                }

                return texColor;
            }
            ENDHLSL
        }
    }
}
