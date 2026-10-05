-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.SEtwo_mul_mem
import Mathlib
import Definitions.Def_ChapterA4g
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution {S T : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SEtwo) (hT : T ∈ SEtwo) : S * T ∈ SEtwo := by

  simp_all [SEtwo, Matrix.mul_apply]
