(module

	(func $shorts2packed (export "shorts2packed") (param v128 v128) (result v128)
	  local.get 0
	  local.get 1
		i16x8.narrow_i32x4_u
	)

	(func $bytes2packed (export "bytes2packed") (param v128 v128) (result v128)
	  local.get 0
	  local.get 1
		i8x16.narrow_i16x8_u
	)

	(func $bytes2packed4x (export "bytes2packed4x") (param v128 v128 v128 v128) (result v128)
		;; 4x v128(each v128: 4x i8 packed)
		;;   e.g.,
		;;   - input 0: 0x00 0x01 0x02 0x03
		;;   - input 1: 0x04 0x05 0x06 0x07
		;;   - input 2: 0x08 0x09 0x0a 0x0b
		;;   - input 3: 0x0c 0x0d 0x0e 0x0f
		;;   - output:  0x00010203 0x04050607 0x08090a0b 0x0c0d0e0f

		local.get 0 local.get 1 i16x8.narrow_i32x4_u
		local.get 2 local.get 3 i16x8.narrow_i32x4_u
		i8x16.narrow_i16x8_u
	)

	(func $vpack8shorts (export "vpack8shorts")
		(param v128 v128 v128 v128 v128 v128 v128 v128)
		(result v128 v128 v128 v128)

		local.get 0 local.get 1 i16x8.narrow_i32x4_u
		local.get 2 local.get 3 i16x8.narrow_i32x4_u
		local.get 4 local.get 5 i16x8.narrow_i32x4_u
		local.get 6 local.get 7 i16x8.narrow_i32x4_u
	)

	(func $vpack8bytes (export "vpack8bytes")
		(param v128 v128 v128 v128 v128 v128 v128 v128)
		(result v128 v128)

		local.get 0 local.get 1 i16x8.narrow_i32x4_u
		local.get 2 local.get 3 i16x8.narrow_i32x4_u
		i8x16.narrow_i16x8_u
		local.get 4 local.get 5 i16x8.narrow_i32x4_u
		local.get 6 local.get 7 i16x8.narrow_i32x4_u
		i8x16.narrow_i16x8_u
	)

)

(assert_return (invoke "shorts2packed"
	(v128.const i32x4 0 1 2 3)
	(v128.const i32x4 4 5 6 7)
)(v128.const i16x8 0 1 2 3 4 5 6 7))

(assert_return (invoke "shorts2packed"
	(v128.const i32x4 0x7ff0 0x7ff1 0x7ff2 0x7ff7)
	(v128.const i32x4 0x7ff3 0x7ff4 0x7ff5 0x7fff)
)(v128.const i16x8 0x7ff0 0x7ff1 0x7ff2 0x7ff7 0x7ff3 0x7ff4 0x7ff5 0x7fff))

(assert_return (invoke "shorts2packed"
	(v128.const i32x4 0xfff0 0xfff1 0xfff2 0xfff7)
	(v128.const i32x4 0xfff3 0xfff4 0xfff5 0xffff)
)(v128.const i16x8 0xfff0 0xfff1 0xfff2 0xfff7  0xfff3 0xfff4 0xfff5 0xffff))

