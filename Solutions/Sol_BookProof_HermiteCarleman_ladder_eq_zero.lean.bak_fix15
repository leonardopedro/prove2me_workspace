-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.ladder_eq_zero
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_mem_cube
import Theorems.Thm_BookProof_HermiteCarleman_flux_identity
import Theorems.Thm_BookProof_HermiteCarleman_flux_bound
import Theorems.Thm_BookProof_HermiteCarleman_faces_le
import Theorems.Thm_BookProof_HermiteCarleman_shifted_faces_le
import Theorems.Thm_BookProof_HermiteCarleman_not_summable_inv_sqrt
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
theorem solution {B : ℝ} (hz : z.im ≠ 0)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (hrec : LadderRec u lam amp z) : ∀ a, u a = 0 := by

  classical
  by_contra hcon
  push_neg at hcon
  obtain ⟨a₀, ha₀⟩ := hcon
  set A : ℕ → ℝ := fun N => ∑ i, ‖amp i‖ *
    ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2) with hAdef
  have hAnn : ∀ N, 0 ≤ A N := by
    intro N
    refine Finset.sum_nonneg fun i _ => ?_
    have hs : 0 ≤ ∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) :=
      Finset.sum_nonneg fun a _ => by positivity
    positivity
  have hApart : ∀ M, ∑ N ∈ Finset.range M, A N ≤ (∑ i, ‖amp i‖) * B := by
    intro M
    rw [hAdef, Finset.sum_comm, Finset.sum_mul]
    refine Finset.sum_le_sum fun i _ => ?_
    have h1 := faces_le hbes i M
    have h2 := shifted_faces_le hbes i M
    have hsplit : ∑ N ∈ Finset.range M,
          ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2) ≤ B := by
      have hpt : ∀ N : ℕ, (∑ a ∈ face d N i,
            (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2
          = ((∑ a ∈ face d N i, ‖u a‖ ^ 2)
              + ∑ a ∈ face d N i, ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2 := by
        intro N; rw [Finset.sum_add_distrib]
      simp_rw [hpt]
      rw [← Finset.sum_div, Finset.sum_add_distrib]
      linarith
    calc ∑ N ∈ Finset.range M, ‖amp i‖ *
          ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)
        = ‖amp i‖ * ∑ N ∈ Finset.range M,
            ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2) := by
          rw [Finset.mul_sum]
      _ ≤ ‖amp i‖ * B := mul_le_mul_of_nonneg_left hsplit (norm_nonneg _)
  have hsummable : Summable A := summable_of_sum_range_le hAnn hApart
  have hkey : ∀ N : ℕ, |z.im| * (∑ a ∈ cube d N, ‖u a‖ ^ 2) ≤ Real.sqrt ((N : ℝ) + 1) * A N := by
    intro N
    have hS : 0 ≤ ∑ a ∈ cube d N, ‖u a‖ ^ 2 := Finset.sum_nonneg fun a _ => by positivity
    have h1 : |z.im| * (∑ a ∈ cube d N, ‖u a‖ ^ 2)
        = |∑ i, (∑ a ∈ face d N i, rterm u amp i a).im| := by
      rw [← flux_identity hrec N, abs_mul, abs_of_nonneg hS]
    rw [h1]
    calc |∑ i, (∑ a ∈ face d N i, rterm u amp i a).im|
        ≤ ∑ i, |(∑ a ∈ face d N i, rterm u amp i a).im| := Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ i, Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ * ((∑ a ∈ face d N i,
            (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)) :=
          Finset.sum_le_sum fun i _ => flux_bound N i
      _ = Real.sqrt ((N : ℝ) + 1) * A N := by rw [hAdef, Finset.mul_sum]
  set N₀ : ℕ := Finset.univ.sup (fun i : Fin d => a₀ i) with hN₀
  have hlow : ∀ N : ℕ, N₀ ≤ N → ‖u a₀‖ ^ 2 ≤ ∑ a ∈ cube d N, ‖u a‖ ^ 2 := by
    intro N hN
    refine Finset.single_le_sum (f := fun a => ‖u a‖ ^ 2) (fun a _ => by positivity) ?_
    rw [mem_cube]
    intro i
    exact le_trans (Finset.le_sup (f := fun i : Fin d => a₀ i) (Finset.mem_univ i)) hN
  have hcpos : 0 < |z.im| * ‖u a₀‖ ^ 2 := by
    have h1 : 0 < |z.im| := abs_pos.mpr hz
    have h2 : 0 < ‖u a₀‖ ^ 2 := by
      have : 0 < ‖u a₀‖ := norm_pos_iff.mpr ha₀
      positivity
    positivity
  have hAlow : ∀ N : ℕ, N₀ ≤ N →
      (|z.im| * ‖u a₀‖ ^ 2) * (Real.sqrt ((N : ℝ) + 1))⁻¹ ≤ A N := by
    intro N hN
    have hsq : 0 < Real.sqrt ((N : ℝ) + 1) := Real.sqrt_pos.mpr (by positivity)
    have h1 := hkey N
    have h2 := hlow N hN
    have h3 : |z.im| * ‖u a₀‖ ^ 2 ≤ Real.sqrt ((N : ℝ) + 1) * A N := by
      have := mul_le_mul_of_nonneg_left h2 (abs_nonneg z.im)
      linarith
    rw [mul_inv_le_iff₀ hsq]
    linarith [h3]
  have hshift : Summable (fun N : ℕ => A (N + N₀)) := (summable_nat_add_iff N₀).mpr hsummable
  have hcomp : Summable (fun N : ℕ =>
      (|z.im| * ‖u a₀‖ ^ 2) * (Real.sqrt (((N + N₀ : ℕ) : ℝ) + 1))⁻¹) := by
    refine Summable.of_nonneg_of_le (fun N => by positivity) (fun N => ?_) hshift
    exact hAlow (N + N₀) (Nat.le_add_left _ _)
  have h4 : Summable (fun N : ℕ => (Real.sqrt (((N + N₀ : ℕ) : ℝ) + 1))⁻¹) := by
    have h5 := hcomp.mul_left (|z.im| * ‖u a₀‖ ^ 2)⁻¹
    refine h5.congr fun N => ?_
    field_simp
  exact not_summable_inv_sqrt ((summable_nat_add_iff N₀).mp h4)
