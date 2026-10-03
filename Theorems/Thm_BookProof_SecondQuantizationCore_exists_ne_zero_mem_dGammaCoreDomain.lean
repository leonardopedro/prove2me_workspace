-- Generated from ChapterSecondQuantizationCoreEsa.lean — theorem BookProof.SecondQuantizationCore.exists_ne_zero_mem_dGammaCoreDomain
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.DirectSumEsa
open BookProof.TensorCore

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.DirectSumEsa

noncomputable section


theorem BookProof.SecondQuantizationCore.exists_ne_zero_mem_dGammaCoreDomain (hD : D ≤ D₂) {a : Hs.carrier} (haD : a ∈ D)
    (ha0 : a ≠ 0) :
    ∃ f ∈ dsCore (fun n : ℕ => fockSectorCore Hs D₂ D n), f ≠ 0 := by sorry
