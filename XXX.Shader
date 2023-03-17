Shader "ONEMT/Effect/CommonEffect"
{
	Properties
	{
		//: { "type": "group","label":"主控制"}
		//: { "type": "default","prop":"_SrcBlend", "label":"源颜色(混合)"}
		[Enum(UnityEngine.Rendering.BlendMode)]_SrcBlend("Src Blend", float) = 5
		//: { "type": "default","prop":"_DstBlend", "label":"目标颜色(混合)"}
		[Enum(UnityEngine.Rendering.BlendMode)]_DstBlend("Dst Blend",float) = 10
		//: { "type": "cull","prop":"_CullMode"}
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode",int) = 2
		//: { "type": "ztest","prop":"_ZTest"}
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTest("ZTest",int) = 4
		//: { "type": "color","prop":"_BaseColor", "label":"主颜色"}
		[HDR]_BaseColor("Tint Color", Color) = (1,1,1,1)
		//: { "type": "float","prop":"_Intensity_Opacity_DistortionIntensity_AlphaChannel", "label":"总亮度","vectorComponent1":"x"}
		//: { "type": "float","prop":"_Intensity_Opacity_DistortionIntensity_AlphaChannel", "label":"总透明度","vectorComponent1":"y"}
		//: { "type": "float","prop":"_Intensity_Opacity_DistortionIntensity_AlphaChannel", "label":"总扭曲度","vectorComponent1":"z","min":"0","max":"1"}
		//: { "type": "toggle","prop":"_Intensity_Opacity_DistortionIntensity_AlphaChannel", "label":"是否启用Alpha","vectorComponent1":"w"}
		//: { "type": "info", "label":"是否采用主纹理的A通道做为透明?如不勾选,则会用主纹理的R通道用做透明;仅影响AlphaBlend模式."}
		_Intensity_Opacity_DistortionIntensity_AlphaChannel("Intensity_Opacity_DistortionIntensity", Vector) = (1,1,0,0)

		//: { "type": "group","label":"模版测试"}
		//: { "type": "int","prop":"_Stencil", "label":"StencilID"}
		_Stencil ("StencilID", int) = 0
		//: { "type": "default","prop":"_StencilComp", "label":"StencilComp"}
		[Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("StencilComp", int) = 8
		//: { "type": "default","prop":"_StencilOp", "label":"Pass"}
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilOp ("StencilPassOP", int) = 0
		//: { "type": "default","prop":"_StencilFailOp", "label":"Fail"}
		[Enum(UnityEngine.Rendering.StencilOp)]_StencilFailOp ("StencilFailOP", int) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15

		//: { "type": "group","label":"基础纹理"}
		//: { "type": "texture1","prop":"_MainTex", "label":"基础纹理","st":"true"}
		_MainTex("MainTex", 2D) = "black" {}
		//: { "type": "int","prop":"_Params01", "label":"Mip级别","vectorComponent1":"x","min":"-2","max":"0"}
		//: { "type": "enum","prop":"_UseMapUV1", "label":"使用UV","enums":"UV0|UV1","vectorComponent1":"x"}
		_UseMapUV1("Use Map UV1",Vector) = (0,0,0,0)
		//: { "type": "vector2","prop":"_MainTex_DistortionTex_Speed", "label":"UV速度","vectorComponent1":"x","vectorComponent2":"y"}
		_MainTex_DistortionTex_Speed("MainTex_DistortionTex_Speed", Vector) = (0,0,0,0)
		//: { "type": "info", "label":"如果Repeat无效,请在Inspector中将纹理的WrapMode修改为默认的Repeat."}
		//: { "type": "enum","prop":"_WrapMode_Rotation", "label":"重复模式","enums":"Repeat|Clamp","vectorComponent1":"x"}
		_WrapMode_Rotation("",Vector) = (0,0,0,0) 

		//: { "type": "groupVariant","label":"扭曲","keyword":"_DISTORTION_ON"}
		//: { "type": "texture1","prop":"_DistortionTex", "label":"扭曲纹理","st":"true"}
		//: { "type": "int","prop":"_Params01", "label":"Mip级别","vectorComponent1":"y","min":"-2","max":"0"}
		//: { "type": "enum","prop":"_UseMapUV1", "label":"使用UV","enums":"UV0|UV1","vectorComponent1":"y"}
		//: { "type": "vector2","prop":"_MainTex_DistortionTex_Speed", "label":"UV速度","vectorComponent1":"z","vectorComponent2":"w"}
		_DistortionTex("DistortionTex", 2D) = "white" {}

		//: { "type": "groupVariant","label":"遮罩","keyword":"_MASKTEXUV_ON"}
		//: { "type": "texture1","prop":"_Mask1Tex", "label":"遮罩01","st":"true"}
		//: { "type": "int","prop":"_Params01", "label":"Mip级别","vectorComponent1":"z","min":"-2","max":"0"}
		//: { "type": "enum","prop":"_UseMapUV1", "label":"使用UV","enums":"UV0|UV1","vectorComponent1":"z"}
		//: { "type": "vector2","prop":"_Mask1_Mask2_Speed", "label":"UV速度","vectorComponent1":"x","vectorComponent2":"y"}
		_Mask1Tex("Mask1Tex", 2D) = "white" {}
		//: { "type": "texture1","prop":"_Mask2Tex", "label":"遮罩02","st":"true"}
		//: { "type": "int","prop":"_Params01", "label":"Mip级别","vectorComponent1":"w","min":"-2","max":"0"}
		//: { "type": "enum","prop":"_UseMapUV1", "label":"使用UV","enums":"UV0|UV1","vectorComponent1":"w"}
		//: { "type": "vector2","prop":"_Mask1_Mask2_Speed", "label":"UV速度","vectorComponent1":"z","vectorComponent2":"w"}
		_Mask2Tex("Mask2Tex", 2D) = "white" {}
		_Mask1_Mask2_Speed("Mask1_Mask2_Speed", Vector) = (0,0,0,0)

		//: { "type": "groupVariant","label":"溶解","keyword":"_CUTOFF_ON"}
		//: { "type": "texture1","prop":"_CutoffTex", "label":"溶解纹理","st":"true"}
		//: { "type": "int","prop":"_Params02", "label":"Mip级别","vectorComponent1":"x","min":"-2","max":"0"}
		_CutoffTex("CutoffTex", 2D) = "white" {}
		//: { "type": "texture1","prop":"_RampTex", "label":"溶解色","st":"true"}
		//: { "type": "int","prop":"_Params02", "label":"Mip级别","vectorComponent1":"y","min":"-2","max":"0"}
		_RampTex("RampTex", 2D) = "white" {}
		//: { "type": "enum","prop":"_CutoffUV2_Distortion_VertexColor_CustomData", "label":"使用UV","enums":"UV0|UV1","vectorComponent1":"x"}
		//: { "type": "vector2","prop":"_CutoffSpeed_Intensity_Soft", "label":"UV速度","vectorComponent1":"x","vectorComponent2":"y"}
		//: { "type": "float","prop":"_CutoffSpeed_Intensity_Soft", "label":"强度","vectorComponent1":"z","min":"0","max":"1"}
		//: { "type": "float","prop":"_CutoffSpeed_Intensity_Soft", "label":"柔化","vectorComponent1":"w"}
		//: { "type": "float","prop":"_Intensity_Color", "label":"溶解色强度","floatComponent1":"x"}
		//: { "type": "toggle","prop":"_CutoffUV2_Distortion_VertexColor_CustomData", "label":"CutOffToVertexColor","vectorComponent1":"z"}
		//: { "type": "toggle","prop":"_CutoffUV2_Distortion_VertexColor_CustomData", "label":"CutOffToCustomData","vectorComponent1":"w"}
		//: { "type": "info", "label":"CutOffTo开启时,强度应设置为1."}
		_CutoffSpeed_Intensity_Soft("CutoffSpeed_Intensity_Soft", Vector) = (0,0,0.5,0.5)
		_CutoffUV2_Distortion_VertexColor_CustomData("_CutoffTo",Vector)=(0,0,0,0)
		_Intensity_Color("Intensity_Color",float) = 0

		//: { "type": "groupVariant","label":"外发光","keyword":"_RIM_ON"}
		//: { "type": "color","prop":"_RimColor", "label":"颜色"}
		_RimColor("RimColor",color) = (1,1,1,1)
		//: { "type": "toggle","prop":"_Rim", "label":"是否反转","vectorComponent1":"x"}
		//: { "type": "toggle","prop":"_Rim", "label":"使用乘法(默认加法)","vectorComponent1":"w"}
		//: { "type": "float","prop":"_Rim", "label":"衰减","vectorComponent1":"y"}
		//: { "type": "float","prop":"_Rim", "label":"强度","vectorComponent1":"z"}
		_Rim("Rim",Vector) = (0,0,0,0)

		//: { "type": "groupVariant","label":"序列帧动画","keyword":"_SEQUENC"}
		//: { "type": "vector2","prop":"_SeqVector", "label":"序列图行列数","vectorComponent1":"x","vectorComponent2":"y"}
		//: { "type": "float","prop":"_SeqVector", "label":"序列图播放速度","vectorComponent1":"z"}
		_SeqVector("_SeqVector",vector) = (1,1,1,0)

		_Params01("",vector) = (0,0,0,0)
		_Params02("",vector) = (0,0,0,0)

		//: { "type": "group","label":"渲染状态"}
		//: { "type": "queue"}
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "RenderPipeline" = "UniversalPipeline"}
		Cull [_CullMode]
		ZWrite Off
		ZTest [_ZTest]
		Blend [_SrcBlend] [_DstBlend]
		Offset -0.1,-0.1

		Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
		}

		Pass 
		{
			Tags {"LightMode" = "UniversalForward"}
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma prefer_hlslcc gles
			#pragma target 3.5
			#pragma shader_feature_local _ _DISTORTION_ON
			#pragma shader_feature_local _ _MASKTEXUV_ON
			#pragma shader_feature_local _ _CUTOFF_ON
			#pragma shader_feature_local _ _RIM_ON
			#pragma shader_feature_local _ _SEQUENC
			#pragma shader_feature_local _ _VertAn
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

			CBUFFER_START(UnityPerMaterial)
				half _SrcBlend,_DstBlend,_Intensity_Color;
				half4 _BaseColor;
				half4 _UseMapUV1;
				float4 _MainTex_ST,_NoiseMap_ST;
				float4 _MainTex_DistortionTex_Speed;
				half4 _WrapMode_Rotation;
				float4 _DistortionTex_ST;
				half4 _Intensity_Opacity_DistortionIntensity_AlphaChannel;
				float4 _Mask1Tex_ST;
				float4 _Mask1_Mask2_Speed;
				float4 _Mask2Tex_ST;
				float4 _CutoffSpeed_Intensity_Soft;
				float4 _CutoffTex_ST;
				half4 _CutoffUV2_Distortion_VertexColor_CustomData;
				half4 _RimColor;
				half4 _Rim;
				float4 _SeqVector;
				half4 _Params01,_Params02;
			CBUFFER_END
			// float _GlobalTime;

			// 以下这种写法很多移动平台不支持
			// #define smp_clamp _linear_clamp
			// SAMPLER(smp_clamp);
			// #define smp_repeat _linear_repeat
			// SAMPLER(smp_repeat);
			TEXTURE2D (_MainTex);	SAMPLER(sampler_MainTex);//主纹理一定要设置为Repeat,在shader中再实现clamp
			TEXTURE2D(_DistortionTex);	SAMPLER(sampler_DistortionTex);
			TEXTURE2D(_Mask1Tex);	SAMPLER(sampler_Mask1Tex);
			TEXTURE2D(_Mask2Tex);	SAMPLER(sampler_Mask2Tex);
			TEXTURE2D(_CutoffTex);	SAMPLER(sampler_CutoffTex);
			TEXTURE2D(_RampTex);	SAMPLER(sampler_RampTex);

			struct appdata
			{
				float4 positionOS 	: POSITION;
				float4 texcoord0 	: TEXCOORD0;
				float4 texcoord1 	: TEXCOORD1;
				half4 color 		: COLOR;
				half3 normalOS		: NORMAL;
			};

			struct v2f 
			{
				float4 positionCS	: SV_POSITION;
				float4 uv0 			: TEXCOORD0;
				float4 uv1			: TEXCOORD1;
				half4 color 		: TEXCOORD2;
				half3 normalWS		: TEXCOORD3;
				half3 viewWS		: TEXCOORD4;
			};

			v2f vert (appdata v) 
			{
				v2f o =(v2f)0;
				o.uv0 = v.texcoord0;
				o.uv1 = v.texcoord1;
				o.color = v.color;
				o.normalWS = TransformObjectToWorldNormal(v.normalOS);
				float3 positionWS = TransformObjectToWorld(v.positionOS.xyz);
				o.viewWS = normalize(_WorldSpaceCameraPos - positionWS);				
				o.positionCS = TransformWorldToHClip(positionWS.xyz);
				return o;
			}

			half4 frag (v2f i,half _vface:VFACE) : SV_Target 
			{
				half4 c = 1;
				float2 customData;

				customData.x = i.uv0.z;	// 粒子中的CustomData存放位置
				customData.y = i.uv0.w;//粒子中的CustomData 控制UV.x 流动一次     UV需要改成Clamp
				// return i.uv0.w-0.5;

				half4 tintColor = half4(_BaseColor.rgb,1);
				
				//主纹理
				//由于两套UV需要分别针对多张纹理做Tiling和Offset，所以就不再放在vert中执行
				float2 uv0_MainTex = i.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv1_MainTex = i.uv1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 mainTex_speed = frac(float2(_MainTex_DistortionTex_Speed.xy * _Time.y));
				// float2 mainTex_speed = _MainTex_DistortionTex_Speed.xy * _GlobalTime;
				float2 mainTex_uv = lerp(uv0_MainTex,uv1_MainTex,_UseMapUV1.x);

				mainTex_uv += mainTex_speed;

				#if _SEQUENC
					float time = floor(_Time.y * _SeqVector.z);//控制时间
					float row = floor(time / _SeqVector.y);//行索引
					float col = time - row * _SeqVector.y;//列索引
					float2 cellSize = float2(mainTex_uv.x/_SeqVector.y,mainTex_uv.y/_SeqVector.x);//小图大小
					mainTex_uv.x = cellSize.x + col / _SeqVector.y;
					mainTex_uv.y = cellSize.y - row / _SeqVector.x;
				#endif

				//主纹理旋转    //因为精度问题  旋转不支持流UV   
				// float cosA = cos(_WrapMode_Rotation.y);
				// float sinA = sin(_WrapMode_Rotation.y);
				// float2x2 M_rotationZ = float2x2(
				// cosA,sinA,
				// -sinA,cosA);
				// mainTex_uv = mul(M_rotationZ,mainTex_uv*2-1)*0.5+0.5;
				mainTex_uv = lerp(mainTex_uv,saturate(float2(mainTex_uv.x+customData.y-1,mainTex_uv.y)),_WrapMode_Rotation.x);

				//纹理扭曲
				float2 distortionUV = mainTex_uv;
				float2 distortTex = 1;
				#if _DISTORTION_ON
					float2 uv0_DistortionTex = i.uv0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					float2 uv1_DistortionTex = i.uv1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					float2 distortionTex_speed = frac(float2(_MainTex_DistortionTex_Speed.zw * _Time.y));
					// float2 distortionTex_speed = _MainTex_DistortionTex_Speed.zw * _GlobalTime;
					float2 distortionTex_uv = lerp(uv0_DistortionTex,uv1_DistortionTex,_UseMapUV1.y);
					distortionTex_uv += distortionTex_speed;
					distortTex = SAMPLE_TEXTURE2D_BIAS( _DistortionTex,sampler_DistortionTex, distortionTex_uv,_Params01.y).rg;
					// distortionUV = (lerp( mainTex_uv, distortTex.xy , _Intensity_Opacity_DistortionIntensity_AlphaChannel.z));
					distortionUV = mainTex_uv + distortTex.xy * _Intensity_Opacity_DistortionIntensity_AlphaChannel.z;//结果与lerp一样
				#endif

				half4 mainTex;
				mainTex = SAMPLE_TEXTURE2D_BIAS(_MainTex,sampler_MainTex,distortionUV,_Params01.x);

				//利用采样器来实现UV的重复模式，可以解决边上有条线及重复度下扭曲不对的问题
				// if (_WrapMode_Rotation.x==0)
				// mainTex = SAMPLE_TEXTURE2D(_MainTex, smp_repeat, distortionUV);
				// else
				// mainTex = SAMPLE_TEXTURE2D(_MainTex, smp_clamp, distortionUV);

				//两个遮罩
				float3 maskTex01 = 1,maskTex02 = 1;
				#if _MASKTEXUV_ON
					float2 uv0_Mask1Tex = i.uv0.xy * _Mask1Tex_ST.xy + _Mask1Tex_ST.zw;
					float2 uv1_Mask1Tex = i.uv1.xy * _Mask1Tex_ST.xy + _Mask1Tex_ST.zw;
					float2 maskTex01_uv = lerp(uv0_Mask1Tex,uv1_Mask1Tex,_UseMapUV1.z);
					maskTex01_uv += frac(float2(_Mask1_Mask2_Speed.xy * _Time.y));
					// maskTex01_uv += _Mask1_Mask2_Speed.xy *_GlobalTime;
					maskTex01_uv=(maskTex01_uv);
					maskTex01 = SAMPLE_TEXTURE2D_BIAS( _Mask1Tex,sampler_Mask1Tex, maskTex01_uv,_Params01.z).rgb;
					float2 uv0_Mask2Tex = i.uv0.xy * _Mask2Tex_ST.xy + _Mask2Tex_ST.zw;
					float2 uv1_Mask2Tex = i.uv1.xy * _Mask2Tex_ST.xy + _Mask2Tex_ST.zw;
					float2 maskTex02_uv = lerp(uv0_Mask2Tex,uv1_Mask2Tex,_UseMapUV1.w);
					maskTex02_uv += frac(float2(_Mask1_Mask2_Speed.zw * _Time.y));
					// maskTex02_uv += fmod(_Mask1_Mask2_Speed.zw * _Time.y,1);
					maskTex02_uv=(maskTex02_uv);
					maskTex02 = SAMPLE_TEXTURE2D_BIAS( _Mask2Tex,sampler_Mask2Tex, maskTex02_uv,_Params01.w).rgb;
				#endif

				c = tintColor * mainTex * float4( i.color.rgb , 1 ) * maskTex01.r * maskTex02.r;

				//总体控制
				c.rgb *= _Intensity_Opacity_DistortionIntensity_AlphaChannel.x;
				float alpha = _BaseColor.a  * i.color.a * maskTex01.r * maskTex02.r;
				alpha *= lerp(mainTex.r,mainTex.a,_Intensity_Opacity_DistortionIntensity_AlphaChannel.w);

				//溶解
				#if _CUTOFF_ON
					float2 uv0_CutoffTex = i.uv0.xy * _CutoffTex_ST.xy + _CutoffTex_ST.zw;
					float2 uv1_CutoffTex = i.uv1.xy * _CutoffTex_ST.xy + _CutoffTex_ST.zw;
					float2 cutoffTex_uv = lerp(uv0_CutoffTex,uv1_CutoffTex,_CutoffUV2_Distortion_VertexColor_CustomData.x);
					cutoffTex_uv += frac(float2(_CutoffSpeed_Intensity_Soft.xy * _Time.y));
					// cutoffTex_uv += _CutoffSpeed_Intensity_Soft.xy * _GlobalTime;
					float2 distortionIntensity = lerp( cutoffTex_uv , distortTex.xy , _Intensity_Opacity_DistortionIntensity_AlphaChannel.z);
					float2 cutoff2Distortion = lerp(cutoffTex_uv,distortionIntensity,_CutoffUV2_Distortion_VertexColor_CustomData.y);
					cutoff2Distortion=frac(cutoff2Distortion);

					float cutoffTex = SAMPLE_TEXTURE2D_BIAS( _CutoffTex,sampler_CutoffTex, cutoff2Distortion,_Params02.x).r;
					//return cutoffTex;
					float cutoff2VertexColor = lerp(1,i.color.a,_CutoffUV2_Distortion_VertexColor_CustomData.z);
					float cutoff2CustomData = lerp(1,customData.x,_CutoffUV2_Distortion_VertexColor_CustomData.w);
					// float cutoffClamp = saturate( cutoffTex * cutoff2VertexColor * cutoff2CustomData + 1.0 +  _CutoffSpeed_Intensity_Soft.z * -2.0 );
					float cutoffClamp = saturate( cutoffTex + 1.0 +  _CutoffSpeed_Intensity_Soft.z * cutoff2VertexColor * cutoff2CustomData * -2.0 );
					float cutoff = smoothstep( 1.0 - _CutoffSpeed_Intensity_Soft.w, _CutoffSpeed_Intensity_Soft.w , cutoffClamp);
					// float alpha = _BaseColor.a * ( mainTex_Desaturate * mainTex.a ) * i.color.a * maskTex01.r * maskTex02.r;
					// half mainTexGrey = Luminance(mainTex.rgb);
					half4 RampTex = SAMPLE_TEXTURE2D_BIAS(_RampTex,sampler_RampTex, cutoff,_Params02.y);


					alpha *= cutoff;
					c.rgb += RampTex.rgb * _Intensity_Color;
				#endif

				//外发光
				#if _RIM_ON
					half4 rim = _RimColor;
					half NdotV = saturate(dot(i.normalWS*_vface,i.viewWS));
					NdotV = lerp(1-NdotV,NdotV,_Rim.x);
					NdotV = PositivePow(NdotV,_Rim.y) * _Rim.z;
					rim *= NdotV;
					if(_Rim.w==0)	c += rim;
					else	c *= rim;
				#endif

				c.a *= alpha * _Intensity_Opacity_DistortionIntensity_AlphaChannel.y;

				if(_SrcBlend==1&&_DstBlend==1)//Blend One One
				{
					c.rgb *= _Intensity_Opacity_DistortionIntensity_AlphaChannel.y * i.color.a * alpha;
				}
				
				return c;
			}
			ENDHLSL
		}
	}

	// CustomEditor "CommonEffectShaderGUI"
	CustomEditor "taecg.tools.CustomShaderGUI"
}
