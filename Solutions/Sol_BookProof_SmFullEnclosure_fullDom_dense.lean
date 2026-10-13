-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.fullDom_dense
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmFullEnclosure




open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa
open BookProof.SmCar
open BookProof.SmDiracYukawa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    Dense ((fullDom n : Submodule ℂ (FermiFock n)) : Set (FermiFock n)) := by

  simp
