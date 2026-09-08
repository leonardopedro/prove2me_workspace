-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.gaussInt_anticommutator
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_coreD_harmPoly_mul
import Theorems.Thm_BookProof_HermiteQuadraticEsa_cpoly_add
import Theorems.Thm_BookProof_HermiteQuadraticEsa_cpoly_harmPoly
import Theorems.Thm_BookProof_HermiteQuadraticEsa_gaussInt_cross
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly (kinPoly p) * (harmPoly * p))
        + gaussInt (cpoly (harmPoly * p) * kinPoly p)
      = 2 * (∑ j : Fin d, gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)))
        - ((d : ℂ) / 2) * gaussInt (cpoly p * p) := by

  have hhalf : (starRingEnd ℂ) (1 / 2 : ℂ) = 1 / 2 := by norm_num [Complex.ext_iff]
  have hT1 : ∀ j : Fin d, gaussInt (cpoly (coreD j p) * coreD j (harmPoly * p))
      = (1 / 2 : ℂ) * gaussInt (cpoly (coreD j p) * (X j * p))
        + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)) := by
    intro j
    rw [coreD_harmPoly_mul, mul_add, gaussInt_add]
    congr 1
    have hsm : cpoly (coreD j p) * (C (1 / 2 : ℂ) * (X j * p))
        = (1 / 2 : ℂ) • (cpoly (coreD j p) * (X j * p)) := by
      rw [smul_eq_C_mul]; ring
    rw [hsm, gaussInt_smul]
  have hT2 : ∀ j : Fin d, gaussInt (cpoly (coreD j (harmPoly * p)) * coreD j p)
      = (1 / 2 : ℂ) * gaussInt (cpoly p * (X j * coreD j p))
        + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)) := by
    intro j
    rw [coreD_harmPoly_mul, cpoly_add]
    simp only [cpoly_mul, cpoly_C, cpoly_X, cpoly_harmPoly, hhalf]
    rw [add_mul, gaussInt_add]
    congr 1
    · have hsm : C (1 / 2 : ℂ) * (X j * cpoly p) * coreD j p
          = (1 / 2 : ℂ) • (cpoly p * (X j * coreD j p)) := by
        rw [smul_eq_C_mul]; ring
      rw [hsm, gaussInt_smul]
    · congr 1
      ring
  rw [gaussInt_kinPoly_left p (harmPoly * p), gaussInt_kinPoly (harmPoly * p) p]
  simp only [hT1, hT2]
  rw [← Finset.sum_add_distrib]
  have hstep : ∀ j : Fin d,
      ((1 / 2 : ℂ) * gaussInt (cpoly (coreD j p) * (X j * p))
          + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)))
        + ((1 / 2 : ℂ) * gaussInt (cpoly p * (X j * coreD j p))
          + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)))
      = 2 * gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p))
        - (1 / 2 : ℂ) * gaussInt (cpoly p * p) := by
    intro j
    have h := gaussInt_cross j p
    linear_combination (1 / 2 : ℂ) * h
  simp only [hstep]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  ring
