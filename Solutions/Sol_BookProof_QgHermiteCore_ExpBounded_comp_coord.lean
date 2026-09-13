-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.ExpBounded.comp_coord
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_nonneg_const
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]





































open BookProof.HermiteProductCore

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {f : ℝ → ℝ} (hf : ExpBounded f) (i : Fin d) :
    ExpBounded (fun x : Vd d => f (x i)) := by

  obtain ⟨C, c, hc, h⟩ := hf
  have hC : 0 ≤ C := ExpBounded.nonneg_const h
  refine ⟨C, c, hc, fun x => ?_⟩
  have hle : ‖x i‖ ≤ ‖x‖ := PiLp.norm_apply_le x i
  calc |f (x i)| ≤ C * Real.exp (c * ‖x i‖) := h (x i)
    _ ≤ C * Real.exp (c * ‖x‖) := by gcongr
