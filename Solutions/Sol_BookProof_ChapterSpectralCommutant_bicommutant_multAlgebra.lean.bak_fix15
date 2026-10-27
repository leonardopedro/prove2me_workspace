-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.bicommutant_multAlgebra
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_centralizer_multAlgebra
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure μ] :
    (multAlgebra μ).centralizer.centralizer = multAlgebra μ := by

  rw [centralizer_multAlgebra, centralizer_multAlgebra]
