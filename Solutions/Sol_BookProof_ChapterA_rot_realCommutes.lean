-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.rot_realCommutes
import Mathlib
import Definitions.Def_ChapterA2e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {N : System ℂ H} {θ : AntiUnitary H}
    (hθc : CommutesAntiUnitary N θ) (p s : ℂ) : RealCommutes N (rot θ p s) := by

  intro n hn x
  simp only [rot_apply, map_add, map_smul]
  rw [hθc n hn x]
