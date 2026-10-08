-- Generated from ChapterEsaPairDGamma.lean — solution of BookProof.EsaPair.ESAPair.symmetricOn_toOp
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
import Theorems.Thm_BookProof_GraphCore_symmetricOn_restrictOp
open BookProof.EsaPair




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn P.coreDomain P.toOp := symmetricOn_restrictOp _ _ P.symmetric
