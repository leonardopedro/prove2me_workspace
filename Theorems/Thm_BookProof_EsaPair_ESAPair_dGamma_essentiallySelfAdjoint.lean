-- Generated from ChapterEsaPairDGamma.lean — theorem BookProof.EsaPair.ESAPair.dGamma_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DirectSumEsa
open BookProof.FockSecondQuantization
open BookProof.TensorCore
open BookProof.EsaPair



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

theorem BookProof.EsaPair.ESAPair.dGamma_essentiallySelfAdjoint :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore Hs P.closureDomain P.coreDomain n)) P.dGammaOp := by sorry
