-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.smField_wall_apply
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
theorem solution (P : SmParams) (p : MvPolynomial (Fin 163) ℂ) :
    ((smField P wallIdx ((coreRepPoly 163).equiv p) : polyGaussCore (d := 163)) : L2d 163)
      = pgLp (smWall P (id : Fin 163 → Fin 163) * p) := by

  rw [smField, CoreRep.coe_op, LinearEquiv.symm_apply_apply, wallIdx, Equiv.symm_apply_apply]
  rfl
