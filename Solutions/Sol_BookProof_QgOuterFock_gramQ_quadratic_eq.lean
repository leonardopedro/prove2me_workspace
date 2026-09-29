-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.gramQ_quadratic_eq
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
import Theorems.Thm_BookProof_QgOuterFock_triple_swap'
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
theorem solution {R : Type*} [Fintype R] (v : R → Fin D → ℝ) :
    ∑ i : Fin D, ∑ j : Fin D, ((gramQ v i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin D) ℂ) * X j)
      = ((1 / 2 : ℝ) : ℂ) • ∑ r : R, linForm (v r) * linForm (v r) := by

  have hL : ∑ i : Fin D, ∑ j : Fin D, ((gramQ v i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin D) ℂ) * X j)
      = ∑ i : Fin D, ∑ j : Fin D, ∑ r : R,
          (((1 / 2 : ℝ) : ℂ) * ((v r i : ℝ) : ℂ) * ((v r j : ℝ) : ℂ))
            • ((X i : MvPolynomial (Fin D) ℂ) * X j) := by
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    have hc : ((gramQ v i j : ℝ) : ℂ)
        = ∑ r : R, (((1 / 2 : ℝ) : ℂ) * ((v r i : ℝ) : ℂ) * ((v r j : ℝ) : ℂ)) := by
      rw [gramQ]
      push_cast
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun r _ => by ring
    rw [hc, Finset.sum_smul]
  have hR : ((1 / 2 : ℝ) : ℂ) • ∑ r : R, linForm (v r) * linForm (v r)
      = ∑ r : R, ∑ i : Fin D, ∑ j : Fin D,
          (((1 / 2 : ℝ) : ℂ) * ((v r i : ℝ) : ℂ) * ((v r j : ℝ) : ℂ))
            • ((X i : MvPolynomial (Fin D) ℂ) * X j) := by
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun r _ => ?_
    rw [linForm, Finset.sum_mul_sum, Finset.smul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_mul_smul_comm, smul_smul]
    congr 1
    ring
  rw [hL, hR, triple_swap']
