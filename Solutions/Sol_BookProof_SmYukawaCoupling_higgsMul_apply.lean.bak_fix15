-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.higgsMul_apply
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 4) (p : MvPolynomial (Fin 163) ℂ) :
    higgsMul a ((coreRepPoly 163).equiv p) = pgLp (X (smPhi a) * p) := by

  simp only [higgsMul, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [CoreRep.coe_op, LinearEquiv.symm_apply_apply]
  rfl
