-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.fqOp_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_fqExch_hermitian
import Theorems.Thm_BookProof_FullQuadratic_fqOp_hermiteCore
import Theorems.Thm_BookProof_CarlemanSimplex_ladderQ_eq_zero
import Theorems.Thm_BookProof_HyperbolicQuadratic_hermiteMvLp_total
open BookProof.FullQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of the deficiency computation expensive
theorem solution (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (fqOp P Q S b b') z := by

  classical
  intro w hw
  set u : (Fin d →₀ ℕ) → ℂ := fun a => (inner ℂ (hermiteMvLp (d := d) a) w : ℂ) with hu
  have hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ ‖w‖ ^ 2 := fun F =>
    Orthonormal.sum_inner_products_le (𝕜 := ℂ) w (orthonormal_hermiteMvLp (d := d))
  have hM : ∀ i j : Fin d, (fun i j => (starRingEnd ℂ) (fqExch P Q S i j)) j i
      = (starRingEnd ℂ) ((fun i j => (starRingEnd ℂ) (fqExch P Q S i j)) i j) := by
    intro i j
    simp only [Complex.conj_conj]
    exact fqExch_hermitian P Q S j i
  have hrec : LadderRecQ u (fun _ => fqSymbol P Q) (foAmp b b') (fqAmp P Q S)
      (fun i j => (starRingEnd ℂ) (fqExch P Q S i j)) z := by
    intro a
    have h := hw (hermiteCore a)
    rw [fqOp_hermiteCore P Q S b b' a, inner_add_left, inner_add_left, inner_smul_left,
      Complex.conj_ofReal, sum_inner, sum_inner] at h
    rw [hermiteCore_coe] at h
    have hq : ∀ i : Fin d,
        (inner ℂ (∑ j, ((fqAmp P Q S i j * ((rcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (d := d) (a + pvec i j)
                + ((starRingEnd ℂ) (fqAmp P Q S i j) * ((lcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (d := d) (a - pvec i j)
                + (fqExch P Q S i j * ((rcm a i j : ℝ) : ℂ))
                    • hermiteMvLp (d := d) (shiftm a i j))) w : ℂ)
        = ∑ j, ((starRingEnd ℂ) (fqAmp P Q S i j) * ((rcp a i j : ℝ) : ℂ)
              * u (a + pvec i j)
            + fqAmp P Q S i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j)
            + (starRingEnd ℂ) (fqExch P Q S i j) * ((rcm a i j : ℝ) : ℂ)
              * u (shiftm a i j)) := by
      intro i
      rw [sum_inner]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [inner_add_left, inner_add_left, inner_smul_left, inner_smul_left, inner_smul_left]
      simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal, hu]
    have hf : ∀ i : Fin d,
        (inner ℂ (((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a + Finsupp.single i 1)
            + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a - Finsupp.single i 1))) w : ℂ)
        = (starRingEnd ℂ) (foAmp b b' i) * ((rc1 a i : ℝ) : ℂ) * u (a + Finsupp.single i 1)
          + foAmp b b' i * ((lc1 a i : ℝ) : ℂ) * u (a - Finsupp.single i 1) := by
      intro i
      rw [inner_add_left, inner_smul_left, inner_smul_left]
      simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal, hu, rc1, lc1]
    rw [Finset.sum_congr rfl (fun i _ => hq i), Finset.sum_congr rfl (fun i _ => hf i)] at h
    have hsplit : ∀ i : Fin d,
        ∑ j, ((starRingEnd ℂ) (fqAmp P Q S i j) * ((rcp a i j : ℝ) : ℂ) * u (a + pvec i j)
            + fqAmp P Q S i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j)
            + (starRingEnd ℂ) (fqExch P Q S i j) * ((rcm a i j : ℝ) : ℂ) * u (shiftm a i j))
        = ∑ j, ((starRingEnd ℂ) (fqAmp P Q S i j) * ((rcp a i j : ℝ) : ℂ) * u (a + pvec i j)
              + fqAmp P Q S i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j))
          + ∑ j, ((starRingEnd ℂ) (fqExch P Q S i j) * ((rcm a i j : ℝ) : ℂ)
              * u (shiftm a i j)) := by
      intro i
      rw [← Finset.sum_add_distrib]
    rw [Finset.sum_congr rfl (fun i _ => hsplit i), Finset.sum_add_distrib] at h
    linear_combination h
  have hzero : ∀ a, u a = 0 := ladderQ_eq_zero hz hbes hM hrec
  exact hermiteMvLp_total w fun a => hzero a
