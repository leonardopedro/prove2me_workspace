-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.smFullCore_dense
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Theorems.Thm_BookProof_SmFullEnclosure_fullDom_dense
import Theorems.Thm_BookProof_TensorSumEsa_dense_cpairDom
open BookProof.SmFullEnclosure




open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    Dense ((smFullCore n : Submodule ℂ (smFullSpace n).carrier) : Set (smFullSpace n).carrier) := dense_cpairDom (L2dSpace 163) (smFermiSpace n) _ _ polyGaussCore_dense (fullDom_dense n)
