-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.flux_identity
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_sum_cube_split
import Theorems.Thm_BookProof_HermiteCarleman_sum_lterm
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
theorem solution (hrec : LadderRec u lam amp z) (N : ℕ) :
    z.im * (∑ a ∈ cube d N, ‖u a‖ ^ 2)
      = ∑ i, (∑ a ∈ face d N i, rterm u amp i a).im := by

  classical
  have hcm : ∀ w : ℂ, (starRingEnd ℂ) w * w = ((‖w‖ ^ 2 : ℝ) : ℂ) := by
    intro w; rw [Complex.conj_mul']; norm_cast
  have hpt : ∀ a : Fin d →₀ ℕ, (starRingEnd ℂ) (u a) * (z * u a)
      = ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
        + ∑ i, (rterm u amp i a + lterm u amp i a) := by
    intro a
    rw [← hrec a, mul_add, Finset.mul_sum]
    congr 1
    · rw [← hcm (u a)]; ring
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [rterm, lterm]; ring
  have hL : ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
      = z * ((∑ a ∈ cube d N, ‖u a‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.ofReal_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← hcm (u a)]; ring
  have hR : ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
      = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
        + ∑ i, ((∑ a ∈ inn d N i, rterm u amp i a)
                + (∑ a ∈ face d N i, rterm u amp i a)
                + (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a)) := by
    calc ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
        = ∑ a ∈ cube d N, (((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
            + ∑ i, (rterm u amp i a + lterm u amp i a)) :=
          Finset.sum_congr rfl fun a _ => hpt a
      _ = (∑ a ∈ cube d N, ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ))
            + ∑ a ∈ cube d N, ∑ i, (rterm u amp i a + lterm u amp i a) := Finset.sum_add_distrib
      _ = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
            + ∑ i, ∑ a ∈ cube d N, (rterm u amp i a + lterm u amp i a) := by
          rw [Finset.sum_comm]; push_cast; ring_nf
      _ = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
            + ∑ i, ((∑ a ∈ inn d N i, rterm u amp i a)
                + (∑ a ∈ face d N i, rterm u amp i a)
                + (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a)) := by
          congr 1
          refine Finset.sum_congr rfl fun i _ => ?_
          rw [Finset.sum_add_distrib, sum_cube_split d N i (rterm u amp i), sum_lterm N i]
  have hEq := hL.symm.trans hR
  have hLim : (z * ((∑ a ∈ cube d N, ‖u a‖ ^ 2 : ℝ) : ℂ)).im
      = z.im * (∑ a ∈ cube d N, ‖u a‖ ^ 2) := by
    rw [Complex.mul_im, Complex.ofReal_im, Complex.ofReal_re, mul_zero, zero_add]
  have hRim : (((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
        + ∑ i, ((∑ a ∈ inn d N i, rterm u amp i a)
                + (∑ a ∈ face d N i, rterm u amp i a)
                + (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a))).im
      = ∑ i, (∑ a ∈ face d N i, rterm u amp i a).im := by
    rw [Complex.add_im, Complex.ofReal_im, zero_add, Complex.im_sum]
    exact Finset.sum_congr rfl fun x _ => by simp [Complex.add_im]
  rw [← hLim, hEq, hRim]
