-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.gaussInt_kinPolyS
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_sum
import Theorems.Thm_BookProof_QgHermiteFriedrichs_gaussInt_coreD
import Theorems.Thm_BookProof_QgHermiteFriedrichs_gaussInt_neg
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (p q : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly p * kinPolyS S q)
      = ∑ j ∈ S, gaussInt (cpoly (coreD j p) * coreD j q) := by

  have hmul : cpoly p * kinPolyS S q = -∑ j ∈ S, cpoly p * coreD j (coreD j q) := by
    simp only [kinPolyS, Finset.mul_sum, mul_neg]
  rw [hmul, gaussInt_neg, gaussInt_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [gaussInt_coreD j p (coreD j q)]
