-- Generated from ChapterSmYukawaCoupling.lean — theorem BookProof.SmYukawaCoupling.smYukawa_dGamma_esa
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.DirectSumEsa
open BookProof.SmHamiltonian
open BookProof.SmYukawaCoupling



open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

theorem BookProof.SmYukawaCoupling.smYukawa_dGamma_esa (P : SmParams) (hlam : 0 < P.lam) {n : ℕ}
    {hD : Matrix (Fin n) (Fin n) ℂ} (M : Matrix (Fin n) (Fin n) ℂ)
    (hh : hD.conjTranspose = hD) :
    EssentiallySelfAdjointOn
      (dsCore (fun k : ℕ => fockSectorCore (smFullSpace n) (smFullCore n) (smFullCore n) k))
      (dGammaCoreOp (smFullSpace n) (smFullCore n) (smYukawaFullHam P hD M) (smFullCore n)) := by sorry
