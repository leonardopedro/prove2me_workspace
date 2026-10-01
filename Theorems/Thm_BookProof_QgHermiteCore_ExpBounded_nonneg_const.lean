-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.ExpBounded.nonneg_const
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteCore.ExpBounded

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.ExpBounded.nonneg_const {f : E → ℝ} {C c : ℝ}
    (h : ∀ x, |f x| ≤ C * Real.exp (c * ‖x‖)) : 0 ≤ C := by sorry
