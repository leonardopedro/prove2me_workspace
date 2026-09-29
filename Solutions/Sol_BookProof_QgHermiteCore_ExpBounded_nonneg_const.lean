-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.ExpBounded.nonneg_const
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution {f : E → ℝ} {C c : ℝ}
    (h : ∀ x, |f x| ≤ C * Real.exp (c * ‖x‖)) : 0 ≤ C := by

  have h0 := h 0
  rw [norm_zero, mul_zero, Real.exp_zero, mul_one] at h0
  exact (abs_nonneg _).trans h0
