

"$COMPATIBLE-DECLARATIONS-START$"
Smalltalk declarePoolDictionary: 'IS_RaspberryHardwareInterfaceTestWindow'.
Smalltalk declareVariable: 'IS_instanceInterfaceSpec' poolName: 'IS_RaspberryHardwareInterfaceTestWindow'.
"$COMPATIBLE-DECLARATIONS-END$"!

Application create: #RaspberryHardwareInterfaceTestApp with:
    (#( AbtRunViewsApp RaspberryHardwareInterfaceCoreApp SUnit)
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #RaspberryHardwareInterfaceTestApp missing: each]])!

RaspberryHardwareInterfaceTestApp becomeDefault!
AbtAppBldrView subclass: #RaspberryHardwareInterfaceTestWindow
    classInstanceVariableNames: ''
    instanceVariableNames: 'pinButtons gpioInterface '
    classVariableNames: 'Icons '
    poolDictionaries: 'RaspberryGpioConstants '!

RaspberryHardwareInterfaceTestApp becomeDefault!
Application subclass: #RaspberryHardwareInterfaceTestApp
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!

RaspberryHardwareInterfaceTestApp becomeDefault!
TestCase subclass: #TestI2cDeviceADXL345Accelerometer
    classInstanceVariableNames: ''
    instanceVariableNames: 'gpioInterface device '
    classVariableNames: ''
    poolDictionaries: ''!

RaspberryHardwareInterfaceTestApp becomeDefault!
Object subclass: #TestOneWireDS18B20ThermometerDevice
    classInstanceVariableNames: ''
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''!


RaspberryHardwareInterfaceTestApp becomeDefault!

!RaspberryHardwareInterfaceTestApp class privateMethods !

abtIsViewApplication

	^true! !

!RaspberryHardwareInterfaceTestWindow class publicMethods !

icons
	"Answer our icons."

	^Icons.
!

iconSetUp
	"Set up things."

	Icons := LookupTable new.
	Icons
		at: 'pinoff0(Normal)' put: self pinOffIcon;
		at: 'pinon0(Normal)' put: self pinOnIcon.

	Icons keysAndValuesDo: [:k :v |
		AbtIconDescriptor icons at: k put: v. 
	].!

pinOffIcon
	"Answer an instance of CgIcon."
	| icon palette paletteBytes maskData shapeData |

	maskData := #[255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255].

	shapeData := #[
		255 255 255 255 255 255 255 255 255 255 255 255 147 112 16 11 11 17 115 162 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 172 26 6 3 3 3 3 3
		3 6 111 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 162 12
		3 13 26 3 3 3 3 3 3 3 16 172 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 172 13 6 26 172 172 8 6 3 3 3 3 3 3 17 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 112 3 22 255 255 255 24 3 3 3 3 3 3 1
		3 122 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 165 6 6 165 255 255 26 3
		3 3 3 3 3 1 3 1 8 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 119
		3 112 255 255 112 6 3 3 3 3 3 3 3 1 3 1 143 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 24 6 147 255 162 6 3 3 3 3 3 3 3 1 3 1 1 112 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 13 6 255 255 115 3 6 3 3 3 3 1
		3 3 1 3 1 24 255 255 255 255 255 255 255 255 255 255 255 255 255 255 12 12 255 255 17
		3 3 3 3 3 3 3 3 1 1 1 1 22 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 16 6 13 6 3 3 3 3 3 3 3 3 1 3 1 1 1 26 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 27 3 6 3 3 3 6 3 3 3 1 3 3 1 3 1
		1 117 255 255 255 255 255 255 255 255 255 255 255 255 255 255 124 3 3 3 3 3 3 3 3
		3 3 3 1 1 1 1 3 148 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 8
		3 6 3 3 3 3 3 3 3 3 1 3 1 1 13 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 122 3 3 3 3 3 3 3 1 1 1 1 1 1 3 145 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 26 6 6 6 6 6 6 6 6 6 3
		6 3 115 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 172 16 12 12
		12 12 11 11 11 11 11 11 22 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 119 17 17 17 16 17 16 17 17 16 16 125 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 147 26 24 26 26 24 26 24 24 24 24 165 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 162 111 111 111 111 111 111
		111 111 111 111 172 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		165 117 117 117 117 117 117 117 117 117 117 172 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 165 124 124 122 124 122 124 122 124 122 122 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 143 125 124 124 124 124 125 125 125 145
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 111 26
		26 24 24 22 17 112 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 115 22 17 16 13 16 16 124 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 117 22 22 22 22 17 17 124 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 117 22 22 22 17 22
		17 124 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 117 22 22 17 22 17 17 124 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 117 22 24 24 24 24 22 147 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 112 24 24 24 24 119 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 148 13
		8 8 17 165 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 165 27 112 172 255 255 255 255 255 255 255 255 255 255 255 255 255 255
	].

	paletteBytes := #[
		0 0 0 0 0 0 0 0 22 22 22 22 22 22 0 0 25 25 25 25 25 25 0 0 29
		29 29 29 29 29 0 0 33 33 33 33 33 33 0 0 37 37 37 37 37 37 0 0 41 41
		41 41 41 41 0 0 45 45 45 45 45 45 0 0 51 51 51 51 51 51 0 0 55 55 55
		55 55 55 0 0 61 61 61 61 61 61 0 0 65 65 65 65 65 65 0 0 68 68 68 68
		68 68 0 0 73 73 73 73 73 73 0 0 76 76 76 76 76 76 0 0 82 82 82 82 82
		82 0 0 86 86 86 86 86 86 0 0 89 89 89 89 89 89 0 0 93 93 93 93 93 93
		0 0 112 112 109 109 78 78 0 0 117 117 118 118 83 83 0 0 97 97 97 97 97 97 0
		0 101 101 101 101 101 101 0 0 106 106 106 106 106 106 0 0 109 109 109 109 109 109 0 0
		113 113 113 113 113 113 0 0 117 117 117 117 117 117 0 0 121 121 121 121 121 121 0 0 127
		127 127 127 127 127 0 0 56 56 142 142 60 60 0 0 58 58 145 145 62 62 0 0 62 62
		151 151 66 66 0 0 66 66 153 153 71 71 0 0 76 76 153 153 79 79 0 0 80 80 155
		155 83 83 0 0 86 86 159 159 89 89 0 0 92 92 159 159 83 83 0 0 71 71 167 167
		75 75 0 0 76 76 174 174 80 80 0 0 81 81 176 176 85 85 0 0 87 87 179 179 90
		90 0 0 91 91 182 182 95 95 0 0 93 93 163 163 96 96 0 0 95 95 170 170 99 99
		0 0 100 100 166 166 103 103 0 0 103 103 169 169 107 107 0 0 108 108 172 172 111 111 0
		0 98 98 185 185 102 102 0 0 102 102 187 187 106 106 0 0 110 110 190 190 113 113 0 0
		114 114 175 175 116 116 0 0 115 115 187 187 118 118 0 0 122 122 190 190 124 124 0 0 114
		114 192 192 117 117 0 0 126 126 182 182 129 129 0 0 184 184 44 44 106 106 0 0 138 138
		87 87 85 85 0 0 138 138 89 89 85 85 0 0 151 151 91 91 118 118 0 0 155 155 95
		95 120 120 0 0 137 137 115 115 92 92 0 0 148 148 103 103 95 95 0 0 138 138 117 117
		125 125 0 0 149 149 108 108 124 124 0 0 159 159 97 97 122 122 0 0 153 153 111 111 126
		126 0 0 154 154 112 112 126 126 0 0 167 167 84 84 98 98 0 0 169 169 95 95 101 101
		0 0 173 173 89 89 101 101 0 0 180 180 77 77 118 118 0 0 180 180 89 89 102 102 0
		0 179 179 95 95 125 125 0 0 188 188 84 84 123 123 0 0 163 163 100 100 124 124 0 0
		165 165 102 102 125 125 0 0 167 167 104 104 126 126 0 0 186 186 100 100 108 108 0 0 186
		186 99 99 113 113 0 0 197 197 17 17 98 98 0 0 200 200 19 19 100 100 0 0 204 204
		22 22 101 101 0 0 200 200 25 25 102 102 0 0 201 201 30 30 106 106 0 0 210 210 28
		28 105 105 0 0 196 196 34 34 104 104 0 0 205 205 37 37 111 111 0 0 204 204 41 41
		109 109 0 0 193 193 51 51 111 111 0 0 199 199 56 56 114 114 0 0 205 205 61 61 117
		117 0 0 215 215 32 32 108 108 0 0 216 216 32 32 108 108 0 0 221 221 37 37 110 110
		0 0 208 208 44 44 116 116 0 0 208 208 49 49 119 119 0 0 208 208 50 50 120 120 0
		0 209 209 53 53 122 122 0 0 230 230 44 44 116 116 0 0 232 232 45 45 116 116 0 0
		236 236 49 49 119 119 0 0 195 195 71 71 119 119 0 0 198 198 73 73 120 120 0 0 202
		202 77 77 122 122 0 0 204 204 78 78 124 124 0 0 208 208 82 82 126 126 0 0 212 212
		74 74 135 135 0 0 215 215 85 85 143 143 0 0 220 220 103 103 155 155 0 0 221 221 104
		104 155 155 0 0 226 226 113 113 161 161 0 0 134 134 134 134 134 134 0 0 137 137 137 137
		137 137 0 0 140 140 140 140 140 140 0 0 147 147 147 147 147 147 0 0 149 149 149 149 149
		149 0 0 153 153 153 153 153 153 0 0 156 156 156 156 156 156 0 0 129 129 183 183 131 131
		0 0 162 162 162 162 162 162 0 0 167 167 167 167 167 167 0 0 171 171 171 171 171 171 0
		0 174 174 174 174 174 174 0 0 177 177 177 177 177 177 0 0 182 182 182 182 182 182 0 0
		184 184 184 184 184 184 0 0 128 128 194 194 131 131 0 0 158 158 200 200 160 160 0 0 159
		159 212 212 160 160 0 0 163 163 202 202 165 165 0 0 175 175 209 209 176 176 0 0 175 175
		219 219 176 176 0 0 183 183 214 214 184 184 0 0 180 180 221 221 182 182 0 0 189 189 224
		224 191 191 0 0 191 191 226 226 192 192 0 0 231 231 133 133 174 174 0 0 232 232 134 134
		174 174 0 0 231 231 136 136 176 176 0 0 237 237 157 157 191 191 0 0 237 237 162 162 193
		193 0 0 237 237 178 178 204 204 0 0 242 242 182 182 206 206 0 0 193 193 193 193 193 193
		0 0 198 198 198 198 198 198 0 0 205 205 205 205 205 205 0 0 192 192 220 220 193 193 0
		0 215 215 215 215 215 215 0 0 217 217 217 217 217 217 0 0 221 221 221 221 221 221 0 0
		203 203 225 225 204 204 0 0 204 204 232 232 205 205 0 0 209 209 229 229 210 210 0 0 211
		211 230 230 212 212 0 0 213 213 236 236 214 214 0 0 221 221 235 235 221 221 0 0 223 223
		240 240 223 223 0 0 234 234 195 195 208 208 0 0 243 243 196 196 216 216 0 0 241 241 200
		200 215 215 0 0 247 247 208 208 224 224 0 0 248 248 212 212 226 226 0 0 230 230 230 230
		230 230 0 0 226 226 239 239 227 227 0 0 232 232 232 232 232 232 0 0 237 237 237 237 237
		237 0 0 229 229 240 240 230 230 0 0 233 233 245 245 233 233 0 0 236 236 244 244 236 236
		0 0 250 250 229 229 237 237 0 0 242 242 242 242 242 242 0 0 241 241 246 246 241 241 0
		0 246 246 246 246 246 246 0 0 242 242 248 248 243 243 0 0 253 253 242 242 246 246 0 0
		249 249 249 249 249 249 0 0 254 254 254 254 254 254 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 0 0
	].

	palette := CgIndexedPalette new.
	palette byteRepresentation: paletteBytes; size: 256.

	icon := CgIcon
		width: 32
		height: 32
		depth: 8
		palette: palette
		shapePad: 4
		shapeData: shapeData
		maskPad: 4
		maskData: maskData.

	^icon.
