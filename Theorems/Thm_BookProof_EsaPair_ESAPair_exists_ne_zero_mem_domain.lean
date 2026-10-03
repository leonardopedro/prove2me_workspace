-- Generated from ChapterEsaPairDGamma.lean — theorem BookProof.EsaPair.ESAPair.exists_ne_zero_mem_domain
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.DirectSumEsa
open BookProof.TensorCore

variable {Hs : IPSpace} (P : ESAPair Hs)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaPair.ESAPair.exists_ne_zero_mem_domain {a : Hs.carrier} (haD : a ∈ P.coreDomain)
    (ha0 : a ≠ 0) :
    ∃ f ∈ dsCore (fun n : ℕ => fockSectorCore Hs P.closureDomain P.coreDomain n), f ≠ 0 := by sorry
