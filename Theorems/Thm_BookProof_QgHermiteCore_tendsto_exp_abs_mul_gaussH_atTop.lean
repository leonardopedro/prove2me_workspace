-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.tendsto_exp_abs_mul_gaussH_atTop
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.tendsto_exp_abs_mul_gaussH_atTop (c : ℝ) :
    Tendsto (fun x : ℝ => Real.exp (c * |x|) * gaussH x) atTop (𝓝 0) := by sorry