(assert_return (invoke "bytes2packed"
	(v128.const i16x8 0 1 2 3 4 5 6 7)
	(v128.const i16x8 8 9 10 11 12 13 14 15)
)(v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

(assert_return (invoke "bytes2packed"
	(v128.const i16x8 0x70 0x71 0x72 0x73  0x74 0x75 0x76 0x77)
	(v128.const i16x8 0x78 0x79 0x7a 0x7b  0x7c 0x7d 0x7e 0x7f)
)(v128.const
  i8x16 0x70 0x71 0x72 0x73 0x74 0x75 0x76 0x77
	      0x78 0x79 0x7a 0x7b 0x7c 0x7d 0x7e 0x7f))

(assert_return (invoke "bytes2packed"
	(v128.const i16x8 0xf0 0xf1 0xf2 0xf3  0xf4 0xf5 0xf6 0xf7)
	(v128.const i16x8 0xf8 0xf9 0xfa 0xfb  0xfc 0xfd 0xfe 0xff)
)(v128.const
  i8x16 0xf0 0xf1 0xf2 0xf3  0xf4 0xf5 0xf6 0xf7
	      0xf8 0xf9 0xfa 0xfb  0xfc 0xfd 0xfe 0xff))

(assert_return (invoke "bytes2packed4x"
	(v128.const i32x4 0x00 0x01 0x02 0x03)
	(v128.const i32x4 0x04 0x05 0x06 0x07)
	(v128.const i32x4 0x08 0x09 0x0a 0x0b)
	(v128.const i32x4 0x0c 0x0d 0x0e 0x0f)
)(v128.const
	i8x16 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07
			  0x08 0x09 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f))

(assert_return (invoke "bytes2packed4x"
	(v128.const i32x4 0x80 0x81 0x82 0x83)
	(v128.const i32x4 0x84 0x85 0x86 0x87)
	(v128.const i32x4 0x88 0x89 0x8a 0x8b)
	(v128.const i32x4 0x8c 0x8d 0x8e 0x8f)
)(v128.const i8x16 0x80 0x81 0x82 0x83 0x84 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f))

(assert_return (invoke "bytes2packed4x"
	(v128.const i32x4 0 255 127 64)
	(v128.const i32x4 32 10 20 30)
	(v128.const i32x4 40 50 60 70)
	(v128.const i32x4 80 90 100 110)
)(v128.const i8x16 0 255 127 64 32 10 20 30 40 50 60 70 80 90 100 110))

(assert_return (invoke "vpack8shorts"
	(v128.const i64x2 0 0)
	(v128.const i64x2 0 0)
	(v128.const i64x2 0 0)
	(v128.const i64x2 0 0)
	(v128.const i64x2 0 0)
	(v128.const i64x2 0 0)
	(v128.const i64x2 0 0)
	(v128.const i64x2 0 0)
)
  (v128.const i64x2 0 0)
  (v128.const i64x2 0 0)
  (v128.const i64x2 0 0)
  (v128.const i64x2 0 0)
)

(assert_return (invoke "vpack8shorts"
	(v128.const i32x4 0 1 2 3)
	(v128.const i32x4 4 5 6 7)
	(v128.const i32x4 8 9 10 11)
	(v128.const i32x4 12 13 14 15)
	(v128.const i32x4 16 17 18 19)
	(v128.const i32x4 20 21 22 23)
	(v128.const i32x4 24 25 26 27)
	(v128.const i32x4 28 29 30 31)
)
  (v128.const i16x8 0 1 2 3 4 5 6 7)
  (v128.const i16x8 8 9 10 11 12 13 14 15)
  (v128.const i16x8 16 17 18 19 20 21 22 23)
  (v128.const i16x8 24 25 26 27 28 29 30 31)
)

(assert_return (invoke "vpack8shorts"
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
	(v128.const i32x4 0xffff 0xffff 0xffff 0xffff)
)
  (v128.const i16x8 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff)
  (v128.const i16x8 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff)
  (v128.const i16x8 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff)
  (v128.const i16x8 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff)
)

(assert_return (invoke "vpack8shorts"
	(v128.const i32x4 10 0 10 0)
	(v128.const i32x4 0 10 0 10)
	(v128.const i32x4 1 0 1 0)
	(v128.const i32x4 0 1 0 1)
	(v128.const i32x4 2 0 2 0)
	(v128.const i32x4 0 2 0 2)
	(v128.const i32x4 3 0 3 0)
	(v128.const i32x4 0 3 0 3)
)
  (v128.const i16x8 10 0 10 0 0 10 0 10)
  (v128.const i16x8 1 0 1 0 0 1 0 1)
  (v128.const i16x8 2 0 2 0 0 2 0 2)
  (v128.const i16x8 3 0 3 0 0 3 0 3)
)

(assert_return (invoke "vpack8bytes"
	(v128.const i32x4 0 1 2 3)
	(v128.const i32x4 4 5 6 7)
	(v128.const i32x4 8 9 10 11)
	(v128.const i32x4 12 13 14 15)
	(v128.const i32x4 16 17 18 19)
	(v128.const i32x4 20 21 22 23)
	(v128.const i32x4 24 25 26 27)
	(v128.const i32x4 28 29 30 31)
)
  (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
  (v128.const i8x16 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31)
)

(assert_return (invoke "vpack8bytes"
	(v128.const i32x4 0 255 0 255)
	(v128.const i32x4 255 0 255 0)
	(v128.const i32x4 0 255 0 255)
	(v128.const i32x4 255 0 255 0)
	(v128.const i32x4 127 127 127 127)
	(v128.const i32x4 1 2 3 4)
	(v128.const i32x4 5 6 7 8)
	(v128.const i32x4 9 10 11 12)
)
  (v128.const i8x16 0 255 0 255 255 0 255 0 0 255 0 255 255 0 255 0)
  (v128.const i8x16 127 127 127 127 1 2 3 4 5 6 7 8 9 10 11 12)
)

(assert_return (invoke "vpack8bytes"
	(v128.const i32x4 0 0 0 0)
	(v128.const i32x4 0 0 0 0)
	(v128.const i32x4 0 0 0 0)
	(v128.const i32x4 0 0 0 0)
	(v128.const i32x4 0 0 0 0)
	(v128.const i32x4 0 0 0 0)
	(v128.const i32x4 0 0 0 0)
	(v128.const i32x4 0 0 0 0)
)
  (v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
)
