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
