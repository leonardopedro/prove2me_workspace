-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.integral_eq_two_smul_of_even
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E) (h : ∀ x, f (-x) = f x) (hf : Integrable f) :
    ∫ x : ℝ, f x = (2 : ℝ) • ∫ x in Ioi (0 : ℝ), f x := by

  have hsplit := intervalIntegral.integral_Iic_add_Ioi
    (hf.integrableOn (s := Iic 0)) (hf.integrableOn (s := Ioi 0))
  have key : ∫ x in Iic (0 : ℝ), f x = ∫ x in Ioi (0 : ℝ), f x := by
    rw [← neg_zero, ← integral_comp_neg_Ioi]
    simp_rw [h]; simp
  rw [← hsplit, key, two_smul]
