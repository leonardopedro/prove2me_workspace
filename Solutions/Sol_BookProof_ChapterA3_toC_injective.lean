-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.toC_injective
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective toC := by

  intro M N h;
  ext i j; have := congr_fun ( congr_fun h i ) j; simp_all [ Complex.ext_iff, toC ] ;
