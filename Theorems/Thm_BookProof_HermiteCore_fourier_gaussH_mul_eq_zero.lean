-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.fourier_gaussH_mul_eq_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

w : ∫ x : ℝ, g x • v x = ∫ x : ℝ, v x * (psi : ℝ → ℂ) x := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp [hpsi, Complex.real_smul]
    exact mul_comm _ _
  rw [hrw, ← hkey]

theorem BookProof.HermiteCore.fourier_gaussH_mul_eq_zero (z : ℂ) :
    HasSum (fun k : ℕ => z ^ k / (k.factorial : ℂ)) (Complex.exp z) := by
  sim := by sorry
