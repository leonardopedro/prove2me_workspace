-- Generated from ChapterSmFockEsa.lean — theorem BookProof.SmFockEsa.sm_dGamma_esa
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterSmOuterFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterScalarDGammaEsa
import Definitions.Def_ChapterShiftedQuadraticEsa
import Definitions.Def_ChapterSmHamiltonian
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian



open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.TensorCore BookProof.SecondQuantizationCore

noncomputable section

theorem BookProof.SmFockEsa.sm_dGamma_esa (P : SmParams) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 163) (polyGaussCore (d := 163))
        (polyGaussCore (d := 163)) n))
      (dGammaCoreOp (L2dSpace 163) (polyGaussCore (d := 163))
        (smHamiltonian P) (polyGaussCore (d := 163))) := by sorry
