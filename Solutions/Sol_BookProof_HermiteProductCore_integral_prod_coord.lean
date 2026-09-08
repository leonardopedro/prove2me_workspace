-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.integral_prod_coord
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f : Fin d → ℝ → ℂ) :
    ∫ x : Vd d, ∏ i, f i (x i) = ∏ i, ∫ t : ℝ, f i t := by

  rw [← ((PiLp.volume_preserving_toLp (Fin d)).integral_comp
      (MeasurableEquiv.toLp 2 (Fin d → ℝ)).measurableEmbedding
      (fun x : Vd d => ∏ i, f i (x i)))]
  exact MeasureTheory.integral_fintype_prod_eq_prod (fun i => f i)
