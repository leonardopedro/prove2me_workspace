-- Generated from ChapterEsaPairDGamma.lean — solution of BookProof.EsaPair.ESAPair.exists_ne_zero_mem_domain
import Mathlib
import Definitions.Def_ChapterEsaPairDGamma
import Theorems.Thm_BookProof_SecondQuantizationCore_exists_ne_zero_mem_dGammaCoreDomain
open BookProof.EsaPair




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {Hs : IPSpace} (P : ESAPair Hs)

set_option maxHeartbeats 1000000 in
theorem solution {a : Hs.carrier} (haD : a ∈ P.coreDomain)
    (ha0 : a ≠ 0) :
    ∃ f ∈ dsCore (fun n : ℕ => fockSectorCore Hs P.closureDomain P.coreDomain n), f ≠ 0 := exists_ne_zero_mem_dGammaCoreDomain Hs P.closureDomain P.coreDomain P.sub_domain haD ha0
