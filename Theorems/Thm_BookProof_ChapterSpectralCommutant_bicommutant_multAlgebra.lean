-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.bicommutant_multAlgebra
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLinftyMaximalAbelian
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterA4
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.bicommutant_multAlgebra [IsFiniteMeasure μ] :
    (multAlgebra μ).centralizer.centralizer = multAlgebra μ := by sorry
