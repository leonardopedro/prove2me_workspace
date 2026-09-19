-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.sqSumPoly_eq_fqPoly
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
import Theorems.Thm_BookProof_QgOuterFock_gramQ_quadratic_eq
import Theorems.Thm_BookProof_QgOuterFock_weylProd_self'
import Theorems.Thm_BookProof_HermiteRelative_momPoly_eq_ymMomOp
open BookProof.QgOuterFock




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.QgHermiteOscillator
open BookProof.DirectSumEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {R : Type*} [Fintype R] (kappa : Fin D → ℝ) (v : R → Fin D → ℝ) :
    sqSumPoly kappa v = fqPoly (diagP kappa) (gramQ v) 0 0 0 := by

  refine LinearMap.ext fun p => ?_
  have hfo : foPoly (d := D) 0 0 p = 0 := by simp [foPoly]
  have hmom : ∑ i : Fin D, ∑ j : Fin D,
      ((diagP kappa i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p
        = ∑ j : Fin D, ((kappa j / 2 : ℝ) : ℂ)
            • YangMillsHermite.momOp j (YangMillsHermite.momOp j p) := by
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_eq_single i]
    · rw [diagP, if_pos rfl, weylProd_self', momPoly_eq_ymMomOp]
    · intro b _ hb
      simp [diagP, Ne.symm hb]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  have hw : ∀ i j : Fin D, weylProd (mulXPoly i) (mulXPoly j) p
      = ((X i : MvPolynomial (Fin D) ℂ) * X j) * p := by
    intro i j
    simp only [weylProd, LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply,
      mulXPoly_apply]
    rw [show (X i : MvPolynomial (Fin D) ℂ) * (X j * p) = (X i * X j) * p by ring,
      show (X j : MvPolynomial (Fin D) ℂ) * (X i * p) = (X i * X j) * p by ring,
      ← two_smul ℂ ((X i * X j : MvPolynomial (Fin D) ℂ) * p), smul_smul]
    norm_num
  have hmul : ∑ i : Fin D, ∑ j : Fin D,
      ((gramQ v i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = (((1 / 2 : ℝ) : ℂ) • ∑ r : R, linForm (v r) * linForm (v r)) * p := by
    calc ∑ i : Fin D, ∑ j : Fin D,
            ((gramQ v i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = (∑ i : Fin D, ∑ j : Fin D,
            ((gramQ v i j : ℝ) : ℂ) • ((X i : MvPolynomial (Fin D) ℂ) * X j)) * p := by
          rw [Finset.sum_mul]
          refine Finset.sum_congr rfl fun i _ => ?_
          rw [Finset.sum_mul]
          refine Finset.sum_congr rfl fun j _ => ?_
          rw [hw i j, smul_mul_assoc]
      _ = _ := by rw [gramQ_quadratic_eq]
  have hfq : fqPoly (diagP kappa) (gramQ v) 0 0 0 p
      = (∑ i : Fin D, ∑ j : Fin D,
          ((diagP kappa i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p)
        + ∑ i : Fin D, ∑ j : Fin D,
            ((gramQ v i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p := by
    rw [fqPoly, fqQuadPoly]
    simp only [LinearMap.add_apply, LinearMap.sum_apply, LinearMap.smul_apply, Pi.zero_apply,
      Complex.ofReal_zero, zero_smul, add_zero, hfo]
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib
  have hlhs : sqSumPoly kappa v p
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j : Fin D, ((kappa j : ℝ) : ℂ)
              • YangMillsHermite.momOp j (YangMillsHermite.momOp j p))
            + ∑ r : R, linForm (v r) * (linForm (v r) * p)) := by
    simp [sqSumPoly]
  rw [hlhs, hfq, hmom, hmul, smul_add]
  congr 1
  · rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_smul]
    congr 1
    push_cast
    ring
  · rw [Finset.smul_sum, smul_mul_assoc, Finset.sum_mul, Finset.smul_sum]
    refine Finset.sum_congr rfl fun r _ => ?_
    rw [mul_assoc]
