-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.momOp_momOp
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_YangMillsHermite_momOp_apply
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
theorem solution (j : Fin 163) (p : MvPolynomial (Fin 163) ℂ) :
    momOp j (momOp j p) = -coreD j (coreD j p) := by

  have hstep : ∀ r : MvPolynomial (Fin 163) ℂ, momOp j r = (-Complex.I) • coreD j r := by
    intro r
    rw [momOp_apply, coreD]
    congr 1
    congr 1
    rw [MvPolynomial.smul_eq_C_mul]
    norm_num
  rw [hstep, hstep, coreD_smul, smul_smul]
  have hII : (-Complex.I) * (-Complex.I) = -1 := by
    simp [Complex.I_mul_I]
  rw [hII]
  module
