// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DM/ProceduralSkybox"
{
	Properties
	{
		_SkyColorTop("Sky Color Top", Color) = (0.3764706,0.6039216,1,0)
		_SkyColorBottom("Sky Color Bottom", Color) = (0.3764706,0.6039216,1,0)
		_HorizonColor("Horizon Color", Color) = (0.9137255,0.8509804,0.7215686,0)
		_NightColorTop("Night Color Top", Color) = (0,0,0,0)
		_NightColorBottom("Night Color Bottom", Color) = (0,0,0,0)
		_SkyGradientPower("Sky Gradient Power", Float) = 0
		_SkyGradientScale("Sky Gradient Scale", Float) = 0
		_MoonDiskSize("Moon Disk Size", Range( 0 , 0.5)) = 0
		_SunDiskSize("Sun Disk Size", Range( 0 , 0.5)) = 0
		_MoonDiskSizeAdjust("Moon Disk Size Adjust", Range( 0 , 0.01)) = 0
		_SunDiskSizeAdjust("Sun Disk Size Adjust", Range( 0 , 0.01)) = 0
		_MoonDiskSharpness("Moon Disk Sharpness", Range( 0 , 0.01)) = 0
		_SunDiskSharpness("Sun Disk Sharpness", Range( 0 , 0.01)) = 0
		_HorizonGlowIntensity("Horizon Glow Intensity", Float) = 0.59
		_HorizonSharpness("Horizon Sharpness", Float) = 5.7
		_HorizonSunGlowSpreadMin("Horizon Sun Glow Spread Min", Range( 0 , 10)) = 5.075109
		[NoScaleOffset]_StarsCubemap("Stars Cubemap", CUBE) = "white" {}
		_HorizonSunGlowSpreadMax("Horizon Sun Glow Spread Max", Range( 0 , 10)) = 0
		_HorizonTintSunPower("Horizon Tint Sun Power", Float) = 0
		_NightTransitionScale("Night Transition Scale", Float) = 1
		_NightTransitionHorizonDelay("Night Transition Horizon Delay", Float) = 0
		_HorizonMinAmountAlways("Horizon Min Amount Always", Range( 0 , 1)) = 0
		_StarRotation("Star Rotation", Vector) = (0,0,0,0)
		_StarRotationSpeed("Star Rotation Speed", Vector) = (0,0,0,0)
		_StarLayer1Intensity("Star Layer 1 Intensity", Range( 0 , 1)) = 0
		_StarLayer2Intensity("Star Layer 2 Intensity", Range( 0 , 1)) = 0
		_StarLayer3Intensity("Star Layer 3 Intensity", Range( 0 , 1)) = 0
		_StarSize("Star Size", Vector) = (0,0,0,0)
		_CloudCoverage("Cloud Coverage", Range( 0 , 1)) = 0
		_CloudColor("Cloud Color", Color) = (0,0,0,0)
		_CloudTimescale("Cloud Timescale", Float) = 0
		_CloudHorizonMaskSharpness("Cloud Horizon Mask Sharpness", Float) = 0
		_CloudHorizonMaskHeightOffset("Cloud Horizon Mask Height Offset", Float) = 0
		_CloudNoise("Cloud Noise", 2D) = "white" {}
		_CloudHeight("Cloud Height", Float) = 0
		_CloudTiling("Cloud Tiling", Vector) = (0,0,0,0)
		_CloudOffset("Cloud Offset", Vector) = (0,0,0,0)
		_CloudScroll("Cloud Scroll", Vector) = (0,0,0,0)
		_CloudOffset2("Cloud Offset 2", Vector) = (0,0,0,0)
		_CloudScroll2("Cloud Scroll 2", Vector) = (2,0,0,0)
		_CloudHeight3("Cloud Height 3", Float) = 0
		_CloudScroll3("Cloud Scroll 3", Vector) = (0,0,0,0)
		_SunDiskIntensity("Sun Disk Intensity", Float) = 0
		_MoonDiskIntensity("Moon Disk Intensity", Float) = 0
		_SunDiskCloudsTransmissionIntensity("Sun Disk Clouds Transmission Intensity", Float) = 0
		_MoonDiskCloudsTransmissionIntensity("Moon Disk Clouds Transmission Intensity", Float) = 0
		_CloudSharpness("Cloud Sharpness", Vector) = (0,0,0,0)
		_CoverageGradientHeight("Coverage Gradient Height", Float) = 0
		_CoverageGradientOffset("Coverage Gradient Offset", Vector) = (0,0,0,0)
		_CoverageGradientSharpness("Coverage GradientSharpness", Float) = 0
		[Toggle]_UseRadialCoverageMask("Use Radial Coverage Mask", Float) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
			};

			//This is a late directive
			
			uniform float4 _SkyColorTop;
			uniform float4 _SkyColorBottom;
			uniform float _SkyGradientPower;
			uniform float _SkyGradientScale;
			uniform float4 _NightColorTop;
			uniform float4 _NightColorBottom;
			uniform samplerCUBE _StarsCubemap;
			uniform float2 _StarRotation;
			uniform float2 _StarRotationSpeed;
			uniform float _StarLayer1Intensity;
			uniform float3 _StarSize;
			uniform float _StarLayer2Intensity;
			uniform float _StarLayer3Intensity;
			uniform float _NightTransitionScale;
			uniform float4 _CloudColor;
			uniform float2 _CloudSharpness;
			uniform sampler2D _CloudNoise;
			uniform float _CloudHeight;
			uniform float2 _CloudTiling;
			uniform float2 _CloudOffset;
			uniform float2 _CloudScroll;
			uniform float _CloudTimescale;
			uniform float2 _CloudScroll2;
			uniform float2 _CloudOffset2;
			uniform float _CloudHeight3;
			uniform float2 _CloudScroll3;
			uniform float _UseRadialCoverageMask;
			uniform float _CloudCoverage;
			uniform float _CoverageGradientHeight;
			uniform float2 _CoverageGradientOffset;
			uniform float _CoverageGradientSharpness;
			uniform float _CloudHorizonMaskHeightOffset;
			uniform float _CloudHorizonMaskSharpness;
			uniform float4 _HorizonColor;
			uniform float _NightTransitionHorizonDelay;
			uniform float _HorizonMinAmountAlways;
			uniform float _HorizonSharpness;
			uniform float _HorizonSunGlowSpreadMin;
			uniform float _HorizonSunGlowSpreadMax;
			uniform float _HorizonGlowIntensity;
			uniform float _HorizonTintSunPower;
			uniform float _SunDiskCloudsTransmissionIntensity;
			uniform float _SunDiskSize;
			uniform float _SunDiskSizeAdjust;
			uniform float _SunDiskSharpness;
			uniform float _SunDiskIntensity;
			uniform float _MoonDiskCloudsTransmissionIntensity;
			uniform float _MoonDiskSize;
			uniform float _MoonDiskSizeAdjust;
			uniform float _MoonDiskSharpness;
			uniform float _MoonDiskIntensity;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.ase_texcoord.xyz = ase_worldPos;
				float2 break512 = ( _StarRotation + ( _Time.y * _StarRotationSpeed ) );
				float2 appendResult32_g17 = (float2(break512.x , break512.y));
				float2 break8_g17 = radians( appendResult32_g17 );
				float temp_output_13_0_g17 = cos( break8_g17.x );
				float temp_output_9_0_g17 = sin( break8_g17.x );
				float3 appendResult16_g17 = (float3(temp_output_13_0_g17 , 0.0 , -temp_output_9_0_g17));
				float3 appendResult18_g17 = (float3(0.0 , 1.0 , 0.0));
				float3 appendResult19_g17 = (float3(temp_output_9_0_g17 , 0.0 , temp_output_13_0_g17));
				float3 appendResult15_g17 = (float3(1.0 , 0.0 , 0.0));
				float temp_output_12_0_g17 = cos( break8_g17.y );
				float temp_output_10_0_g17 = sin( break8_g17.y );
				float3 appendResult20_g17 = (float3(0.0 , temp_output_12_0_g17 , -temp_output_10_0_g17));
				float3 appendResult17_g17 = (float3(0.0 , temp_output_10_0_g17 , temp_output_12_0_g17));
				float3 normalizeResult25_g17 = normalize( ase_worldPos );
				float3 vertexToFrag27_g17 = mul( mul( float3x3(appendResult16_g17, appendResult18_g17, appendResult19_g17), float3x3(appendResult15_g17, appendResult20_g17, appendResult17_g17) ), normalizeResult25_g17 );
				o.ase_texcoord1.xyz = vertexToFrag27_g17;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				o.ase_texcoord1.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float3 ase_worldPos = i.ase_texcoord.xyz;
				float3 normalizeResult566 = normalize( ase_worldPos );
				float dotResult563 = dot( normalizeResult566 , float3( 0,1,0 ) );
				float SkyColorGradient573 = saturate( ( pow( ( 1.0 - abs( dotResult563 ) ) , _SkyGradientPower ) * _SkyGradientScale ) );
				float4 lerpResult575 = lerp( _SkyColorTop , _SkyColorBottom , SkyColorGradient573);
				float4 lerpResult578 = lerp( _NightColorTop , _NightColorBottom , SkyColorGradient573);
				float3 vertexToFrag27_g17 = i.ase_texcoord1.xyz;
				float4 texCUBENode422 = texCUBE( _StarsCubemap, vertexToFrag27_g17 );
				float temp_output_429_0 = saturate( ( pow( ( texCUBENode422.r * _StarLayer1Intensity ) , _StarSize.x ) + pow( ( texCUBENode422.g * _StarLayer2Intensity ) , _StarSize.y ) + pow( ( texCUBENode422.b * _StarLayer3Intensity ) , _StarSize.z ) ) );
				float StarsMask557 = temp_output_429_0;
				float4 lerpResult561 = lerp( lerpResult578 , float4( 1,1,1,0 ) , StarsMask557);
				float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				float dotResult81 = dot( -worldSpaceLightDir , float3( 0,1,0 ) );
				float NightTransScale235 = _NightTransitionScale;
				float4 lerpResult78 = lerp( lerpResult575 , lerpResult561 , saturate( ( dotResult81 * NightTransScale235 ) ));
				float4 SkyColor197 = lerpResult78;
				float2 appendResult719 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 temp_output_840_0 = ( ( appendResult719 / ( ase_worldPos.y * _CloudHeight ) ) / _CloudTiling );
				float mulTime829 = _Time.y * _CloudTimescale;
				float2 appendResult763 = (float2(ase_worldPos.x , ase_worldPos.z));
				float mulTime835 = _Time.y * _CloudTimescale;
				float2 appendResult901 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 temp_output_902_0 = ( appendResult901 / ( ase_worldPos.y * _CoverageGradientHeight ) );
				float clampResult9_g16 = clamp( ( ( length( (float2( -1,-1 ) + (( temp_output_902_0 + _CoverageGradientOffset ) - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + -(360.0 + (_CloudCoverage - 0.0) * (-100.0 - 360.0) / (1.0 - 0.0)) ) * _CoverageGradientSharpness ) , 0.0 , 1.0 );
				float CoverageGradient915 = (( _UseRadialCoverageMask )?( saturate( clampResult9_g16 ) ):( _CloudCoverage ));
				float CloudCoverage896 = (-1.0 + (CoverageGradient915 - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
				float smoothstepResult1039 = smoothstep( _CloudSharpness.x , _CloudSharpness.y , ( ( ( tex2D( _CloudNoise, ( temp_output_840_0 + ( _CloudOffset + ( _CloudScroll * mulTime829 ) ) ) ).r + tex2D( _CloudNoise, ( temp_output_840_0 + ( mulTime829 * _CloudScroll2 ) + _CloudOffset2 ) ).r + tex2D( _CloudNoise, ( ( appendResult763 / ( ase_worldPos.y * _CloudHeight3 ) ) + ( _CloudScroll3 * mulTime835 ) ) ).r ) / 3.0 ) + CloudCoverage896 ));
				float3 normalizeResult722 = normalize( ase_worldPos );
				float CloudHorizonMask794 = saturate( ( ( normalizeResult722.y - _CloudHorizonMaskHeightOffset ) * _CloudHorizonMaskSharpness ) );
				float CloudLayer694 = saturate( ( smoothstepResult1039 * CloudHorizonMask794 ) );
				float4 lerpResult697 = lerp( SkyColor197 , _CloudColor , saturate( ( _CloudColor.a * CloudLayer694 ) ));
				float4 HorizonColor313 = _HorizonColor;
				float dotResult238 = dot( -worldSpaceLightDir , float3( 0,1,0 ) );
				float HorizonScaleDayNight304 = saturate( ( dotResult238 * ( NightTransScale235 + _NightTransitionHorizonDelay ) ) );
				float dotResult213 = dot( worldSpaceLightDir , float3( 0,1,0 ) );
				float HorizonGlowGlobalScale307 = (_HorizonMinAmountAlways + (saturate( pow( ( 1.0 - abs( dotResult213 ) ) , 4.14 ) ) - 0.0) * (1.0 - _HorizonMinAmountAlways) / (1.0 - 0.0));
				float3 normalizeResult42 = normalize( ase_worldPos );
				float dotResult40 = dot( normalizeResult42 , float3( 0,1,0 ) );
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(ase_worldPos);
				ase_worldViewDir = normalize(ase_worldViewDir);
				float dotResult12 = dot( -worldSpaceLightDir , ase_worldViewDir );
				float InvVDotL200 = dotResult12;
				float temp_output_22_0 = min( _HorizonSunGlowSpreadMin , _HorizonSunGlowSpreadMax );
				float temp_output_23_0 = max( _HorizonSunGlowSpreadMin , _HorizonSunGlowSpreadMax );
				float clampResult14 = clamp( (0.0 + (InvVDotL200 - ( 1.0 - ( temp_output_22_0 * temp_output_22_0 ) )) * (1.0 - 0.0) / (( 1.0 - ( temp_output_23_0 * temp_output_23_0 ) ) - ( 1.0 - ( temp_output_22_0 * temp_output_22_0 ) ))) , 0.0 , 1.0 );
				float dotResult88 = dot( worldSpaceLightDir , float3( 0,-1,0 ) );
				float clampResult89 = clamp( dotResult88 , 0.0 , 1.0 );
				float TotalHorizonMask314 = saturate( ( ( ( 1.0 - HorizonScaleDayNight304 ) * HorizonGlowGlobalScale307 ) * saturate( pow( ( 1.0 - abs( dotResult40 ) ) , _HorizonSharpness ) ) * saturate( ( pow( ( 1.0 - clampResult14 ) , 5.0 ) * _HorizonGlowIntensity * ( 1.0 - clampResult89 ) ) ) ) );
				float4 lerpResult55 = lerp( lerpResult697 , HorizonColor313 , TotalHorizonMask314);
				float temp_output_2_0_g18 = TotalHorizonMask314;
				float temp_output_3_0_g18 = ( 1.0 - temp_output_2_0_g18 );
				float3 appendResult7_g18 = (float3(temp_output_3_0_g18 , temp_output_3_0_g18 , temp_output_3_0_g18));
				float3 temp_cast_1 = (_HorizonTintSunPower).xxx;
				float SunDiskSize286 = ( 1.0 - ( _SunDiskSize + _SunDiskSizeAdjust ) );
				float temp_output_262_0 = ( SunDiskSize286 * ( 1.0 - ( 0.99 + _SunDiskSharpness ) ) );
				float temp_output_75_0 = saturate( InvVDotL200 );
				float dotResult265 = dot( temp_output_75_0 , temp_output_75_0 );
				float smoothstepResult261 = smoothstep( ( SunDiskSize286 - temp_output_262_0 ) , ( SunDiskSize286 + temp_output_262_0 ) , dotResult265);
				float dotResult302 = dot( ase_worldPos.y , 1.0 );
				float temp_output_69_0 = saturate( ( smoothstepResult261 * saturate( dotResult302 ) ) );
				#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
				float4 ase_lightColor = 0;
				#else //aselc
				float4 ase_lightColor = _LightColor0;
				#endif //aselc
				float3 temp_output_71_0 = ( temp_output_69_0 * ase_lightColor.a * ase_lightColor.rgb );
				float3 lerpResult950 = lerp( ( _SunDiskCloudsTransmissionIntensity * temp_output_71_0 ) , ( temp_output_71_0 * _SunDiskIntensity ) , ( 1.0 - CloudLayer694 ));
				float3 SunDisk203 = ( lerpResult950 * temp_output_69_0 );
				float MoonDiskSize1078 = ( 1.0 - ( _MoonDiskSize + _MoonDiskSizeAdjust ) );
				float temp_output_1104_0 = ( MoonDiskSize1078 * ( 1.0 - ( 0.99 + _MoonDiskSharpness ) ) );
				float dotResult1072 = dot( worldSpaceLightDir , ase_worldViewDir );
				float InvVDotLMoon1105 = dotResult1072;
				float temp_output_1106_0 = saturate( InvVDotLMoon1105 );
				float dotResult1081 = dot( temp_output_1106_0 , temp_output_1106_0 );
				float smoothstepResult1107 = smoothstep( ( MoonDiskSize1078 - temp_output_1104_0 ) , ( MoonDiskSize1078 + temp_output_1104_0 ) , dotResult1081);
				float dotResult1084 = dot( ase_worldPos.y , 1.0 );
				float temp_output_1089_0 = saturate( ( smoothstepResult1107 * saturate( dotResult1084 ) ) );
				float3 temp_output_1092_0 = ( temp_output_1089_0 * ase_lightColor.a * ase_lightColor.rgb );
				float3 lerpResult1099 = lerp( ( _MoonDiskCloudsTransmissionIntensity * temp_output_1092_0 ) , ( temp_output_1092_0 * _MoonDiskIntensity ) , ( 1.0 - CloudLayer694 ));
				float3 Moon1108 = ( lerpResult1099 * temp_output_1089_0 );
				float3 temp_output_288_0 = ( pow( ( ( HorizonColor313.rgb * temp_output_2_0_g18 ) + appendResult7_g18 ) , temp_cast_1 ) * ( SunDisk203 + Moon1108 ) );
				float4 Sky175 = ( lerpResult55 + float4( temp_output_288_0 , 0.0 ) );
				
				
				finalColor = Sky175;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
2080;59;1049;728;6227.352;2439.667;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;962;-8217.956,619.8361;Inherit;False;1932.034;841.919;Comment;21;904;922;918;921;919;923;920;900;907;905;902;903;901;898;929;906;915;924;1064;1053;745;Gradient Coverage Masks;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;904;-8200.08,886.4998;Float;False;Property;_CoverageGradientHeight;Coverage Gradient Height;52;0;Create;True;0;0;False;0;0;-0.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;898;-8167.956,669.8361;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;901;-7925.542,697.7188;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;903;-7909.407,864.3997;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;13.28;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;906;-7713.96,846.6306;Float;False;Property;_CoverageGradientOffset;Coverage Gradient Offset;53;0;Create;True;0;0;False;0;0,0;9.48,5.07;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;745;-8135.004,1122.672;Float;False;Property;_CloudCoverage;Cloud Coverage;33;0;Create;True;0;0;False;0;0;0.435;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;902;-7718.84,734.1188;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1067;-6207.41,193.1585;Inherit;False;4348.453;1407.389;Comment;41;714;711;846;829;764;828;719;762;718;713;841;833;710;763;834;835;1030;765;766;840;832;836;1032;1033;715;837;1031;754;755;1028;709;986;895;1062;1063;1040;1039;990;1041;1037;694;Clouds;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;1053;-7812.73,975.9084;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;360;False;4;FLOAT;-100;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;929;-7811.062,1178.395;Float;False;Property;_CoverageGradientSharpness;Coverage GradientSharpness;55;0;Create;True;0;0;False;0;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;905;-7509.006,735.6996;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;711;-6146.866,354.9651;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;846;-5636.214,899.9142;Float;False;Property;_CloudTimescale;Cloud Timescale;35;0;Create;True;0;0;False;0;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;900;-7306.607,801.3922;Inherit;False;RadialGradient;-1;;16;dfd553b6313c07d44b9845c03b277cad;0;3;1;FLOAT2;0,0;False;6;FLOAT;1;False;7;FLOAT;1.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;714;-6157.41,554.8444;Float;False;Property;_CloudHeight;Cloud Height;39;0;Create;True;0;0;False;0;0;37.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;828;-4636.426,449.1328;Float;False;Property;_CloudScroll;Cloud Scroll;42;0;Create;True;0;0;False;0;0,0;0.4,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldPosInputsNode;762;-5613.229,1039.051;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;764;-5590.624,1230.537;Float;False;Property;_CloudHeight3;Cloud Height 3;45;0;Create;True;0;0;False;0;0;-4.86;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;718;-5868.086,484.4194;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;829;-4996.018,605.3997;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;924;-6879.552,837.8091;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;719;-5886.876,358.8104;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;737;-6276.086,-437.5097;Inherit;False;1848.505;446.5817;Comment;9;735;734;726;733;728;732;722;720;794;Cloud Horizon Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;841;-5666.073,555.9088;Float;False;Property;_CloudTiling;Cloud Tiling;40;0;Create;True;0;0;False;0;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;765;-5345.946,1201.281;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1064;-6730.66,971.8688;Float;False;Property;_UseRadialCoverageMask;Use Radial Coverage Mask;56;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;713;-5616.327,375.3333;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;763;-5343.287,1057.668;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;1030;-4982.977,814.4601;Float;False;Property;_CloudScroll2;Cloud Scroll 2;44;0;Create;True;0;0;False;0;2,0;0.3,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;835;-5629.856,1490.547;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;206;-8530.652,-3276.606;Inherit;False;4121.021;1625.509;Comment;23;198;57;175;76;55;63;233;234;305;309;311;313;314;316;356;395;695;697;747;768;769;955;957;Horizon And Sun Glow;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;834;-5361.412,1363.614;Float;False;Property;_CloudScroll3;Cloud Scroll 3;46;0;Create;True;0;0;False;0;0,0;0,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldPosInputsNode;720;-6226.086,-363.6111;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;205;-4298.641,-2303.957;Inherit;False;2704.589;737.7334;Comment;39;939;933;71;18;69;298;303;261;264;297;302;263;287;262;300;265;75;286;271;268;282;281;284;252;285;200;12;34;11;10;942;947;951;950;952;953;956;958;959;Sun Disk;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;444;-4986.887,-1488.685;Inherit;False;2531.382;898.249;;28;525;528;526;442;530;527;531;529;428;532;533;429;422;534;512;449;509;448;446;510;535;536;546;547;548;549;551;557;Stars Rotation and Intensity;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;833;-4421.937,532.7123;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;710;-4650.128,333.1281;Float;False;Property;_CloudOffset;Cloud Offset;41;0;Create;True;0;0;False;0;0,0;14.1,8.24;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NormalizeNode;722;-5932.653,-338.6802;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;832;-4278.938,419.6121;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1066;-8217.786,278.918;Inherit;False;806.5024;269.7425;Comment;3;896;910;1051;Coverage;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;766;-5102.601,1134.794;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;840;-5325.5,440.4579;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1032;-4736.656,813.6191;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;915;-6556.921,818.1768;Float;False;CoverageGradient;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1068;-1197.624,-383.8563;Inherit;False;2704.589;737.7334;Comment;38;1107;1106;1105;1104;1103;1102;1101;1100;1099;1098;1097;1096;1095;1094;1093;1092;1091;1090;1089;1088;1087;1086;1085;1084;1083;1082;1081;1080;1079;1078;1077;1076;1075;1074;1073;1072;1071;1069;Moon Disk;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;356;-8504.089,-2440.018;Inherit;False;2341.093;657.4434;Comment;23;62;19;90;15;17;89;16;32;14;88;13;87;201;27;29;28;26;25;24;23;22;20;21;Horizon Glow added from the sun;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;1033;-4925.894,952.7032;Float;False;Property;_CloudOffset2;Cloud Offset 2;43;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;446;-4939.155,-1025.904;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;308;-2833.574,-2787.448;Inherit;False;1802.634;338.6813;Comment;10;213;221;215;220;222;212;216;223;244;307;Scalar that makes the horizon glow brighter when the sun is low, scales it out when the sun is down and directly above;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;10;-4259.321,-1881.554;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;510;-4955.792,-938.8622;Float;False;Property;_StarRotationSpeed;Star Rotation Speed;23;0;Create;True;0;0;False;0;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;836;-5148.943,1429.971;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;199;-975.0939,-2287.015;Inherit;False;2101.376;1153.238;Comment;30;79;197;78;561;84;56;560;85;81;92;91;235;86;562;563;564;565;566;567;568;569;570;571;573;574;575;576;577;578;579;Sky Color Base;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;910;-8167.787,354.9569;Inherit;False;915;CoverageGradient;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;728;-5779.462,-230.0381;Float;False;Property;_CloudHorizonMaskHeightOffset;Cloud Horizon Mask Height Offset;37;0;Create;True;0;0;False;0;0;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;754;-4293.238,994.8459;Float;True;Property;_CloudNoise;Cloud Noise;38;0;Create;True;0;0;False;0;None;bd46706ff72992a4c8a07db09bba3dce;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;509;-4943.953,-1153.525;Float;False;Property;_StarRotation;Star Rotation;22;0;Create;True;0;0;False;0;0,0;99,184.43;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.BreakToComponentsNode;732;-5699.559,-347.5223;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;837;-4744.679,1448.446;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1073;-1154.754,-334.8883;Float;False;Property;_MoonDiskSize;Moon Disk Size;7;0;Create;True;0;0;False;0;0;0.028;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;252;-4255.771,-2254.989;Float;False;Property;_SunDiskSize;Sun Disk Size;8;0;Create;True;0;0;False;0;0;0.028;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;285;-4261.198,-2023.56;Float;False;Property;_SunDiskSizeAdjust;Sun Disk Size Adjust;10;0;Create;True;0;0;False;0;0;0.00107;0;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1074;-1160.181,-103.4593;Float;False;Property;_MoonDiskSizeAdjust;Moon Disk Size Adjust;9;0;Create;True;0;0;False;0;0;0.00107;0;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1031;-4235.855,794.4785;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;715;-4200.674,243.1585;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1069;-1158.303,38.5468;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;1071;-1157.871,182.4227;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;11;-4258.888,-1737.678;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;34;-3996.254,-1750.573;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-8454.089,-2150.497;Float;False;Property;_HorizonSunGlowSpreadMax;Horizon Sun Glow Spread Max;17;0;Create;True;0;0;False;0;0;3.77;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;306;-4288.764,-2808.82;Inherit;False;1333.227;394.979;Scales the horizon glow depending on the direction of the sun.  If it's below the horizon it scales out faster;9;241;237;243;242;238;239;240;236;304;Horizon Daynight mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;212;-2783.574,-2737.448;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;86;-872.9777,-1295.742;Float;False;Property;_NightTransitionScale;Night Transition Scale;19;0;Create;True;0;0;False;0;1;7.84;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-8444.089,-2239.498;Float;False;Property;_HorizonSunGlowSpreadMin;Horizon Sun Glow Spread Min;15;0;Create;True;0;0;False;0;5.075109;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;562;-927.0293,-2210.465;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;448;-4677.955,-1024.604;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;733;-5370.659,-261.4105;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1028;-3726.2,558.4638;Inherit;True;Property;_TextureSample3;Texture Sample 3;32;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;726;-5530.962,-127.7393;Float;False;Property;_CloudHorizonMaskSharpness;Cloud Horizon Mask Sharpness;36;0;Create;True;0;0;False;0;0;11.13;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1103;-884.3877,43.67876;Float;False;Property;_MoonDiskSharpness;Moon Disk Sharpness;11;0;Create;True;0;0;False;0;0;0.01;0;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;284;-3891.45,-2251.222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;709;-3740.962,307.7595;Inherit;True;Property;_TextureSample0;Texture Sample 0;32;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;281;-3985.405,-1876.422;Float;False;Property;_SunDiskSharpness;Sun Disk Sharpness;12;0;Create;True;0;0;False;0;0;0.01;0;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;235;-561.6544,-1289.811;Float;False;NightTransScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1072;-722.7136,170.7437;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1075;-790.4326,-331.1212;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;755;-3748.442,1325.381;Inherit;True;Property;_TextureSample1;Texture Sample 1;32;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;12;-3823.731,-1749.357;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;213;-2501.345,-2721.35;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;566;-698.6517,-2199.093;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;23;-8124.09,-2134.497;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1051;-7878.627,346.6606;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;22;-8139.091,-2250.498;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;236;-4179.957,-2758.82;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;449;-4549.956,-1152.604;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;268;-3717.819,-2254.949;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1105;-568.8057,173.1287;Float;False;InvVDotLMoon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1076;-605.7136,-151.6793;Inherit;False;2;2;0;FLOAT;0.99;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;896;-7661.284,328.9181;Float;False;CloudCoverage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1077;-616.8018,-334.8482;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;986;-3227.74,416.2774;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;282;-3706.731,-2071.78;Inherit;False;2;2;0;FLOAT;0.99;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;563;-527.2941,-2209.55;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-3669.823,-1746.972;Float;False;InvVDotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-7976.095,-2132.497;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-7988.094,-2261.497;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;512;-4414.486,-1148.619;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.AbsOpNode;221;-2350.324,-2723.671;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;734;-5153.559,-342.0101;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;237;-3893.125,-2738.227;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;311;-8507.238,-2833.718;Inherit;False;1484.109;291.775;;8;59;51;47;46;44;40;42;41;Base Horizon Glow;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;243;-4238.763,-2528.84;Float;False;Property;_NightTransitionHorizonDelay;Night Transition Horizon Delay;20;0;Create;True;0;0;False;0;0;-4.77;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;-4180.15,-2614.813;Inherit;False;235;NightTransScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;895;-3757.903,812.6022;Inherit;False;896;CloudCoverage;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1078;-395.8416,-328.8902;Float;False;MoonDiskSize;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1079;-401.9856,-142.1143;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1106;-321.4417,105.2508;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;564;-366.0621,-2209.015;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;75;-3422.459,-1814.85;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1062;-3071.606,409.2706;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;242;-3890.97,-2606.997;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;271;-3503.003,-2062.215;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;735;-4962.459,-387.5098;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;26;-7799.547,-2272.297;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;-7853.091,-2383.479;Inherit;False;200;InvVDotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;534;-4148.789,-1081.969;Inherit;False;RotateCubemap2D;-1;;17;75cba96657f42e942962c7bf20605826;0;2;28;FLOAT;0;False;29;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;215;-2157.975,-2733.936;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;216;-2173.107,-2648.247;Float;False;Constant;_HideHorizonGlowScale;Hide Horizon Glow Scale;12;0;Create;True;0;0;False;0;4.14;4.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;286;-3496.859,-2248.991;Float;False;SunDiskSize;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;238;-3742.438,-2746.011;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;27;-7802.145,-2185.197;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-7777.447,-2027.897;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-7780.047,-2112.397;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;41;-8452.61,-2767.515;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;1081;-107.4865,83.16873;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1104;-158.5856,-326.6212;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1082;-441.0986,-53.6252;Inherit;False;1078;MoonDiskSize;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;1040;-3036.617,603.4046;Float;False;Property;_CloudSharpness;Cloud Sharpness;51;0;Create;True;0;0;False;0;0,0;0.4,0.44;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldPosInputsNode;1080;133.3875,151.6558;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;239;-3584.789,-2734.266;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;526;-3897.919,-837.9351;Float;False;Property;_StarLayer2Intensity;Star Layer 2 Intensity;25;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1063;-2922.711,405.8867;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;300;-2967.63,-1768.445;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;287;-3542.116,-1973.726;Inherit;False;286;SunDiskSize;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;565;-203.6511,-2216.562;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;265;-3208.504,-1836.932;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-3259.603,-2246.722;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;42;-8257.913,-2736.203;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;87;-7533.519,-2044.391;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;422;-3907.76,-1134.019;Inherit;True;Property;_StarsCubemap;Stars Cubemap;16;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;77520064aae579b48aa2e3d446f8c536;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;568;-903.3739,-2062.666;Float;False;Property;_SkyGradientPower;Sky Gradient Power;5;0;Create;True;0;0;False;0;0;2.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;527;-3893.45,-754.1828;Float;False;Property;_StarLayer3Intensity;Star Layer 3 Intensity;26;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;220;-1900.078,-2704.504;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;525;-3903.935,-921.3803;Float;False;Property;_StarLayer1Intensity;Star Layer 1 Intensity;24;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-7545.959,-2319.831;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;794;-4724.464,-381.5276;Float;False;CloudHorizonMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;222;-1732.469,-2693.311;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1086;166.1114,-49.16621;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1085;57.64629,-196.7582;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;990;-3004.957,770.4943;Inherit;False;794;CloudHorizonMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1084;388.7774,171.8187;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1083;58.70147,-326.2872;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;529;-3489.991,-985.796;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;240;-3415.625,-2720.031;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;40;-7981.716,-2737.504;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;528;-3487.017,-1112.824;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;570;-906.5739,-1984.266;Float;False;Property;_SkyGradientScale;Sky Gradient Scale;6;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;14;-7325.624,-2320.166;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;88;-7292.435,-2043.723;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,-1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;567;39.02571,-2233.867;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1039;-2733.75,423.3107;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;302;-2712.24,-1748.282;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;263;-3043.371,-2116.859;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;297;-2934.906,-1969.267;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;-1862.364,-2563.768;Float;False;Property;_HorizonMinAmountAlways;Horizon Min Amount Always;21;0;Create;True;0;0;False;0;0;0.238;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;531;-3538.435,-751.5916;Float;False;Property;_StarSize;Star Size;27;0;Create;True;0;0;False;0;0,0,0;2.3,10,9.2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;530;-3494.855,-867.5706;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;264;-3042.316,-2246.388;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1087;620.6453,161.7377;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1107;228.0455,-248.3243;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;569;245.8354,-2216.961;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;303;-2480.372,-1758.363;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;89;-7160.735,-2048.504;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1041;-2484.007,444.2537;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-7163.071,-2308.566;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;44;-7795.364,-2730.654;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;533;-3190.185,-887.9802;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;261;-2872.972,-2168.425;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;532;-3166.898,-992.7679;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;223;-1518.243,-2695.267;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;428;-3176.359,-1086.607;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;304;-3251.538,-2724.358;Float;False;HorizonScaleDayNight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-7288.022,-2195.466;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-7738.571,-2640.74;Float;False;Property;_HorizonSharpness;Horizon Sharpness;14;0;Create;True;0;0;False;0;5.7;5.38;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1088;444.2244,-199.5062;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;307;-1306.939,-2695.907;Float;False;HorizonGlowGlobalScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;305;-8481.854,-3151.044;Inherit;False;304;HorizonScaleDayNight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;91;-908.2387,-1481.948;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;15;-6957.122,-2345.966;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;442;-3003.255,-1051.688;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;571;403.3264,-2207.725;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;47;-7605.807,-2717.514;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;90;-7005.608,-2055.175;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1037;-2299.393,481.2181;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;298;-2656.793,-2119.607;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-7094.485,-2206.375;Float;False;Property;_HorizonGlowIntensity;Horizon Glow Intensity;13;0;Create;True;0;0;False;0;0.59;1.69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1089;626.3665,-190.0143;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;1090;593.6634,-90.53926;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.PowerNode;51;-7438.125,-2713.062;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;92;-621.4085,-1461.355;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;573;598.1349,-2185.916;Float;False;SkyColorGradient;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;309;-8472.78,-3049.193;Inherit;False;307;HorizonGlowGlobalScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-6736.965,-2315.807;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;234;-8184.324,-3148.781;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;429;-2855.337,-1040.162;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;694;-2101.957,533.8295;Float;False;CloudLayer;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;18;-2507.354,-2010.64;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;69;-2474.651,-2110.115;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;942;-2332.729,-1741.768;Inherit;False;694;CloudLayer;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1091;656.5445,-321.2384;Float;False;Property;_MoonDiskCloudsTransmissionIntensity;Moon Disk Clouds Transmission Intensity;50;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1094;775.2444,-40.38631;Float;False;Property;_MoonDiskIntensity;Moon Disk Intensity;48;0;Create;True;0;0;False;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;958;-2444.473,-2241.339;Float;False;Property;_SunDiskCloudsTransmissionIntensity;Sun Disk Clouds Transmission Intensity;49;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-2307.674,-2104.772;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;939;-2325.773,-1960.487;Float;False;Property;_SunDiskIntensity;Sun Disk Intensity;47;0;Create;True;0;0;False;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;62;-6571.195,-2321.984;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;81;-265.5615,-1408.569;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1093;768.2884,178.3328;Inherit;False;694;CloudLayer;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;579;-686.7681,-1582.57;Inherit;False;573;SkyColorGradient;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;557;-2685.552,-1028.486;Float;False;StarsMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;59;-7193.505,-2738.412;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;233;-7963.283,-3096.833;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;79;-911.0458,-1887.826;Float;False;Property;_NightColorTop;Night Color Top;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;577;-917.1683,-1673.77;Float;False;Property;_NightColorBottom;Night Color Bottom;4;0;Create;True;0;0;False;0;0,0,0,0;0.03302112,0.004004983,0.1698067,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1092;793.3433,-184.6712;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;947;-2135.227,-1735.853;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1096;750.3924,77.27274;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1097;958.8723,-318.2142;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;1098;965.7903,184.2477;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-6317.039,-2583.552;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;574;-17.86925,-1886.846;Float;False;Property;_SkyColorBottom;Sky Color Bottom;1;0;Create;True;0;0;False;0;0.3764706,0.6039216,1,0;0.278297,0.8399825,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;56;-3.628321,-2063.511;Float;False;Property;_SkyColorTop;Sky Color Top;0;0;Create;True;0;0;False;0;0.3764706,0.6039216,1,0;0.120009,0.3730536,0.8207547,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;560;-253.507,-1540.737;Inherit;False;557;StarsMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1095;991.2644,-124.3442;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;576;-20.44614,-1707.933;Inherit;False;573;SkyColorGradient;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;578;-422.7684,-1780.97;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;959;-2142.145,-2238.315;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;953;-2350.625,-1842.828;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;933;-2109.753,-2044.445;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-84.46637,-1355.791;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;952;-1767.385,-1840.335;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;395;-6150.704,-2569.337;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;57;-6194.929,-2758.385;Float;False;Property;_HorizonColor;Horizon Color;2;0;Create;True;0;0;False;0;0.9137255,0.8509804,0.7215686,0;1,0.7776151,0.5990566,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;561;8.796309,-1617.604;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;575;298.7695,-1723.96;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;84;169.556,-1311.744;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1100;1333.632,79.76578;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;950;-1927.105,-2123.433;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1099;1173.912,-203.3324;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1101;1370.818,-144.7594;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;951;-1730.199,-2064.86;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;316;-6116.676,-2284.35;Inherit;False;927.1527;431.4218;Comment;9;204;291;312;315;289;290;288;1110;1111;Tinting the sun with the horizon color for added COOL;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;314;-5921.566,-2569.372;Float;False;TotalHorizonMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;78;703.1164,-1475.541;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;313;-5874.567,-2677.044;Float;False;HorizonColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;768;-6768.711,-3237.574;Float;False;Property;_CloudColor;Cloud Color;34;0;Create;True;0;0;False;0;0,0,0,0;0.740566,0.9247342,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;695;-6282.26,-2850.776;Inherit;False;694;CloudLayer;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;203;-1507.778,-2024.162;Float;False;SunDisk;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;315;-6064.281,-2141.399;Inherit;False;314;TotalHorizonMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;769;-6068.828,-2877.701;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1108;1583.304,-130.4582;Inherit;False;Moon;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;312;-6051.268,-2237.611;Inherit;False;313;HorizonColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;197;898.4506,-1438.622;Float;False;SkyColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;291;-6073.199,-2050.299;Float;False;Property;_HorizonTintSunPower;Horizon Tint Sun Power;18;0;Create;True;0;0;False;0;0;67.74;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;289;-5797.323,-2193.372;Inherit;False;Lerp White To;-1;;18;047d7c189c36a62438973bad9d37b1c2;0;2;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;747;-5851.074,-2866.239;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;-6219.937,-3226.605;Inherit;False;197;SkyColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;204;-6022.634,-1971.189;Inherit;False;203;SunDisk;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1110;-5689.352,-1939.667;Inherit;False;1108;Moon;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;697;-5693.177,-3099.008;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1111;-5497.352,-2007.667;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;290;-5594.751,-2186.438;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;288;-5365.045,-2131.549;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;55;-5473.988,-2676.948;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-5144.016,-3034.872;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;175;-4834.533,-3005.006;Float;False;Sky;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;598;-4272.352,-450.6332;Inherit;False;1897.999;485.0002;Comment;15;583;586;585;593;592;590;589;588;581;582;594;584;595;591;587;Fog;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;590;-2814.352,-80.63311;Half;False;Property;_FogFill;Fog Fill;31;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;582;-3966.35,-400.6332;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;592;-2814.352,-208.6332;Half;False;Constant;_Float41;Float 41;55;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;956;-2654.001,-2244.568;Float;False;SunDiskMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;535;-4142.435,-1219.065;Inherit;False;RotateCubemap2D;-1;;19;75cba96657f42e942962c7bf20605826;0;2;28;FLOAT;0;False;29;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;586;-3454.352,-272.6334;Half;False;Constant;_Float39;Float 39;55;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1065;1281.264,-899.713;Inherit;False;175;Sky;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;551;-2665.521,-1355.591;Float;False;StarSky;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;547;-3402.534,-1337.758;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;589;-3006.352,-400.6332;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;591;-2814.352,-400.6332;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;907;-8146.591,1000.919;Float;False;Property;_CoverageGradientSize;Coverage Gradient Size;54;0;Create;True;0;0;False;0;0;360.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;585;-3454.352,-400.6332;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;594;-4222.352,-208.6332;Half;False;Property;_FogHeight;Fog Height;30;0;Create;True;0;0;False;0;1;0.624;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;587;-3198.353,-80.63311;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;921;-7043.603,1254.23;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1102;447.0164,-324.4674;Float;False;MoonDiskMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;536;-3887.185,-1415.429;Inherit;True;Property;_StarSkyCubemap;Star Sky Cubemap;28;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;918;-7587.637,1283.023;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;919;-7890.718,1305.755;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;584;-3454.352,-176.6331;Half;False;Constant;_Float40;Float 40;55;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;923;-7448.216,1307.27;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;546;-2867.238,-1353.699;Inherit;False;Lerp White To;-1;;21;047d7c189c36a62438973bad9d37b1c2;0;2;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;957;-5342.207,-2517.457;Inherit;False;956;SunDiskMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;548;-3895.038,-1211.974;Float;False;Property;_GalaxyItensity;Galaxy Itensity;29;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;581;-4222.352,-400.6332;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;593;-2558.353,-400.6332;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;549;-2846.251,-1180.085;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;920;-7270.915,1236.046;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;583;-3774.352,-400.6332;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;955;-5000.527,-2876.295;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FractNode;922;-7158.773,1125.42;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;588;-3262.353,-400.6332;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;595;-4222.352,-80.63311;Half;False;Property;_FogSmoothness;Fog Smoothness;32;0;Create;True;0;0;False;0;0.01;0.122;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;39;1472.178,-909.7745;Float;False;True;-1;2;ASEMaterialInspector;0;1;DM/ProceduralSkybox;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;901;0;898;1
WireConnection;901;1;898;3
WireConnection;903;0;898;2
WireConnection;903;1;904;0
WireConnection;902;0;901;0
WireConnection;902;1;903;0
WireConnection;1053;0;745;0
WireConnection;905;0;902;0
WireConnection;905;1;906;0
WireConnection;900;1;905;0
WireConnection;900;6;1053;0
WireConnection;900;7;929;0
WireConnection;718;0;711;2
WireConnection;718;1;714;0
WireConnection;829;0;846;0
WireConnection;924;0;900;0
WireConnection;719;0;711;1
WireConnection;719;1;711;3
WireConnection;765;0;762;2
WireConnection;765;1;764;0
WireConnection;1064;0;745;0
WireConnection;1064;1;924;0
WireConnection;713;0;719;0
WireConnection;713;1;718;0
WireConnection;763;0;762;1
WireConnection;763;1;762;3
WireConnection;835;0;846;0
WireConnection;833;0;828;0
WireConnection;833;1;829;0
WireConnection;722;0;720;0
WireConnection;832;0;710;0
WireConnection;832;1;833;0
WireConnection;766;0;763;0
WireConnection;766;1;765;0
WireConnection;840;0;713;0
WireConnection;840;1;841;0
WireConnection;1032;0;829;0
WireConnection;1032;1;1030;0
WireConnection;915;0;1064;0
WireConnection;836;0;834;0
WireConnection;836;1;835;0
WireConnection;732;0;722;0
WireConnection;837;0;766;0
WireConnection;837;1;836;0
WireConnection;1031;0;840;0
WireConnection;1031;1;1032;0
WireConnection;1031;2;1033;0
WireConnection;715;0;840;0
WireConnection;715;1;832;0
WireConnection;34;0;10;0
WireConnection;448;0;446;0
WireConnection;448;1;510;0
WireConnection;733;0;732;1
WireConnection;733;1;728;0
WireConnection;1028;0;754;0
WireConnection;1028;1;1031;0
WireConnection;284;0;252;0
WireConnection;284;1;285;0
WireConnection;709;0;754;0
WireConnection;709;1;715;0
WireConnection;235;0;86;0
WireConnection;1072;0;1069;0
WireConnection;1072;1;1071;0
WireConnection;1075;0;1073;0
WireConnection;1075;1;1074;0
WireConnection;755;0;754;0
WireConnection;755;1;837;0
WireConnection;12;0;34;0
WireConnection;12;1;11;0
WireConnection;213;0;212;0
WireConnection;566;0;562;0
WireConnection;23;0;20;0
WireConnection;23;1;21;0
WireConnection;1051;0;910;0
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;449;0;509;0
WireConnection;449;1;448;0
WireConnection;268;0;284;0
WireConnection;1105;0;1072;0
WireConnection;1076;1;1103;0
WireConnection;896;0;1051;0
WireConnection;1077;0;1075;0
WireConnection;986;0;709;1
WireConnection;986;1;1028;1
WireConnection;986;2;755;1
WireConnection;282;1;281;0
WireConnection;563;0;566;0
WireConnection;200;0;12;0
WireConnection;25;0;23;0
WireConnection;25;1;23;0
WireConnection;24;0;22;0
WireConnection;24;1;22;0
WireConnection;512;0;449;0
WireConnection;221;0;213;0
WireConnection;734;0;733;0
WireConnection;734;1;726;0
WireConnection;237;0;236;0
WireConnection;1078;0;1077;0
WireConnection;1079;0;1076;0
WireConnection;1106;0;1105;0
WireConnection;564;0;563;0
WireConnection;75;0;200;0
WireConnection;1062;0;986;0
WireConnection;242;0;241;0
WireConnection;242;1;243;0
WireConnection;271;0;282;0
WireConnection;735;0;734;0
WireConnection;26;0;24;0
WireConnection;534;28;512;0
WireConnection;534;29;512;1
WireConnection;215;0;221;0
WireConnection;286;0;268;0
WireConnection;238;0;237;0
WireConnection;27;0;25;0
WireConnection;1081;0;1106;0
WireConnection;1081;1;1106;0
WireConnection;1104;0;1078;0
WireConnection;1104;1;1079;0
WireConnection;239;0;238;0
WireConnection;239;1;242;0
WireConnection;1063;0;1062;0
WireConnection;1063;1;895;0
WireConnection;565;0;564;0
WireConnection;265;0;75;0
WireConnection;265;1;75;0
WireConnection;262;0;286;0
WireConnection;262;1;271;0
WireConnection;42;0;41;0
WireConnection;422;1;534;0
WireConnection;220;0;215;0
WireConnection;220;1;216;0
WireConnection;13;0;201;0
WireConnection;13;1;26;0
WireConnection;13;2;27;0
WireConnection;13;3;28;0
WireConnection;13;4;29;0
WireConnection;794;0;735;0
WireConnection;222;0;220;0
WireConnection;1086;0;1081;0
WireConnection;1085;0;1082;0
WireConnection;1085;1;1104;0
WireConnection;1084;0;1080;2
WireConnection;1083;0;1082;0
WireConnection;1083;1;1104;0
WireConnection;529;0;422;2
WireConnection;529;1;526;0
WireConnection;240;0;239;0
WireConnection;40;0;42;0
WireConnection;528;0;422;1
WireConnection;528;1;525;0
WireConnection;14;0;13;0
WireConnection;88;0;87;0
WireConnection;567;0;565;0
WireConnection;567;1;568;0
WireConnection;1039;0;1063;0
WireConnection;1039;1;1040;1
WireConnection;1039;2;1040;2
WireConnection;302;0;300;2
WireConnection;263;0;287;0
WireConnection;263;1;262;0
WireConnection;297;0;265;0
WireConnection;530;0;422;3
WireConnection;530;1;527;0
WireConnection;264;0;287;0
WireConnection;264;1;262;0
WireConnection;1087;0;1084;0
WireConnection;1107;0;1086;0
WireConnection;1107;1;1083;0
WireConnection;1107;2;1085;0
WireConnection;569;0;567;0
WireConnection;569;1;570;0
WireConnection;303;0;302;0
WireConnection;89;0;88;0
WireConnection;1041;0;1039;0
WireConnection;1041;1;990;0
WireConnection;32;0;14;0
WireConnection;44;0;40;0
WireConnection;533;0;530;0
WireConnection;533;1;531;3
WireConnection;261;0;297;0
WireConnection;261;1;264;0
WireConnection;261;2;263;0
WireConnection;532;0;529;0
WireConnection;532;1;531;2
WireConnection;223;0;222;0
WireConnection;223;3;244;0
WireConnection;428;0;528;0
WireConnection;428;1;531;1
WireConnection;304;0;240;0
WireConnection;1088;0;1107;0
WireConnection;1088;1;1087;0
WireConnection;307;0;223;0
WireConnection;15;0;32;0
WireConnection;15;1;16;0
WireConnection;442;0;428;0
WireConnection;442;1;532;0
WireConnection;442;2;533;0
WireConnection;571;0;569;0
WireConnection;47;0;44;0
WireConnection;90;0;89;0
WireConnection;1037;0;1041;0
WireConnection;298;0;261;0
WireConnection;298;1;303;0
WireConnection;1089;0;1088;0
WireConnection;51;0;47;0
WireConnection;51;1;46;0
WireConnection;92;0;91;0
WireConnection;573;0;571;0
WireConnection;19;0;15;0
WireConnection;19;1;17;0
WireConnection;19;2;90;0
WireConnection;234;0;305;0
WireConnection;429;0;442;0
WireConnection;694;0;1037;0
WireConnection;69;0;298;0
WireConnection;71;0;69;0
WireConnection;71;1;18;2
WireConnection;71;2;18;1
WireConnection;62;0;19;0
WireConnection;81;0;92;0
WireConnection;557;0;429;0
WireConnection;59;0;51;0
WireConnection;233;0;234;0
WireConnection;233;1;309;0
WireConnection;1092;0;1089;0
WireConnection;1092;1;1090;2
WireConnection;1092;2;1090;1
WireConnection;947;0;942;0
WireConnection;1096;0;1089;0
WireConnection;1097;0;1091;0
WireConnection;1097;1;1092;0
WireConnection;1098;0;1093;0
WireConnection;63;0;233;0
WireConnection;63;1;59;0
WireConnection;63;2;62;0
WireConnection;1095;0;1092;0
WireConnection;1095;1;1094;0
WireConnection;578;0;79;0
WireConnection;578;1;577;0
WireConnection;578;2;579;0
WireConnection;959;0;958;0
WireConnection;959;1;71;0
WireConnection;953;0;69;0
WireConnection;933;0;71;0
WireConnection;933;1;939;0
WireConnection;85;0;81;0
WireConnection;85;1;235;0
WireConnection;952;0;953;0
WireConnection;395;0;63;0
WireConnection;561;0;578;0
WireConnection;561;2;560;0
WireConnection;575;0;56;0
WireConnection;575;1;574;0
WireConnection;575;2;576;0
WireConnection;84;0;85;0
WireConnection;1100;0;1096;0
WireConnection;950;0;959;0
WireConnection;950;1;933;0
WireConnection;950;2;947;0
WireConnection;1099;0;1097;0
WireConnection;1099;1;1095;0
WireConnection;1099;2;1098;0
WireConnection;1101;0;1099;0
WireConnection;1101;1;1100;0
WireConnection;951;0;950;0
WireConnection;951;1;952;0
WireConnection;314;0;395;0
WireConnection;78;0;575;0
WireConnection;78;1;561;0
WireConnection;78;2;84;0
WireConnection;313;0;57;0
WireConnection;203;0;951;0
WireConnection;769;0;768;4
WireConnection;769;1;695;0
WireConnection;1108;0;1101;0
WireConnection;197;0;78;0
WireConnection;289;1;312;0
WireConnection;289;2;315;0
WireConnection;747;0;769;0
WireConnection;697;0;198;0
WireConnection;697;1;768;0
WireConnection;697;2;747;0
WireConnection;1111;0;204;0
WireConnection;1111;1;1110;0
WireConnection;290;0;289;0
WireConnection;290;1;291;0
WireConnection;288;0;290;0
WireConnection;288;1;1111;0
WireConnection;55;0;697;0
WireConnection;55;1;313;0
WireConnection;55;2;314;0
WireConnection;76;0;55;0
WireConnection;76;1;288;0
WireConnection;175;0;76;0
WireConnection;582;0;581;0
WireConnection;956;0;69;0
WireConnection;535;28;512;0
WireConnection;535;29;512;1
WireConnection;551;0;546;0
WireConnection;547;0;536;0
WireConnection;547;1;548;0
WireConnection;589;0;588;0
WireConnection;589;1;587;0
WireConnection;591;0;589;0
WireConnection;585;0;583;1
WireConnection;587;0;595;0
WireConnection;1102;0;1089;0
WireConnection;536;1;535;0
WireConnection;918;0;902;0
WireConnection;918;1;919;2
WireConnection;923;0;918;0
WireConnection;546;1;547;0
WireConnection;593;0;591;0
WireConnection;593;1;592;0
WireConnection;593;2;590;0
WireConnection;549;0;429;0
WireConnection;920;0;923;0
WireConnection;920;1;906;0
WireConnection;583;0;582;0
WireConnection;955;0;55;0
WireConnection;955;1;288;0
WireConnection;955;2;957;0
WireConnection;922;0;920;0
WireConnection;588;0;585;0
WireConnection;588;1;586;0
WireConnection;588;2;594;0
WireConnection;588;3;586;0
WireConnection;588;4;584;0
WireConnection;39;0;1065;0
ASEEND*/
//CHKSM=87F4A3481A53FB4C7C65C7302792931777DA88E4