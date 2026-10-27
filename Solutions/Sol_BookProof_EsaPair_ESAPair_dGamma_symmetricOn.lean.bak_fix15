-- Generated from ChapterEsaPairDGamma.lean — solution of BookProof.EsaPair.ESAPair.dGamma_symmetricOn
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
import Theorems.Thm_BookProof_SecondQuantizationCore_symmetricOn_dGammaCoreOp
open BookProof.EsaPair




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

set_option maxHeartbeats 1000000 in
theorem solution :
    SymmetricOn (dsCore (fun n : ℕ => fockSectorCore Hs P.closureDomain P.coreDomain n))
      P.dGammaOp := symmetricOn_dGammaCoreOp Hs P.closureDomain P.closureOp P.coreDomain P.symmetric
