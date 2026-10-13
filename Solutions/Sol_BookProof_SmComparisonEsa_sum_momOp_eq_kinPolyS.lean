-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.sum_momOp_eq_kinPolyS
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_momOp_momOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QgHermiteFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin 163) ℂ) :
    (∑ m : Fin 40, momOp (smCoord m) (momOp (smCoord m) p)) = kinPolyS smS p := by

  have h : ∀ m : Fin 40, momOp (smCoord m) (momOp (smCoord m) p)
      = -coreD (smCoord m) (coreD (smCoord m) p) := fun m => momOp_momOp _ p
  rw [Finset.sum_congr rfl fun m _ => h m, kinPolyS, smS,
    Finset.sum_image (fun a _ b _ hab => smCoord_injective hab)]
  simp only [Finset.sum_neg_distrib]
