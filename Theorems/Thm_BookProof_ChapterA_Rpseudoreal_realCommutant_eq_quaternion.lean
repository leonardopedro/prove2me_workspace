-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Rpseudoreal_realCommutant_eq_quaternion
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.Rpseudoreal_realCommutant_eq_quaternion (M : System ℂ V) (hSchur : IsSchurFull M)
    {θ : AntiUnitary V} (hθ : ∀ x, θ (θ x) = -x) (hθc : CommutesAntiUnitary M θ)
    (S : V →L[ℝ] V) :
    RealCommutes M S ↔ ∃ q : Quaternion ℝ, S = qembed θ hθ q := by sorry
