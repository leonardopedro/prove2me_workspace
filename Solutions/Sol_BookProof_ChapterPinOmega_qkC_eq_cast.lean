-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.qkC_eq_cast
import Mathlib
import Definitions.Def_ChapterPinOmega
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : qkC = (Int.castRingHom ℂ).mapMatrix qk := rfl
