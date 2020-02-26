// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ArenaRing"
{
	Properties
	{
		_MainColour("MainColour", Color) = (0,1,1,1)
		_MainColourBlend("MainColourBlend", Color) = (0,1,1,1)
		_Texture0("Texture 0", 2D) = "white" {}
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_Float0("Float 0", Range( 0 , 25)) = 0
		_Glow("Glow", Range( 0 , 25)) = 0
		_GlowColour("GlowColour", Color) = (1,1,1,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform float4 _MainColour;
		uniform sampler2D _Texture0;
		uniform float2 _Vector0;
		uniform float4 _Texture0_ST;
		uniform float4 _MainColourBlend;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Float0;
		uniform float4 _GlowColour;
		uniform float _Glow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float2 panner25 = ( _Time.y * _Vector0 + uv0_Texture0);
			float4 tex2DNode1 = tex2D( _Texture0, panner25 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth28 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth28 = abs( ( screenDepth28 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Float0 ) );
			float clampResult33 = clamp( distanceDepth28 , 0.0 , 1.0 );
			float MainThing45 = clampResult33;
			float4 lerpResult34 = lerp( ( _MainColour * tex2DNode1 ) , _MainColourBlend , MainThing45);
			float screenDepth50 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth50 = abs( ( screenDepth50 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Glow ) );
			float clampResult49 = clamp( distanceDepth50 , 0.0 , 1.0 );
			float Glow47 = ( 1.0 - clampResult49 );
			float4 lerpResult51 = lerp( lerpResult34 , _GlowColour , Glow47);
			o.Emission = lerpResult51.rgb;
			float4 temp_output_39_0 = ( ( 1.0 - MainThing45 ) * tex2DNode1 );
			o.Alpha = temp_output_39_0.r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.screenPos = IN.screenPos;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2073;116;1390;660;1680.902;510.6129;1.52711;True;False
Node;AmplifyShaderEditor.RangedFloatNode;31;-1595.841,728.2514;Inherit;False;Property;_Float0;Float 0;5;0;Create;True;0;0;False;0;0;8;0;25;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1605.896,873.5071;Inherit;False;Property;_Glow;Glow;6;0;Create;True;0;0;False;0;0;2.1;0;25;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;19;-1894.29,-117.2349;Inherit;True;Property;_Texture0;Texture 0;3;0;Create;True;0;0;False;0;None;bd46706ff72992a4c8a07db09bba3dce;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DepthFade;28;-1305.531,699.9538;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;50;-1315.586,845.2095;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;26;-1577.735,227.0093;Inherit;False;Property;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;0,0;0.05,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1637.104,-39.30107;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;27;-1599.835,353.5096;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;25;-1239.734,-12.19063;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;33;-1067.281,697.6189;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;49;-1077.336,842.8746;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;54;-936.745,867.4567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;-964.0734,-292.0695;Inherit;False;Property;_MainColour;MainColour;0;0;Create;True;0;0;False;0;0,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-871.07,724.4746;Inherit;False;MainThing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1047.193,-102.9032;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;5798ded558355430c8a9b13ee12a847c;9fbef4b79ca3b784ba023cb1331520d5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-536.7233,48.29974;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;47;-753.4159,847.3123;Inherit;False;Glow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-572.9836,334.6693;Inherit;False;45;MainThing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;30;-605.0472,157.1167;Inherit;False;Property;_MainColourBlend;MainColourBlend;2;0;Create;True;0;0;False;0;0,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;52;-233.9509,372.3395;Inherit;False;Property;_GlowColour;GlowColour;7;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;53;-197.919,562.3285;Inherit;False;47;Glow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;42;-716.7346,467.7127;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;34;-280.9019,226.5548;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;37;-294.8451,650.6859;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;51;91.97859,306.8262;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-126.9884,701.3701;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;66;-1318.207,-544.7264;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;67;-1035.977,-492.4251;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;69;327.5735,384.9242;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;750.4515,192.9459;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;ArenaRing;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;31;0
WireConnection;50;0;48;0
WireConnection;16;2;19;0
WireConnection;25;0;16;0
WireConnection;25;2;26;0
WireConnection;25;1;27;0
WireConnection;33;0;28;0
WireConnection;49;0;50;0
WireConnection;54;0;49;0
WireConnection;45;0;33;0
WireConnection;1;0;19;0
WireConnection;1;1;25;0
WireConnection;18;0;17;0
WireConnection;18;1;1;0
WireConnection;47;0;54;0
WireConnection;42;0;1;0
WireConnection;34;0;18;0
WireConnection;34;1;30;0
WireConnection;34;2;46;0
WireConnection;37;0;46;0
WireConnection;51;0;34;0
WireConnection;51;1;52;0
WireConnection;51;2;53;0
WireConnection;39;0;37;0
WireConnection;39;1;42;0
WireConnection;67;1;66;0
WireConnection;69;1;39;0
WireConnection;0;2;51;0
WireConnection;0;9;39;0
ASEEND*/
//CHKSM=6FAC8AC4596592488CE5A1BB634C4EDDC6486451