!

pinOnIcon
	"Answer an instance of CgIcon."
	| icon palette paletteBytes maskData shapeData |

	maskData := #[255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255].

	shapeData := #[
		255 255 255 255 255 255 255 255 255 255 255 255 14 40 69 73 70 36 18 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 17 78 132 132 132 132 132 132
		132 75 19 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 32 132
		132 132 132 132 132 132 132 132 132 132 40 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 32 132 132 132 168 132 132 132 132 132 132 132 132 132 32 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 14 132 132 132 168 168 164 132 132 132 132 132 132 132 132
		132 17 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 73 132 132 168 168 159 132 132
		132 132 132 132 132 132 132 132 70 255 255 255 255 255 255 255 255 255 255 255 255 255 255 10 132
		132 168 168 164 132 132 132 132 132 132 132 132 132 132 132 132 13 255 255 255 255 255 255 255 255
		255 255 255 255 255 30 132 132 168 168 132 132 132 132 132 132 132 132 132 132 132 132 132 31 255
		255 255 255 255 255 255 255 255 255 255 255 255 42 132 159 168 164 132 132 132 132 132 132 132 132
		132 132 132 132 132 37 255 255 255 255 255 255 255 255 255 255 255 255 255 44 132 166 168 132 132
		132 132 132 132 132 132 132 132 132 132 132 132 43 255 255 255 255 255 255 255 255 255 255 255 255
		255 40 132 132 132 132 132 132 132 132 132 132 132 132 132 132 132 132 132 37 255 255 255 255 255
		255 255 255 255 255 255 255 255 27 132 132 132 132 132 132 132 132 132 132 132 132 132 132 132 132
		132 29 255 255 255 255 255 255 255 255 255 255 255 255 255 4 132 132 132 132 132 132 132 132 132
		132 132 132 132 132 132 132 132 10 255 255 255 255 255 255 255 255 255 255 255 255 255 255 46 132
		132 132 132 132 132 132 132 132 132 132 132 132 132 132 45 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 5 87 132 132 132 132 132 132 132 132 132 132 132 132 132 132 10 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 26 132 132 132 132 132 132 132 132 132 132 132
		132 132 27 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 47 117 108 108
		108 106 106 106 106 100 100 100 72 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 12 123 123 123 123 121 119 119 119 115 117 117 16 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 115 134 134 134 126 134 126 134 126 123 121 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 109 138 138 138 138 138 138
		129 129 129 121 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		112 140 140 139 139 139 139 139 139 139 126 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 112 131 131 131 131 131 131 131 131 131 128 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 41 132 132 132 132 132 132 132 132 132 67
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 23 68 60
		59 57 56 56 55 22 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 3 54 54 52 52 52 51 52 6 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 3 54 62 62 62 54 54 54 6 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 3 62 62 62 54 54 54
		52 6 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		3 62 62 62 62 54 54 54 6 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 3 54 62 64 64 64 64 62 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 21 64 64 64 64 64 24 255 255 255
		255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 8 24
		24 24 20 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
		255 255 255 255 255 255 3 20 6 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
	].

	paletteBytes := #[
		0 0 0 0 0 0 0 0 5 5 5 5 0 0 0 0 10 10 10 10 10 10 0 0 14
		14 14 14 14 14 0 0 23 23 24 24 2 2 0 0 27 27 28 28 3 3 0 0 18 18
		18 18 18 18 0 0 21 21 21 21 21 21 0 0 27 27 27 27 27 27 0 0 29 29 29
		29 29 29 0 0 33 33 34 34 1 1 0 0 36 36 37 37 4 4 0 0 37 37 37 37
		10 10 0 0 45 45 46 46 2 2 0 0 47 47 48 48 5 5 0 0 53 53 54 54 6
		6 0 0 51 51 52 52 14 14 0 0 55 55 56 56 4 4 0 0 56 56 57 57 6 6
		0 0 62 62 63 63 6 6 0 0 37 37 37 37 37 37 0 0 40 40 40 40 40 40 0
		0 62 62 61 61 38 38 0 0 63 63 62 62 42 42 0 0 50 50 50 50 50 50 0 0
		52 52 52 52 52 52 0 0 64 64 65 65 11 11 0 0 72 72 74 74 10 10 0 0 75
		75 76 76 9 9 0 0 78 78 80 80 4 4 0 0 84 84 85 85 10 10 0 0 86 86
		88 88 5 5 0 0 95 95 96 96 11 11 0 0 99 99 100 100 12 12 0 0 100 100 102
		102 8 8 0 0 103 103 105 105 9 9 0 0 103 103 105 105 12 12 0 0 106 106 108 108
		6 6 0 0 109 109 111 111 6 6 0 0 104 104 106 106 11 11 0 0 107 107 108 108 13
		13 0 0 108 108 105 105 25 25 0 0 111 111 113 113 13 13 0 0 116 116 118 118 6 6
		0 0 118 118 120 120 14 14 0 0 120 120 123 123 7 7 0 0 123 123 125 125 15 15 0
		0 121 121 123 123 30 30 0 0 65 65 65 65 65 65 0 0 68 68 68 68 68 68 0 0
		73 73 73 73 73 73 0 0 82 82 82 82 82 82 0 0 86 86 86 86 86 86 0 0 89
		89 89 89 89 89 0 0 93 93 93 93 93 93 0 0 105 105 104 104 74 74 0 0 109 109
		108 108 78 78 0 0 113 113 112 112 82 82 0 0 117 117 115 115 86 86 0 0 121 121 119
		119 90 90 0 0 124 124 123 123 94 94 0 0 98 98 98 98 98 98 0 0 101 101 101 101
		101 101 0 0 105 105 105 105 105 105 0 0 108 108 108 108 108 108 0 0 117 117 117 117 117
		117 0 0 121 121 121 121 121 121 0 0 129 129 125 125 30 30 0 0 128 128 127 127 97 97
		0 0 132 132 134 134 15 15 0 0 137 137 141 141 10 10 0 0 132 132 135 135 16 16 0
		0 129 129 131 131 30 30 0 0 142 142 144 144 16 16 0 0 150 150 153 153 15 15 0 0
		152 152 155 155 9 9 0 0 154 154 157 157 9 9 0 0 156 156 159 159 11 11 0 0 152
		152 156 156 19 19 0 0 156 156 160 160 11 11 0 0 158 158 161 161 12 12 0 0 160 160
		163 163 13 13 0 0 161 161 165 165 14 14 0 0 162 162 166 166 16 16 0 0 164 164 167
		167 16 16 0 0 166 166 169 169 17 17 0 0 166 166 169 169 27 27 0 0 168 168 171 171
		20 20 0 0 169 169 172 172 18 18 0 0 171 171 174 174 20 20 0 0 168 168 171 171 28
		28 0 0 170 170 173 173 29 29 0 0 172 172 176 176 20 20 0 0 174 174 178 178 24 24
		0 0 173 173 176 176 30 30 0 0 176 176 179 179 21 21 0 0 176 176 180 180 21 21 0
		0 177 177 181 181 29 29 0 0 176 176 178 178 32 32 0 0 177 177 181 181 33 33 0 0
		178 178 181 181 42 42 0 0 180 180 183 183 42 42 0 0 181 181 183 183 44 44 0 0 180
		180 184 184 34 34 0 0 182 182 185 185 39 39 0 0 182 182 185 185 45 45 0 0 184 184
		187 187 46 46 0 0 186 186 189 189 46 46 0 0 188 188 191 191 47 47 0 0 182 182 181
		181 56 56 0 0 184 184 188 188 49 49 0 0 185 185 188 188 52 52 0 0 191 191 187 187
		48 48 0 0 188 188 186 186 54 54 0 0 189 189 191 191 53 53 0 0 190 190 191 191 59
		59 0 0 189 189 192 192 48 48 0 0 190 190 192 192 54 54 0 0 192 192 194 194 55 55
		0 0 193 193 195 195 56 56 0 0 194 194 196 196 56 56 0 0 197 197 195 195 58 58 0
		0 196 196 198 198 57 57 0 0 198 198 200 200 58 58 0 0 201 201 202 202 61 61 0 0
		203 203 204 204 62 62 0 0 206 206 203 203 58 58 0 0 204 204 205 205 62 62 0 0 212
		212 207 207 52 52 0 0 211 211 210 210 63 63 0 0 221 221 218 218 62 62 0 0 230 230
		224 224 57 57 0 0 232 232 226 226 54 54 0 0 192 192 194 194 66 66 0 0 205 205 206
		206 64 64 0 0 197 197 199 199 85 85 0 0 211 211 210 210 64 64 0 0 212 212 211 211
		64 64 0 0 213 213 212 212 65 65 0 0 222 222 219 219 64 64 0 0 222 222 220 220 64
		64 0 0 201 201 204 204 103 103 0 0 134 134 134 134 134 134 0 0 137 137 137 137 137 137
		0 0 149 149 149 149 149 149 0 0 156 156 156 156 156 156 0 0 162 162 162 162 162 162 0
		0 174 174 174 174 174 174 0 0 182 182 182 182 182 182 0 0 184 184 184 184 184 184 0 0
		213 213 214 214 132 132 0 0 217 217 219 219 147 147 0 0 220 220 222 222 153 153 0 0 226
		226 228 228 174 174 0 0 228 228 229 229 175 175 0 0 193 193 193 193 193 193 0 0 205 205
		205 205 205 205 0 0 215 215 215 215 215 215 0 0 217 217 217 217 217 217 0 0 239 239 240
		240 209 209 0 0 240 240 241 241 213 213 0 0 243 243 244 244 222 222 0 0 230 230 230 230
		230 230 0 0 237 237 237 237 237 237 0 0 246 246 246 246 230 230 0 0 247 247 247 247 233
		233 0 0 248 248 248 248 235 235 0 0 246 246 246 246 246 246 0 0 254 254 254 254 254 254
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 0 0
	].

	palette := CgIndexedPalette new.
	palette byteRepresentation: paletteBytes; size: 256.

	icon := CgIcon
		width: 32
		height: 32
		depth: 8
		palette: palette
		shapePad: 4
		shapeData: shapeData
		maskPad: 4
		maskData: maskData.

	^icon.
