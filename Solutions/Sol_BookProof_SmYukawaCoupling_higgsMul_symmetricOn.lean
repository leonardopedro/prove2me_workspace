-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.higgsMul_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_X
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
theorem solution (a : Fin 4) :
    SymmetricOn (polyGaussCore (d := 163)) (higgsMul a) := (coreRepPoly 163).symmetricOn_op (mulOp_polySym (realCoeff_X _))
