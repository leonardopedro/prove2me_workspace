-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.centralizer_multAlgebra
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_multOp_mem_multAlgebra
import Theorems.Thm_BookProof_ChapterSpectralCommutant_multAlgebra_comm
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure μ] :
    (multAlgebra μ).centralizer = multAlgebra μ := by

  apply Set.eq_of_subset_of_subset
  · intro S hS
    have hcomm : CommutesWithMultOps S := by
      intro φ hφ
      have h := hS (multOp φ hφ) (multOp_mem_multAlgebra φ hφ)
      simpa [ContinuousLinearMap.mul_def] using h.symm
    exact ⟨symbol S, memLp_top_symbol hcomm, commutant_eq_multOp hcomm⟩
  · intro S hS R hR
    exact multAlgebra_comm hR hS
