-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.SUtwo_mul_mem
import Mathlib
import Definitions.Def_ChapterA4g
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution {S T : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SUtwo) (hT : T ∈ SUtwo) : S * T ∈ SUtwo := by

  refine ⟨?_, ?_⟩
  · rw [Matrix.det_mul, hS.1, hT.1, mul_one]
  · rw [conjTranspose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc Sᴴ, hS.2, Matrix.one_mul, hT.2]
