-- Generated from ChapterFreeFieldGaussian.lean — theorem BookProof.ChapterFreeFieldGaussian.charFun_stdGaussian
import Mathlib
import Definitions.Def_ChapterFreeFieldGaussian
open BookProof.ChapterFreeFieldGaussian


open MeasureTheory ProbabilityTheory Complex WithLp
open scoped RealInnerProductSpace ENNReal


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldGaussian.charFun_stdGaussian (t : EuclideanSpace ℝ (Fin n)) :
    charFun (stdGaussian n) t = Complex.exp (-‖t‖ ^ 2 / 2) := by sorry
