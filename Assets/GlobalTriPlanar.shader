// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/GlobalTriPlanar"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Falloff("Falloff", Float) = 0
		_Scale("Scale", Float) = 0
		_Contrast("Contrast", Range( -10 , 0)) = -1.638255
		_HeightSharpness("Height Sharpness", Range( 0 , 10)) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#define ASE_TEXTURE_PARAMS(textureName) textureName

		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _Texture0;
		uniform float _Scale;
		uniform float _Falloff;
		uniform float _Contrast;
		uniform float _HeightSharpness;


		inline float4 TriplanarSamplingSF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float2 appendResult7 = (float2(_Scale , _Scale));
			float2 uv_TexCoord19 = i.uv_texcoord * ( float2( 10,10 ) * appendResult7 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar1 = TriplanarSamplingSF( _Texture0, ase_worldPos, ase_worldNormal, _Falloff, appendResult7, 1.0, 0 );
			o.Albedo = ( tex2D( _Texture0, uv_TexCoord19 ) + triplanar1 ).rgb;
			float grayscale10_g1 = Luminance(( CalculateContrast((-10.0 + (1.0 - -1.0) * (20.0 - -10.0) / (1.0 - -1.0)),( 1.0 - CalculateContrast(_Contrast,triplanar1) )) * _HeightSharpness ).rgb);
			float clampResult11_g1 = clamp( grayscale10_g1 , 0.0 , 1.0 );
			float3 temp_cast_4 = (( 1.0 - clampResult11_g1 )).xxx;
			o.Emission = temp_cast_4;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
2073;116;1390;660;2175.094;497.2907;2.089702;True;False
Node;AmplifyShaderEditor.RangedFloatNode;6;-973,75;Inherit;False;Property;_Scale;Scale;5;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-820,70;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;20;-687.9339,0.06935596;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-843,166;Inherit;False;Property;_Falloff;Falloff;4;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;2;-981.3,-281.7998;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;False;0;None;e280124c74dc03f42b90c2fefd900752;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WorldPosInputsNode;3;-864.0872,-81.26143;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-551.8091,-188.9762;Inherit;False;2;2;0;FLOAT2;10,10;False;1;FLOAT2;10,10;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-480.4234,178.5168;Inherit;False;Property;_HeightSharpness;Height Sharpness;7;0;Create;True;0;0;False;0;2;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-477.0572,98.61846;Inherit;False;Property;_Contrast;Contrast;6;0;Create;True;0;0;False;0;-1.638255;-1.47;-10;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;1;-587,-93;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;-1;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-423.1092,-211.0759;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-216.5095,-281.1756;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;8;-153.9816,-29.03299;Inherit;False;HeightFromTexture;1;;1;5212fa4bb062b9847bd4845fd9d7b7d6;0;3;15;COLOR;-1.6,0,0,0;False;14;FLOAT;-1.6;False;13;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;11;65.49837,-29.71953;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;197.6907,-120.2757;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;358.6462,-88.68637;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Custom/GlobalTriPlanar;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;6;0
WireConnection;7;1;6;0
WireConnection;20;0;7;0
WireConnection;21;1;20;0
WireConnection;1;0;2;0
WireConnection;1;9;3;0
WireConnection;1;3;7;0
WireConnection;1;4;4;0
WireConnection;19;0;21;0
WireConnection;18;0;2;0
WireConnection;18;1;19;0
WireConnection;8;15;1;0
WireConnection;8;14;9;0
WireConnection;8;13;10;0
WireConnection;11;0;8;0
WireConnection;17;0;18;0
WireConnection;17;1;1;0
WireConnection;0;0;17;0
WireConnection;0;2;11;0
ASEEND*/
//CHKSM=242F51974BF55B2365771FE7190DC0C3BC6E5771