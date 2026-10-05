-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.rotPoly_foPoly
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_momPoly
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_mulXPoly
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (b b' : Fin d → ℝ)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (foPoly b b' p) = foPoly (rotVec O b) (rotVec O b') (rotPoly O p) := by

  have hfo : ∀ (β β' : Fin d → ℝ) (q : MvPolynomial (Fin d) ℂ),
      foPoly β β' q
        = ∑ i, (((β i : ℝ) : ℂ) • mulXPoly i q + ((β' i : ℝ) : ℂ) • momPoly i q) := by
    intro β β' q
    simp [foPoly, LinearMap.sum_apply]
  have step : ∀ i : Fin d,
      rotPoly O (((b i : ℝ) : ℂ) • mulXPoly i p + ((b' i : ℝ) : ℂ) • momPoly i p)
        = ∑ k, (((O k i * b i : ℝ) : ℂ) • mulXPoly k (rotPoly O p)
            + ((O k i * b' i : ℝ) : ℂ) • momPoly k (rotPoly O p)) := by
    intro i
    rw [map_add, map_smul, map_smul, rotPoly_mulXPoly, rotPoly_momPoly hO, Finset.smul_sum,
      Finset.smul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [smul_smul, smul_smul]
    push_cast
    ring_nf
  rw [hfo b b' p, map_sum, Finset.sum_congr rfl fun i _ => step i, Finset.sum_comm,
    hfo (rotVec O b) (rotVec O b') (rotPoly O p)]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.sum_add_distrib, ← Finset.sum_smul, ← Finset.sum_smul]
  congr 1 <;>
    · congr 1
      rw [rotVec]
      push_cast
      ring
