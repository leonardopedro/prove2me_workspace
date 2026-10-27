-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.realCommutes_thetaR
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {θ : AntiUnitary V}
    (hθ : CommutesAntiUnitary M θ) : RealCommutes M (thetaR θ) := by

  intro m hm x
  simp only [thetaR_apply]
  exact hθ m hm x
