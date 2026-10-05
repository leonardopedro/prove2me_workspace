-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.quadPolyMat_rotPoly
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_mulXPoly
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_momPoly
import Theorems.Thm_BookProof_QuadraticRotation_quadPolyMat_apply
import Theorems.Thm_BookProof_QuadraticRotation_quadPoly_apply'
open BookProof.QuadraticRotation




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (c : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) :
    quadPolyMat (rotConj O c) (rotPoly O p) = rotPoly O (quadPoly c p) := by

  have hmom : ∀ i : Fin d, rotPoly O (momPoly i (momPoly i p))
      = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • momPoly k (momPoly l (rotPoly O p)) := by
    intro i
    rw [rotPoly_momPoly hO i (momPoly i p), rotPoly_momPoly hO i p]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [map_sum, Finset.smul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [map_smul, smul_smul]
    congr 1
    push_cast
    ring
  have hx : ∀ i : Fin d, rotPoly O (X i * (X i * p))
      = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • (X k * (X l * rotPoly O p)) := by
    intro i
    have h1 := rotPoly_mulXPoly O i (X i * p)
    have h2 := rotPoly_mulXPoly O i p
    simp only [mulXPoly_apply] at h1 h2
    rw [h1, h2]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum, Finset.smul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [mul_smul_comm, smul_smul]
    congr 1
    push_cast
    ring
  have hboth : ∀ i : Fin d, rotPoly O (((c i : ℝ) : ℂ) •
      (momPoly i (momPoly i p) + (1/4 : ℂ) • (X i * (X i * p))))
      = ∑ k, ∑ l, ((O k i * c i * O l i : ℝ) : ℂ) •
          (momPoly k (momPoly l (rotPoly O p))
            + (1/4 : ℂ) • (X k * (X l * rotPoly O p))) := by
    intro i
    have hquarter : (1/4 : ℂ) •
        (∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • (X k * (X l * rotPoly O p)))
        = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) •
            ((1/4 : ℂ) • (X k * (X l * rotPoly O p))) := by
      simp only [Finset.smul_sum]
      exact Finset.sum_congr rfl fun k _ =>
        Finset.sum_congr rfl fun l _ => smul_comm _ _ _
    have hcomb :
        (∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • momPoly k (momPoly l (rotPoly O p)))
          + (∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) •
              ((1/4 : ℂ) • (X k * (X l * rotPoly O p))))
        = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) •
            (momPoly k (momPoly l (rotPoly O p))
              + (1/4 : ℂ) • (X k * (X l * rotPoly O p))) := by
      rw [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun l _ => (smul_add _ _ _).symm
    rw [map_smul, map_add, map_smul, hmom i, hx i, hquarter, hcomb, Finset.smul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [smul_smul]
    congr 1
    push_cast
    ring
  have hswap : ∀ f : Fin d → Fin d → Fin d → MvPolynomial (Fin d) ℂ,
      ∑ i, ∑ k, ∑ l, f i k l = ∑ k, ∑ l, ∑ i, f i k l := by
    intro f
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
  rw [quadPoly_apply', map_sum, Finset.sum_congr rfl fun i _ => hboth i, hswap,
    quadPolyMat_apply]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [← Finset.sum_smul]
  congr 1
  rw [rotConj]
  push_cast
  ring
