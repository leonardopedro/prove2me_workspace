-- Generated from ChapterEsaPairDGamma.lean — theorem BookProof.EsaPair.ESAPair.norm_sub_smul_sq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore
open BookProof.EsaPair

variable {Hs : IPSpace} (P : ESAPair Hs)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaPair.ESAPair.norm_sub_smul_sq (d : ℝ) (x : P.coreDomain) :
    ‖P.toOp x - ((d : ℂ) * Complex.I) • (x : Hs.carrier)‖ ^ 2
      = ‖P.toOp x‖ ^ 2 + d ^ 2 * ‖(x : Hs.carrier)‖ ^ 2 := by sorry
