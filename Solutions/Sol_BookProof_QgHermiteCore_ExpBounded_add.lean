-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.ExpBounded.add
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_nonneg_const
open BookProof.QgHermiteCore
open BookProof.QgHermiteCore.ExpBounded














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution {f g : E → ℝ} (hf : ExpBounded f) (hg : ExpBounded g) :
    ExpBounded (fun x => f x + g x) := by

  obtain ⟨C1, c1, hc1, h1⟩ := hf
  obtain ⟨C2, c2, _, h2⟩ := hg
  have hC1 : 0 ≤ C1 := ExpBounded.nonneg_const h1
  have hC2 : 0 ≤ C2 := ExpBounded.nonneg_const h2
  refine ⟨C1 + C2, max c1 c2, le_trans hc1 (le_max_left _ _), fun x => ?_⟩
  have e1 : C1 * Real.exp (c1 * ‖x‖) ≤ C1 * Real.exp (max c1 c2 * ‖x‖) := by
    gcongr
    · exact le_max_left _ _
  have e2 : C2 * Real.exp (c2 * ‖x‖) ≤ C2 * Real.exp (max c1 c2 * ‖x‖) := by
    gcongr
    · exact le_max_right _ _
  calc |f x + g x| ≤ |f x| + |g x| := abs_add_le _ _
    _ ≤ C1 * Real.exp (c1 * ‖x‖) + C2 * Real.exp (c2 * ‖x‖) := add_le_add (h1 x) (h2 x)
    _ ≤ (C1 + C2) * Real.exp (max c1 c2 * ‖x‖) := by linarith
