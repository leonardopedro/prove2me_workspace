-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.gaussInt_kinPolyS_left
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_coreD
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_neg
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_sum
import Theorems.Thm_BookProof_QgHermiteFriedrichs_gaussInt_coreD_raw
import Theorems.Thm_BookProof_QgHermiteFriedrichs_gaussInt_neg
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (p q : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly (kinPolyS S p) * q)
      = ∑ j ∈ S, gaussInt (cpoly (coreD j p) * coreD j q) := by

  have hcp : cpoly (kinPolyS S p) = kinPolyS S (cpoly p) := by
    simp only [kinPolyS, cpoly_neg, cpoly_sum, cpoly_coreD]
  have hmul : cpoly (kinPolyS S p) * q = -∑ j ∈ S, coreD j (coreD j (cpoly p)) * q := by
    rw [hcp]
    simp only [kinPolyS, Finset.sum_mul, neg_mul]
  rw [hmul, gaussInt_neg, gaussInt_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [gaussInt_coreD_raw j (coreD j (cpoly p)) q, cpoly_coreD, neg_neg]
