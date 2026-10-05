-- Generated from ChapterSmFullEnclosure.lean — theorem BookProof.SmFullEnclosure.smFullHam_fermi_block
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
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmCar
open BookProof.SmDiracYukawa
open BookProof.SmFullEnclosure



open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.SmFullEnclosure.smFullHam_fermi_block {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    onFull (smFermiHam hD M z) = onFull (smDirac hD + smYukawa M z) := by sorry
