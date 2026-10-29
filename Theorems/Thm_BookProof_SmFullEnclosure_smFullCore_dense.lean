-- Generated from ChapterSmFullEnclosure.lean — theorem BookProof.SmFullEnclosure.smFullCore_dense
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.HermiteProductCore
open BookProof.SmDiracYukawa



open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore

noncomputable section

theorem BookProof.SmFullEnclosure.smFullCore_dense (n : ℕ) :
    Dense ((smFullCore n : Submodule ℂ (smFullSpace n).carrier) : Set (smFullSpace n).carrier) := by sorry