! !

!RaspberryHardwareInterfaceTestWindow class privateMethods !

_PRAGMA_IS_

	"%%PRAGMA DECLARE
	(name: IS_RaspberryHardwareInterfaceTestWindow isPool: true isConstant: false)
	(pool: IS_RaspberryHardwareInterfaceTestWindow declarations: (
		(name: IS_instanceInterfaceSpec isConstant: false)
	))"!

abtPrimFlushInterfaceSpecCache

	IS_RaspberryHardwareInterfaceTestWindow associationsDo: [: poolDictionaryAssoc | poolDictionaryAssoc value: nil].
	super abtPrimFlushInterfaceSpecCache!

abtUntranslatedConstants
	"** Do not modify or delete **  See: AbtAppBldrPart class>>#about_abtUntranslatedConstants"

	^#(
	'Raspberry Hardware Interface Test'
	'2/3'
	'3/5'
	'4/7'
	'5/29'
	'6/31'
	'7/26'
	'8/24'
	'9/21'
	'10/19'
	'11/23'
	'12/32'
	'13/33'
	'14/8'
	'15/10'
	'16/36'
	'17/11'
	'18/12'
	'19/35'
	'20/38'
	'21/40'
	'22/15'
	'23/16'
	'24/18'
	'25/22'
	'26/37'
	'27/13'
	)!

