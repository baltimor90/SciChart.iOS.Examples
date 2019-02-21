uniform highp mat4 matProj;
uniform highp mat4 matWorld;
uniform highp mat4 matWorldView;
attribute highp vec4 vPosition;
attribute highp vec3 vNormal;
attribute highp vec2 vTexCoord0;
attribute highp vec4 vColor;
attribute highp vec4 vTexCoord1;
attribute highp vec4 vTexCoord2;
attribute highp vec4 vColor1;
attribute highp vec4 vColor2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR1;
varying highp vec4 xlv_COLOR2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = vPosition.w;
  highp vec3 instancePosition_2;
  highp vec4 tmpvar_3;
  tmpvar_1.y = (vPosition.y * abs(vTexCoord1.y));
  tmpvar_1.xz = (vPosition.xz * vTexCoord2.xz);
  instancePosition_2.xz = vTexCoord1.xz;
  instancePosition_2.y = (vTexCoord1.y * 0.5);
  tmpvar_1.xyz = (tmpvar_1.xyz + instancePosition_2);
  tmpvar_1.w = 1.0;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = vTexCoord0;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = matWorld[0].xyz;
  tmpvar_4[1] = matWorld[1].xyz;
  tmpvar_4[2] = matWorld[2].xyz;
  gl_Position = (tmpvar_1 * (matWorldView * matProj));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = vColor;
  xlv_TEXCOORD1 = (tmpvar_1 * matWorld);
  xlv_TEXCOORD2 = (vNormal * tmpvar_4);
  xlv_COLOR1 = vColor1;
  xlv_COLOR2 = vColor2;
}

