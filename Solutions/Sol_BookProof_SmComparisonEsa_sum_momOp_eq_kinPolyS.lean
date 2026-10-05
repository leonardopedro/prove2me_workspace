-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.sum_momOp_eq_kinPolyS
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_momOp_momOp
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin 163) ℂ) :
    (∑ m : Fin 40, momOp (smCoord m) (momOp (smCoord m) p)) = kinPolyS smS p := by

  have h : ∀ m : Fin 40, momOp (smCoord m) (momOp (smCoord m) p)
      = -coreD (smCoord m) (coreD (smCoord m) p) := fun m => momOp_momOp _ p
  rw [Finset.sum_congr rfl fun m _ => h m, kinPolyS, smS,
    Finset.sum_image (fun a _ b _ hab => smCoord_injective hab)]
  simp only [Finset.sum_neg_distrib]
