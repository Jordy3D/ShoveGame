// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Sponge"
{
	Properties
	{
		_TessPhongStrength( "Phong Tess Strength", Range( 0, 1 ) ) = 0
		_VoronoiAngle("Voronoi Angle", Float) = 0
		_VoronoiScale("Voronoi Scale", Float) = 10
		_DotScale("Dot Scale", Range( 0 , 1)) = 0.01
		_NoiseScale("Noise Scale", Range( 0 , 1000)) = 0.01
		_Float0("Float 0", Range( 1 , 100)) = 1
		_DisplacementDirection("Displacement Direction", Range( -1 , 1)) = 1
		_SecondaryNoiseStrength("Secondary Noise Strength", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( -1 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction tessphong:_TessPhongStrength 
		struct Input
		{
			half filler;
		};

		uniform float _VoronoiScale;
		uniform float _VoronoiAngle;
		uniform float _DotScale;
		uniform float _NoiseScale;
		uniform float _SecondaryNoiseStrength;
		uniform float _DisplacementDirection;
		uniform float _Metallic;
		uniform float _Smoothness;
		uniform float _Float0;
		uniform float _TessPhongStrength;


		struct Gradient
		{
			int type;
			int colorsLength;
			int alphasLength;
			float4 colors[8];
			float2 alphas[8];
		};


		Gradient NewGradient(int type, int colorsLength, int alphasLength, 
		float4 colors0, float4 colors1, float4 colors2, float4 colors3, float4 colors4, float4 colors5, float4 colors6, float4 colors7,
		float2 alphas0, float2 alphas1, float2 alphas2, float2 alphas3, float2 alphas4, float2 alphas5, float2 alphas6, float2 alphas7)
		{
			Gradient g;
			g.type = type;
			g.colorsLength = colorsLength;
			g.alphasLength = alphasLength;
			g.colors[ 0 ] = colors0;
			g.colors[ 1 ] = colors1;
			g.colors[ 2 ] = colors2;
			g.colors[ 3 ] = colors3;
			g.colors[ 4 ] = colors4;
			g.colors[ 5 ] = colors5;
			g.colors[ 6 ] = colors6;
			g.colors[ 7 ] = colors7;
			g.alphas[ 0 ] = alphas0;
			g.alphas[ 1 ] = alphas1;
			g.alphas[ 2 ] = alphas2;
			g.alphas[ 3 ] = alphas3;
			g.alphas[ 4 ] = alphas4;
			g.alphas[ 5 ] = alphas5;
			g.alphas[ 6 ] = alphas6;
			g.alphas[ 7 ] = alphas7;
			return g;
		}


		float2 voronoihash2_g2( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi2_g2( float2 v, float time, inout float2 id, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mr = 0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash2_g2( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		float4 SampleGradient( Gradient gradient, float time )
		{
			float3 color = gradient.colors[0].rgb;
			UNITY_UNROLL
			for (int c = 1; c < 8; c++)
			{
			float colorPos = saturate((time - gradient.colors[c-1].w) / (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, (float)gradient.colorsLength-1);
			color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
			}
			#ifndef UNITY_COLORSPACE_GAMMA
			color = half3(GammaToLinearSpaceExact(color.r), GammaToLinearSpaceExact(color.g), GammaToLinearSpaceExact(color.b));
			#endif
			float alpha = gradient.alphas[0].x;
			UNITY_UNROLL
			for (int a = 1; a < 8; a++)
			{
			float alphaPos = saturate((time - gradient.alphas[a-1].y) / (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, (float)gradient.alphasLength-1);
			alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
			}
			return float4(color, alpha);
		}


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_2 = (_Float0).xxxx;
			return temp_cast_2;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			Gradient gradient12 = NewGradient( 0, 2, 2, float4( 1, 1, 1, 0.1411765 ), float4( 0, 0, 0, 1 ), 0, 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
			float time2_g2 = _VoronoiAngle;
			float2 panner1 = ( _Time.y * float2( 0,0 ) + v.texcoord.xy);
			float2 coords2_g2 = panner1 * _VoronoiScale;
			float2 id2_g2 = 0;
			float voroi2_g2 = voronoi2_g2( coords2_g2, time2_g2,id2_g2, 0 );
			float temp_output_3_0_g2 = ( voroi2_g2 / (0.0 + (_DotScale - 0.0) * (4.0 - 0.0) / (1.0 - 0.0)) );
			float simplePerlin2D20 = snoise( panner1*_NoiseScale );
			simplePerlin2D20 = simplePerlin2D20*0.5 + 0.5;
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz += ( ( SampleGradient( gradient12, temp_output_3_0_g2 ) + ( simplePerlin2D20 * _SecondaryNoiseStrength ) ) * float4( ase_vertex3Pos , 0.0 ) * _DisplacementDirection ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color16 = IsGammaSpace() ? float4(1,0.8661199,0.5235849,0) : float4(1,0.7220262,0.236524,0);
			o.Albedo = color16.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
758;199;832;660;2506.021;292.9852;1.196561;True;False
Node;AmplifyShaderEditor.Vector2Node;4;-1852.29,310.2425;Inherit;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1871.303,184.1675;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1823.964,449.301;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1608.708,358.922;Inherit;False;Property;_DotScale;Dot Scale;2;0;Create;True;0;0;False;0;0.01;0.01;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1517.18,552.9259;Inherit;False;Property;_VoronoiScale;Voronoi Scale;1;0;Create;True;0;0;False;0;10;11.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1535.35,679.5062;Inherit;False;Property;_NoiseScale;Noise Scale;3;0;Create;True;0;0;False;0;0.01;927;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1506.18,446.926;Inherit;False;Property;_VoronoiAngle;Voronoi Angle;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;1;-1535.292,226.5501;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;11;-1258.533,222.4975;Inherit;True;VoronoiDots;-1;;2;a03ea3134012fa7408e12a0ca64466fa;0;6;20;FLOAT2;1,0;False;15;COLOR;1,1,1,1;False;16;FLOAT;0.01;False;17;FLOAT;1;False;18;FLOAT;10;False;19;COLOR;1,1,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;20;-1165.385,499.3481;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GradientNode;12;-1177.176,124.1466;Inherit;False;0;2;2;1,1,1,0.1411765;0,0,0,1;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1226.721,788.3372;Inherit;False;Property;_SecondaryNoiseStrength;Secondary Noise Strength;6;0;Create;True;0;0;False;0;0;0.81;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GradientSampleNode;7;-939.0516,141.7846;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-811.4363,522.1647;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-481.9879,415.0056;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-570.1998,579.689;Inherit;False;Property;_DisplacementDirection;Displacement Direction;5;0;Create;True;0;0;False;0;1;-0.07;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-503.2368,193.2522;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;6;-865.4297,-371.7028;Inherit;False;Constant;_Color1;Color 1;10;0;Create;True;0;0;False;0;0.572549,0.3411765,0.7372549,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-572.2203,-346.7117;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;16;46.29421,-304.7269;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;False;0;1,0.8661199,0.5235849,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;10.72092,29.37598;Inherit;False;Property;_Smoothness;Smoothness;8;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;19.24966,-59.32346;Inherit;False;Property;_Metallic;Metallic;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;166.8664,402.6107;Inherit;False;Property;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;50;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-51.73825,230.1823;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;418.9225,-89.21146;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Sponge;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;True;0;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;0;2;0
WireConnection;1;2;4;0
WireConnection;1;1;3;0
WireConnection;11;20;1;0
WireConnection;11;16;10;0
WireConnection;11;17;8;0
WireConnection;11;18;9;0
WireConnection;20;0;1;0
WireConnection;20;1;21;0
WireConnection;7;0;12;0
WireConnection;7;1;11;0
WireConnection;23;0;20;0
WireConnection;23;1;22;0
WireConnection;19;0;7;0
WireConnection;19;1;23;0
WireConnection;5;0;7;0
WireConnection;5;1;6;0
WireConnection;15;0;19;0
WireConnection;15;1;14;0
WireConnection;15;2;18;0
WireConnection;0;0;16;0
WireConnection;0;3;24;0
WireConnection;0;4;25;0
WireConnection;0;11;15;0
WireConnection;0;14;17;0
ASEEND*/
//CHKSM=F2A9F5511DD022BAD425FEAB783842D272C99552