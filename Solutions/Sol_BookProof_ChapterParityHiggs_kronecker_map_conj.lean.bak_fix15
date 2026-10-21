-- Generated from ChapterParityHiggs.lean — solution of BookProof.ChapterParityHiggs.kronecker_map_conj
import Mathlib
import Definitions.Def_ChapterParityHiggs
open BookProof.ChapterParityHiggs



open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution {l m n p : Type*} (A : Matrix l m ℂ) (B : Matrix n p ℂ) :
    (A ⊗ₖ B).map (starRingEnd ℂ)
      = (A.map (starRingEnd ℂ)) ⊗ₖ (B.map (starRingEnd ℂ)) := by

  ext i j
  simp [Matrix.kroneckerMap_apply, Matrix.map_apply, map_mul]
