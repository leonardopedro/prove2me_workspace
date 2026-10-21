-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.cplxify_commutes
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {T : V →L[ℝ] V}
    (hT : ∀ x, T (Complex.I • x) = Complex.I • T x) (hTc : RealCommutes M T) :
    M.Commutes (cplxify T hT) := by

  intro m hm
  ext x
  simp only [ContinuousLinearMap.mul_apply, cplxify_apply]
  exact hTc m hm x
