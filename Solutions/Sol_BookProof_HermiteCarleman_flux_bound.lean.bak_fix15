-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.flux_bound
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_mem_face
open BookProof.HermiteCarleman




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ} {lam : (Fin d →₀ ℕ) → ℝ} {amp : Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (i : Fin d) :
    |(∑ a ∈ face d N i, rterm u amp i a).im|
      ≤ Real.sqrt ((N : ℝ) + 1) *
        (‖amp i‖ * ((∑ a ∈ face d N i,
          (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)) := by

  classical
  have h1 : |(∑ a ∈ face d N i, rterm u amp i a).im| ≤ ‖∑ a ∈ face d N i, rterm u amp i a‖ :=
    Complex.abs_im_le_norm _
  have h2 : ‖∑ a ∈ face d N i, rterm u amp i a‖ ≤ ∑ a ∈ face d N i, ‖rterm u amp i a‖ :=
    norm_sum_le _ _
  have h3 : ∀ a ∈ face d N i, ‖rterm u amp i a‖
      ≤ Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ *
          ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2)) := by
    intro a ha
    rw [mem_face] at ha
    have hai : ((a i : ℝ)) = (N : ℝ) := by rw [ha.2]
    have hnorm : ‖rterm u amp i a‖
        = ‖amp i‖ * Real.sqrt ((N : ℝ) + 1) * ‖u a‖ * ‖u (a + Finsupp.single i 1)‖ := by
      rw [rterm, hai]
      simp [abs_of_nonneg (Real.sqrt_nonneg ((N : ℝ) + 1))]
    have hprod : ‖u a‖ * ‖u (a + Finsupp.single i 1)‖
        ≤ (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2 := by
      nlinarith [sq_nonneg (‖u a‖ - ‖u (a + Finsupp.single i 1)‖)]
    have hstep := mul_le_mul_of_nonneg_left hprod
      (mul_nonneg (norm_nonneg (amp i)) (Real.sqrt_nonneg ((N : ℝ) + 1)))
    rw [hnorm]
    calc ‖amp i‖ * Real.sqrt ((N : ℝ) + 1) * ‖u a‖ * ‖u (a + Finsupp.single i 1)‖
        = (‖amp i‖ * Real.sqrt ((N : ℝ) + 1)) * (‖u a‖ * ‖u (a + Finsupp.single i 1)‖) := by
          ring
      _ ≤ (‖amp i‖ * Real.sqrt ((N : ℝ) + 1))
            * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2) := hstep
      _ = Real.sqrt ((N : ℝ) + 1)
            * (‖amp i‖ * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2)) := by ring
  calc |(∑ a ∈ face d N i, rterm u amp i a).im|
      ≤ ∑ a ∈ face d N i, ‖rterm u amp i a‖ := h1.trans h2
    _ ≤ ∑ a ∈ face d N i, Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ *
          ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2)) := Finset.sum_le_sum h3
    _ = Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ * ((∑ a ∈ face d N i,
          (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)) := by
        rw [← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_div]
