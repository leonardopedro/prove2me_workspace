-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.norm_sum_tmul_le
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {E F : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [NormedAddCommGroup F] [InnerProductSpace ℂ F] {ι : Type*} [Fintype ι]
    (v : ι → E) (w : ι → F) :
    ‖∑ i, v i ⊗ₜ[ℂ] w i‖ ≤ ∑ i, ‖v i‖ * ‖w i‖ := by

  refine (norm_sum_le _ _).trans (le_of_eq ?_)
  simp [TensorProduct.norm_tmul]
