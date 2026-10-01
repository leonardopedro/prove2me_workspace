-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.le_relBound_of_sq_le
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

set_option maxHeartbeats 1000000 in
l_eq_mul_div, le_div_iff₀ hc0]
  nlinarith [mul_le_mul_of_nonneg_left h1 hc0.le, h2, h3, h4]

theorem solution {t A B c0 e : ℝ} (hA : 0 ≤ A) (hB : 0 ≤ B)
    (hc0 : :=
   0 < c0) (he : 0 < e) (h : t ^ 2 ≤ (4 / c0) * (B * A)) :
      t ≤ e * A + (2 / (c0 * e)) * B := by
    have hrhs : 0 ≤ e * A + (2 / (c0 * e)) * B := by positivity
    have hsq : t ^ 2 ≤ (e * A + (2 / (c0 * e)) * B) ^ 2 := by
      have hcross : (4 / c0) * (B * A) ≤ 2 * (e * A) * ((2 / (c0 * e)) * B) := by
        have : 2 * (e * A) * ((2 / (c0 * e)) * B) = (4 / c0) * (B * A) := by
          field_simp
          ring
        rw [this]
