-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.norm_le_norm_sum_tmul_orthonormal
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Theorems.Thm_BookProof_TensorKatoRellich_norm_sq_sum_tmul_orthonormal
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {E F : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] [NormedAddCommGroup F] [InnerProductSpace ℂ F] {ι : Type*}
    [Fintype ι] {b : ι → F} (hb : Orthonormal ℂ b) (v : ι → E) (j : ι) :
    ‖v j‖ ≤ ‖∑ i, v i ⊗ₜ[ℂ] b i‖ := by

  have h := norm_sq_sum_tmul_orthonormal hb v
  have hj : ‖v j‖ ^ 2 ≤ ∑ i, ‖v i‖ ^ 2 :=
    Finset.single_le_sum (f := fun i => ‖v i‖ ^ 2) (fun i _ => by positivity)
      (Finset.mem_univ j)
  rw [← h] at hj
  exact le_of_sq_le_sq (by simpa using hj) (norm_nonneg _) |>.trans le_rfl
