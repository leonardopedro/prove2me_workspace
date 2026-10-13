-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.higgsMul_apply
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.SmOneParticle
open BookProof.YangMillsHermite

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 4) (p : MvPolynomial (Fin 163) ℂ) :
    higgsMul a ((coreRepPoly 163).equiv p) = pgLp (X (smPhi a) * p) := by

  simp only [higgsMul, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [CoreRep.coe_op, LinearEquiv.symm_apply_apply]
  rfl
