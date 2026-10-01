-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.phi_one
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {A : Type*} [Ring A] [Algebra ℂ A]


open scoped BigOperators
open intervalIntegral


noncomputable section

ntinuous.intervalIntegrable ( by continuity ) _ _;
      · exact Continuous.intervalIntegrable ( by continuity ) _ _

theorem BookProof.ChapterH1.phi_one {z : ℂ} (hz : z ≠ 0) : phi 1 z = (Complex.exp z - 1) / z := by
  have h := phi_succ_mul 0 z
  simp only [phi_zero_apply, Na := by sorry