IS_instanceInterfaceSpec
	"Private - ** Warning ** This method is generated by VisualAge and should not
	be modified or deleted. This method is responsible for returning a featureSpec
	that describes the implementation of a particular feature of the receiver"

	^IS_RaspberryHardwareInterfaceTestWindow::IS_instanceInterfaceSpec notNil
		ifTrue: [IS_RaspberryHardwareInterfaceTestWindow::IS_instanceInterfaceSpec]
		ifFalse: [
		IS_RaspberryHardwareInterfaceTestWindow::IS_instanceInterfaceSpec := AbtInterfaceSpec new]! !

!RaspberryHardwareInterfaceTestWindow privateMethods !

abtBuildInternals
	"** Do not modify or delete **  See: AbtAppBldrPart class>>#about_abtBuildInternals"

	| gui window pinPushButton2 pinPushButton3 pinPushButton4 pinPushButton5 pinPushButton6
	 pinPushButton7 pinPushButton8 pinPushButton9 pinPushButton10 pinPushButton11 pinPushButton12
	 pinPushButton13 pinPushButton14 pinPushButton15 pinPushButton16 pinPushButton17 pinPushButton18
	 pinPushButton19 pinPushButton20 pinPushButton21 pinPushButton22 pinPushButton23 pinPushButton24
	 pinPushButton25 pinPushButton26 pinPushButton27 infoMultiLineEdit label2 label3 label4 label5
	 label6 label7 label8 label9 label10 label11 label12 label13 label14 label15 label16 label17 label18
	 label19 label20 label21 label22 label23 label24 label25 label26 label27 conn0 conn1 |
	gui := self class abtSeparatedConstants.
	window := AbtShellView abtCreatePart: 'Window' parent: nil owner: self .
	pinPushButton2 := AbtPushButtonView abtCreatePart: 'Pin Push Button 2' parent: window.
	pinPushButton3 := AbtPushButtonView abtCreatePart: 'Pin Push Button 3' parent: window.
	pinPushButton4 := AbtPushButtonView abtCreatePart: 'Pin Push Button 4' parent: window.
	pinPushButton5 := AbtPushButtonView abtCreatePart: 'Pin Push Button 5' parent: window.
	pinPushButton6 := AbtPushButtonView abtCreatePart: 'Pin Push Button 6' parent: window.
	pinPushButton7 := AbtPushButtonView abtCreatePart: 'Pin Push Button 7' parent: window.
	pinPushButton8 := AbtPushButtonView abtCreatePart: 'Pin Push Button 8' parent: window.
	pinPushButton9 := AbtPushButtonView abtCreatePart: 'Pin Push Button 9' parent: window.
	pinPushButton10 := AbtPushButtonView abtCreatePart: 'Pin Push Button 10' parent: window.
	pinPushButton11 := AbtPushButtonView abtCreatePart: 'Pin Push Button 11' parent: window.
	pinPushButton12 := AbtPushButtonView abtCreatePart: 'Pin Push Button 12' parent: window.
	pinPushButton13 := AbtPushButtonView abtCreatePart: 'Pin Push Button 13' parent: window.
	pinPushButton14 := AbtPushButtonView abtCreatePart: 'Pin Push Button 14' parent: window.
	pinPushButton15 := AbtPushButtonView abtCreatePart: 'Pin Push Button 15' parent: window.
	pinPushButton16 := AbtPushButtonView abtCreatePart: 'Pin Push Button 16' parent: window.
	pinPushButton17 := AbtPushButtonView abtCreatePart: 'Pin Push Button 17' parent: window.
	pinPushButton18 := AbtPushButtonView abtCreatePart: 'Pin Push Button 18' parent: window.
	pinPushButton19 := AbtPushButtonView abtCreatePart: 'Pin Push Button 19' parent: window.
	pinPushButton20 := AbtPushButtonView abtCreatePart: 'Pin Push Button 20' parent: window.
	pinPushButton21 := AbtPushButtonView abtCreatePart: 'Pin Push Button 21' parent: window.
	pinPushButton22 := AbtPushButtonView abtCreatePart: 'Pin Push Button 22' parent: window.
	pinPushButton23 := AbtPushButtonView abtCreatePart: 'Pin Push Button 23' parent: window.
	pinPushButton24 := AbtPushButtonView abtCreatePart: 'Pin Push Button 24' parent: window.
	pinPushButton25 := AbtPushButtonView abtCreatePart: 'Pin Push Button 25' parent: window.
	pinPushButton26 := AbtPushButtonView abtCreatePart: 'Pin Push Button 26' parent: window.
	pinPushButton27 := AbtPushButtonView abtCreatePart: 'Pin Push Button 27' parent: window.
	infoMultiLineEdit := AbtMultiLineEditView abtCreatePart: 'Info Multi-line Edit' parent: window.
	label2 := AbtLabelView abtCreatePart: 'Label2' parent: window.
	label3 := AbtLabelView abtCreatePart: 'Label3' parent: window.
	label4 := AbtLabelView abtCreatePart: 'Label4' parent: window.
	label5 := AbtLabelView abtCreatePart: 'Label5' parent: window.
	label6 := AbtLabelView abtCreatePart: 'Label6' parent: window.
	label7 := AbtLabelView abtCreatePart: 'Label7' parent: window.
	label8 := AbtLabelView abtCreatePart: 'Label8' parent: window.
	label9 := AbtLabelView abtCreatePart: 'Label9' parent: window.
	label10 := AbtLabelView abtCreatePart: 'Label10' parent: window.
	label11 := AbtLabelView abtCreatePart: 'Label11' parent: window.
	label12 := AbtLabelView abtCreatePart: 'Label12' parent: window.
	label13 := AbtLabelView abtCreatePart: 'Label13' parent: window.
	label14 := AbtLabelView abtCreatePart: 'Label14' parent: window.
	label15 := AbtLabelView abtCreatePart: 'Label15' parent: window.
	label16 := AbtLabelView abtCreatePart: 'Label16' parent: window.
	label17 := AbtLabelView abtCreatePart: 'Label17' parent: window.
	label18 := AbtLabelView abtCreatePart: 'Label18' parent: window.
	label19 := AbtLabelView abtCreatePart: 'Label19' parent: window.
	label20 := AbtLabelView abtCreatePart: 'Label20' parent: window.
	label21 := AbtLabelView abtCreatePart: 'Label21' parent: window.
	label22 := AbtLabelView abtCreatePart: 'Label22' parent: window.
	label23 := AbtLabelView abtCreatePart: 'Label23' parent: window.
	label24 := AbtLabelView abtCreatePart: 'Label24' parent: window.
	label25 := AbtLabelView abtCreatePart: 'Label25' parent: window.
	label26 := AbtLabelView abtCreatePart: 'Label26' parent: window.
	label27 := AbtLabelView abtCreatePart: 'Label27' parent: window.
	self 
		 primaryPart: window.
	window 
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtEdgeConstant new offset: 300);
			rightEdge: (AbtEdgeConstant new offset: 560);
			topEdge: (AbtEdgeConstant new offset: 300);
			bottomEdge: (AbtEdgeConstant new offset: 400));
		 title: (gui at: 1)          " 'Raspberry Hardware Interface Test' " .
	pinPushButton2 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton3 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton2);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton4 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton3);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton5 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton4);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton6 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton5);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton7 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton6);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton8 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton7);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton9 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton8);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton10 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton9);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton11 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton10);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton12 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton11);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton13 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton12);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton14 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton13);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton2);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton15 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton2);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 10; attachedTargetView: label2);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton16 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton17 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton16);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton18 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton17);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton19 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton18);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton20 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton19);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton21 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton20);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton22 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton21);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton23 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton22);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton24 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton23);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton25 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton24);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton26 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton25);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	pinPushButton27 
		 labelType: 3;
		 marginWidth: 0;
		 marginHeight: 0;
		 graphicsDescriptor: (AbtIconDescriptor new moduleName: 'PinOff'; id: 0; shading: AbtNormalGraphic);
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton26);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	infoMultiLineEdit 
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 20);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 15; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 15));
		 editable: false;
		 showHorizontalScrollBar: false;
		 wordWrap: true.
	label2 
		 object: (gui at: 2)          " '2/3' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton2);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton2);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton2);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label3 
		 object: (gui at: 3)          " '3/5' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton3);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton3);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label4 
		 object: (gui at: 4)          " '4/7' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton4);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton4);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label5 
		 object: (gui at: 5)          " '5/29' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton5);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton5);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label6 
		 object: (gui at: 6)          " '6/31' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton6);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton6);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label7 
		 object: (gui at: 7)          " '7/26' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton7);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton7);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label8 
		 object: (gui at: 8)          " '8/24' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton8);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton8);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label9 
		 object: (gui at: 9)          " '9/21' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton9);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton9);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label10 
		 object: (gui at: 10)          " '10/19' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton10);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton10);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label11 
		 object: (gui at: 11)          " '11/23' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton11);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton11);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label12 
		 object: (gui at: 12)          " '12/32' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton12);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton12);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label13 
		 object: (gui at: 13)          " '13/33' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton13);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton13);
			topEdge: (AbtEdgeAttachmentConstraint new attachment: XmATTACHFORM; offset: 60);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label14 
		 object: (gui at: 14)          " '14/8' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton14);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton14);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton14);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label15 
		 object: (gui at: 15)          " '15/10' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHWIDGET; offset: 0; attachedTargetView: pinPushButton15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label16 
		 object: (gui at: 16)          " '16/36' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton16);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton16);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label17 
		 object: (gui at: 17)          " '17/11' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton17);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton17);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label18 
		 object: (gui at: 18)          " '18/12' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton18);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton18);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label19 
		 object: (gui at: 19)          " '19/35' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton19);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton19);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label20 
		 object: (gui at: 20)          " '20/38' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton20);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton20);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label21 
		 object: (gui at: 21)          " '21/40' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton21);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton21);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label22 
		 object: (gui at: 22)          " '22/15' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton22);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton22);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label23 
		 object: (gui at: 23)          " '23/16' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton23);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton23);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label24 
		 object: (gui at: 24)          " '24/18' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton24);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton24);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label25 
		 object: (gui at: 25)          " '25/22' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton25);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton25);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label26 
		 object: (gui at: 26)          " '26/37' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton26);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton26);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	label27 
		 object: (gui at: 27)          " '27/13' " ;
		 framingSpec: (AbtViewAttachmentConstraint new
			leftEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton27);
			rightEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: pinPushButton27);
			topEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHOPPOSITEWIDGET; offset: 0; attachedTargetView: label15);
			bottomEdge: (AbtRunEdgeAttachmentConstraint new attachment: XmATTACHNONE)).
	window
		abtWhenPrimitive: #openedWidget
		perform: 
			(DirectedMessage new 
				receiver: self;
				selector: #afterOpenSetUp;
				arguments: #()).
	window
		abtWhenPrimitive: #aboutToCloseWidget
		perform: 
			(DirectedMessage new 
				receiver: self;
				selector: #terminate;
				arguments: #()).
	self finalInitialize.
!

afterOpenSetUp
	"Setup some stuff."

	gpioInterface := RaspberryGpioInterface raspberryGpioStart.

	2 to: 27 do: [:pn |
		gpioInterface pinSetAsOutput: pn.
		gpioInterface pin: pn write: 0.
	].
	self forkPinTest.
	self forkRandomPinSet.
!

finalInitialize
	"setup some stuff."
	| buttonName |
	
	buttonName := 'Pin Push Button '. 
	
	pinButtons := Array new: 26.
	1 to: 26 do: [:i |
		pinButtons at: i put: (self subpartNamed: (buttonName, (i + 1) printString)). 
	].

	pinButtons doWithIndex: [:pb :i | | arg |
		arg := Array with: (i + 1).
		pb
			abtWhenPrimitive: #clicked
			perform: 
				(DirectedMessage new 
					receiver: self;
					selector: #togglePinState:;
					arguments: arg).
	].
	(self subpartNamed: 'Info Multi-line Edit') object: self helpInfo.
!

forkPinTest
	"Fork a loop to test pins and set their corresponding button icon."

	[ | delay |
	
		delay := Delay forSeconds: 1.
		[self abtIsDestroyed] whileFalse: [
			(self subpartNamed: 'Info Multi-line Edit') setFocus.
			pinButtons doWithIndex: [:pb :i | | pin |
				pin := i + 1.
				[ | iconName |
					iconName := (gpioInterface isPinOn: pin) ifTrue: ['PinOn'] ifFalse: ['PinOff'].
					pb abtIsDestroyed ifFalse: [pb graphicsDescriptor moduleName: iconName].
					pb abtIsDestroyed ifFalse: [pb recreateWidget].
				] on: Error do: [:sig | sig exitWith: nil].
			].
			delay wait.
		].
	] fork.
!

forkRandomPinSet
	"Fork a loop to randomly set pins on (20%) or off (80%)."

	[ | delay random |
	
		delay := Delay forSeconds: 10.
		random := EsRandom new.
		[self abtIsDestroyed] whileFalse: [
			2 to: 27 do: [:pin |
				gpioInterface pin: pin write: (((random nextInt: 5) = 3) ifTrue: [1] ifFalse: [0]).
			].
			delay wait.
		].
	] fork.
!

helpInfo
	"Information about this program."
	| infoStream |

	infoStream := WriteStream on: ''.
	infoStream
		nextPutAll: 'This program tests the basic connection to the VA Smalltalk Raspberry Hardware Interface Interface.  ';
		nextPutAll: 'It tests turning all the controllable GPIO pins (2 to 27) on and off.'; cr; cr;
		nextPutAll: 'The buttons above represent the state of the correcponding pin.  ';
		nextPutAll: 'The left of the label repersents the GPIO pin number and the right represents the physical pin number.  ';
		nextPutAll: 'The dark light bulb represents a pin that is in the off state ';
		nextPutAll: 'and a yellow light bulb represents a pin that is in the on state.  ';
		nextPutAll: 'They are tested about once a second to determine their state and the correcponding icon is displayed.  '; cr; cr;
		nextPutAll: 'You can test the pins physically by connecting a volt meter which has been set to 5 or 10 volts DC range.  ';
		nextPutAll: 'If the pin is on, the meter should register between 3 and 3.5 volts.  ';
		nextPutAll: 'Approximately every ten seconds 20% of the pins are turned on and the rest are turned off.  ';
		nextPutAll: 'Clicking on a button will toggle the pin state.  The button icon will reflect the change in the next iteration of the pin test loop.'; cr; cr; cr;
		nextPutAll: '(C) Copyright 2018.'; cr; cr;
		nextPutAll: 'Writen by Alex LaBrunda and Louis LaBrunda under the MIT licence.'; cr; cr.
		
		
	^infoStream contents.
!

terminate
	"Terminate Library."

	gpioInterface terminateLibrary.
!

togglePinState: pin
	"switches the state of the given pin."
	
	gpioInterface pin: pin write: ((gpioInterface isPinOn: pin) ifTrue: [0] ifFalse: [1]).
! !

!TestI2cDeviceADXL345Accelerometer class publicMethods !

printCoordinatesFor: seconds on: aStream

	| gpioInterface device |

	[
		gpioInterface := RaspberryGpioDaemonInterface raspberryGpioStart.
		device :=
			gpioInterface
				createI2cDevice: I2cDeviceADXL345Accelerometer
				slaveAddress: I2cDeviceADXL345Accelerometer defaultI2CAddress.
		aStream
			show: 'Accelerometer X, Y, Z';
			cr.
		seconds timesRepeat: [| coordinates |
			coordinates := device readCoordinates.
			aStream
				show: 'X=' , coordinates first asString;
				show: ', Y=' , coordinates second asString;
				show: ', Z=' , coordinates third asString;
				cr.
			(Delay forSeconds: 1) wait]]
				ensure: [gpioInterface shutDown]!

printCoordinatesToTranscriptFor10secs
	TestI2cDeviceADXL345Accelerometer printCoordinatesFor: 10 on: TranscriptTTY default ! !

!TestI2cDeviceADXL345Accelerometer publicMethods !

createI2cDevice

	device :=
		gpioInterface
			createI2cDevice: I2cDeviceADXL345Accelerometer
			slaveAddress: I2cDeviceADXL345Accelerometer defaultI2CAddress!

setUp

	gpioInterface := RaspberryGpioDaemonInterface raspberryGpioStart!

tearDown

	gpioInterface shutDown!

testConnection

	self shouldnt: [self createI2cDevice] raise: Error.
	self assert: (device isKindOf: I2cDeviceADXL345Accelerometer)!

testReadCoordinates

	self createI2cDevice.
	self assert: device readCoordinates isArray.
	self assert: device readCoordinates size equals: 3.
	device readCoordinates do: [:each | each isInteger]! !

!TestOneWireDS18B20ThermometerDevice class publicMethods !

dumpTemperatureFetchingOn: aWriteStream

	aWriteStream
		nextPutAll: Time now printString;
		nextPutAll: ': '.
	OneWireDevice initializeOnLoad.
	OneWireDS18B20ThermometerDevice listDevices do: [:anIdString |
		aWriteStream
			nextPutAll: anIdString;
			nextPutAll: ', '.
		(OneWireDS18B20ThermometerDevice idString: anIdString)
			ifNotNil: [:aDevice | | aTemperature |
				aTemperature := aDevice temperature.
				aWriteStream
					nextPutAll: aTemperature printString;
					nextPutAll: ', '.
				aWriteStream nextPutAll: (
					aTemperature = 999
						ifFalse: ['my temperature %1 = %2' bindWith: anIdString with: aTemperature]
						ifTrue: ['Error reading the temperature (%1)' bindWith: anIdString])]
			ifNil: [aWriteStream nextPutAll: 'Error getting an OneWireDevice']].
	aWriteStream nextPutAll: 'Done!!'!

dumpTemperatureFetchingOnTranscript
	self dumpTemperatureFetchingOn: Transcript!

fetchTemperature
	"Answers the temperature as Celsius and as a Float"

	| devices |

	devices := OneWireDS18B20ThermometerDevice listDevices.
	devices isEmpty ifTrue: [self error: 'There is no device detected'].
	devices size > 1 ifTrue: [self error: 'There is more than one device detected'].
	^(OneWireDS18B20ThermometerDevice idString: devices first)
		ifNotNil: [:aDevice | aDevice temperature]! !

RaspberryHardwareInterfaceTestApp toBeLoadedCode: '"$COMPATIBLE-DECLARATIONS-START$"
Smalltalk declarePoolDictionary: ''IS_RaspberryHardwareInterfaceTestWindow''.
Smalltalk declareVariable: ''IS_instanceInterfaceSpec'' poolName: ''IS_RaspberryHardwareInterfaceTestWindow''.
"$COMPATIBLE-DECLARATIONS-END$"'!

RaspberryHardwareInterfaceTestApp wasRemovedCode: '"$COMPATIBLE-DECLARATIONS-START$"
Smalltalk undeclare: ''IS_RaspberryHardwareInterfaceTestWindow''.
"$COMPATIBLE-DECLARATIONS-END$"'!

RaspberryHardwareInterfaceTestWindow initializeAfterLoad!
RaspberryHardwareInterfaceTestApp initializeAfterLoad!
TestI2cDeviceADXL345Accelerometer initializeAfterLoad!
TestOneWireDS18B20ThermometerDevice initializeAfterLoad!

RaspberryHardwareInterfaceTestApp loaded!