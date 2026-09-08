-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.ExpBounded.mul
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
    ExpBounded (fun x => f x * g x) := by

  obtain ⟨C1, c1, hc1, h1⟩ := hf
  obtain ⟨C2, c2, hc2, h2⟩ := hg
  have hC1 : 0 ≤ C1 := ExpBounded.nonneg_const h1
  refine ⟨C1 * C2, c1 + c2, by linarith, fun x => ?_⟩
  have hexp : Real.exp (c1 * ‖x‖) * Real.exp (c2 * ‖x‖) = Real.exp ((c1 + c2) * ‖x‖) := by
    rw [← Real.exp_add]
    congr 1
    ring
  calc |f x * g x| = |f x| * |g x| := abs_mul _ _
    _ ≤ (C1 * Real.exp (c1 * ‖x‖)) * (C2 * Real.exp (c2 * ‖x‖)) := by
        refine mul_le_mul (h1 x) (h2 x) (abs_nonneg _) (by positivity)
    _ = C1 * C2 * (Real.exp (c1 * ‖x‖) * Real.exp (c2 * ‖x‖)) := by ring
    _ = C1 * C2 * Real.exp ((c1 + c2) * ‖x‖) := by rw [hexp]
