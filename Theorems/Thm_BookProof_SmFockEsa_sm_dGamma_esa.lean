-- Generated from ChapterSmFockEsa.lean — theorem BookProof.SmFockEsa.sm_dGamma_esa
import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmHamiltonian
import Mathlib

open MvPolynomial
open BookProof.FarisLavine
open BookProof.DirectSumEsa BookProof.HermiteProductCore
open BookProof.SmHamiltonian

noncomputable section

theorem BookProof.SmFockEsa.sm_dGamma_esa (P : SmParams) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 163) (polyGaussCore (d := 163))
        (polyGaussCore (d := 163)) n))
      (dGammaCoreOp (L2dSpace 163) (polyGaussCore (d := 163))
        (smHamiltonian P) (polyGaussCore (d := 163))) := by sorry
