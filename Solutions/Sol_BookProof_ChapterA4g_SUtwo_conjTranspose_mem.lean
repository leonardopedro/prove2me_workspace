-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.SUtwo_conjTranspose_mem
import Mathlib
import Definitions.Def_ChapterA4g
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution {S : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SUtwo) : Sᴴ ∈ SUtwo := by

  refine ⟨?_, ?_⟩
  · rw [Matrix.det_conjTranspose, hS.1, star_one]
  · rw [conjTranspose_conjTranspose, mul_eq_one_comm, hS.2]
