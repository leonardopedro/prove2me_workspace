-- Generated from ChapterSmFullEnclosure.lean — theorem BookProof.SmFullEnclosure.smFull_dGamma_esa
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.DirectSumEsa
open BookProof.SmHamiltonian
open BookProof.SmFullEnclosure



open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.SmFullEnclosure.smFull_dGamma_esa (P : SmParams) {n : ℕ} {hD : Matrix (Fin n) (Fin n) ℂ}
    (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) (hh : hD.conjTranspose = hD) :
    EssentiallySelfAdjointOn
      (dsCore (fun k : ℕ => fockSectorCore (smFullSpace n) (smFullCore n) (smFullCore n) k))
      (dGammaCoreOp (smFullSpace n) (smFullCore n) (smFullHam P hD M z) (smFullCore n)) := by sorry
