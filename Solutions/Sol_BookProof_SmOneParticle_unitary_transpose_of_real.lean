-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.unitary_transpose_of_real
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (hV : IsMixing V) (hreal : ∀ i j, (V i j).im = 0) :
    V * Vᵀ = 1 := by

  have hct : Vᴴ = Vᵀ := by
    ext i j
    simp only [Matrix.conjTranspose_apply, Matrix.transpose_apply]
    exact Complex.conj_eq_iff_im.mpr (hreal j i)
  rwa [← hct]
