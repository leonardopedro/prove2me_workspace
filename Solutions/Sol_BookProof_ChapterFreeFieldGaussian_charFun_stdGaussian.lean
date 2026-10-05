-- Generated from ChapterFreeFieldGaussian.lean — solution of BookProof.ChapterFreeFieldGaussian.charFun_stdGaussian
import Mathlib
import Definitions.Def_ChapterFreeFieldGaussian
open BookProof.ChapterFreeFieldGaussian



open MeasureTheory ProbabilityTheory Complex WithLp
open scoped RealInnerProductSpace ENNReal


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (t : EuclideanSpace ℝ (Fin n)) :
    charFun (stdGaussian n) t = Complex.exp (-‖t‖ ^ 2 / 2) := by

  show charFun ((Measure.pi (fun _ : Fin n => gaussianReal 0 1)).map (toLp 2)) t = _
  rw [ProbabilityTheory.map_pi_eq_stdGaussian]
  exact ProbabilityTheory.charFun_stdGaussian t
