-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.SEtwo_one_mem
import Mathlib
import Definitions.Def_ChapterA4g
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : (1 : Matrix (Fin 2) (Fin 2) ℂ) ∈ SEtwo := ⟨by norm_num, by norm_num, by norm_num⟩
