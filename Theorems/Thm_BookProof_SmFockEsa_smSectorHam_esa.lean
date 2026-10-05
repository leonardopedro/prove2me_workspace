-- Generated from ChapterSmFockEsa.lean — theorem BookProof.SmFockEsa.smSectorHam_esa
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterSmOuterFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmFockEsa



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmOuterFock
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.TensorCore BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.SmFockEsa.smSectorHam_esa (P : SmParams) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 163)) (smSectorHam P n) := by sorry
