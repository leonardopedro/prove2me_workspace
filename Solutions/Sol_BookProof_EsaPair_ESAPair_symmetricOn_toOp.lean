-- Generated from ChapterEsaPairDGamma.lean — solution of BookProof.EsaPair.ESAPair.symmetricOn_toOp
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
import Theorems.Thm_BookProof_GraphCore_symmetricOn_restrictOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterTensorGraphCore
open BookProof.EsaPair




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn P.coreDomain P.toOp := symmetricOn_restrictOp _ _ P.symmetric
