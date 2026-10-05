-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.fullDom_dense
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
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
    Dense ((fullDom n : Submodule ℂ (FermiFock n)) : Set (FermiFock n)) := by

  simp
