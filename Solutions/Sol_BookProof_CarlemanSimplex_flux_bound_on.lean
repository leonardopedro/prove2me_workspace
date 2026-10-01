-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.flux_bound_on
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {w : ℂ} {rc : (Fin d →₀ ℕ) → ℝ} (F : Finset (Fin d →₀ ℕ))
    (P : Fin d →₀ ℕ) {Cn : ℝ} (hC : ∀ a ∈ F, |rc a| ≤ Cn) :
    |(∑ a ∈ F, rtermP u w rc P a).im|
      ≤ Cn * (‖w‖ * ((∑ a ∈ F, (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2)) / 2)) := by

  classical
  have h1 : |(∑ a ∈ F, rtermP u w rc P a).im| ≤ ‖∑ a ∈ F, rtermP u w rc P a‖ :=
    Complex.abs_im_le_norm _
  have h2 : ‖∑ a ∈ F, rtermP u w rc P a‖ ≤ ∑ a ∈ F, ‖rtermP u w rc P a‖ := norm_sum_le _ _
  have h3 : ∀ a ∈ F, ‖rtermP u w rc P a‖
      ≤ Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2)) := by
    intro a ha
    have hnorm : ‖rtermP u w rc P a‖ = ‖w‖ * |rc a| * ‖u a‖ * ‖u (a + P)‖ := by
      rw [rtermP]
      simp [Complex.norm_real]
    have hprod : ‖u a‖ * ‖u (a + P)‖ ≤ (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2 := by
      nlinarith [sq_nonneg (‖u a‖ - ‖u (a + P)‖)]
    have hb1 : ‖w‖ * |rc a| ≤ ‖w‖ * Cn := mul_le_mul_of_nonneg_left (hC a ha) (norm_nonneg w)
    have hCn : 0 ≤ Cn := le_trans (abs_nonneg _) (hC a ha)
    rw [hnorm]
    calc ‖w‖ * |rc a| * ‖u a‖ * ‖u (a + P)‖
        = (‖w‖ * |rc a|) * (‖u a‖ * ‖u (a + P)‖) := by ring
      _ ≤ (‖w‖ * Cn) * (‖u a‖ * ‖u (a + P)‖) := by
          refine mul_le_mul_of_nonneg_right hb1 ?_
          positivity
      _ ≤ (‖w‖ * Cn) * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2) := by
          refine mul_le_mul_of_nonneg_left hprod ?_
          positivity
      _ = Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2)) := by ring
  calc |(∑ a ∈ F, rtermP u w rc P a).im|
      ≤ ∑ a ∈ F, ‖rtermP u w rc P a‖ := h1.trans h2
    _ ≤ ∑ a ∈ F, Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2)) := Finset.sum_le_sum h3
    _ = Cn * (‖w‖ * ((∑ a ∈ F, (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2)) / 2)) := by
        rw [← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_div]
