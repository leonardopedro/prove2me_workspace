-- Generated from ChapterEsaPairDGamma.lean — solution of BookProof.EsaPair.ESAPair.norm_sub_smul_sq
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Theorems.Thm_BookProof_EsaPair_ESAPair_symmetricOn_toOp
open BookProof.EsaPair




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

set_option maxHeartbeats 1000000 in
theorem solution (d : ℝ) (x : P.coreDomain) :
    ‖P.toOp x - ((d : ℂ) * Complex.I) • (x : Hs.carrier)‖ ^ 2
      = ‖P.toOp x‖ ^ 2 + d ^ 2 * ‖(x : Hs.carrier)‖ ^ 2 := BookProof.FarisLavine.norm_sub_smul_sq P.toOp P.symmetricOn_toOp d x
