-- Generated from ChapterEsaPairDGamma.lean — solution of BookProof.EsaPair.ESAPair.dGamma_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Theorems.Thm_BookProof_SecondQuantizationCore_dGamma_essentiallySelfAdjointOn_fockCore
open BookProof.EsaPair




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore Hs P.closureDomain P.coreDomain n)) P.dGammaOp :=
  dGamma_essentiallySelfAdjointOn_fockCore Hs P.closureDomain P.closureOp P.coreDomain
      P.is_core P.sector_esa
