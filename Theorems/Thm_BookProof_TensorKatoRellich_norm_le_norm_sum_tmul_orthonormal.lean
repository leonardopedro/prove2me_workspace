-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.norm_le_norm_sum_tmul_orthonormal
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterA4
open BookProof.TensorKatoRellich



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorKatoRellich.norm_le_norm_sum_tmul_orthonormal {E F : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] [NormedAddCommGroup F] [InnerProductSpace ℂ F] {ι : Type*}
    [Fintype ι] {b : ι → F} (hb : Orthonormal ℂ b) (v : ι → E) (j : ι) :
    ‖v j‖ ≤ ‖∑ i, v i ⊗ₜ[ℂ] b i‖ := by sorry
