-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.norm_sum_tmul_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
open BookProof.TensorKatoRellich



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorKatoRellich.norm_sum_tmul_le {E F : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [NormedAddCommGroup F] [InnerProductSpace ℂ F] {ι : Type*} [Fintype ι]
    (v : ι → E) (w : ι → F) :
    ‖∑ i, v i ⊗ₜ[ℂ] w i‖ ≤ ∑ i, ‖v i‖ * ‖w i‖ := by sorry
