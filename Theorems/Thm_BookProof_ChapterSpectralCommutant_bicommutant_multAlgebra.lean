-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.bicommutant_multAlgebra
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
open BookProof.ChapterSpectralCommutant


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

theorem BookProof.ChapterSpectralCommutant.bicommutant_multAlgebra [IsFiniteMeasure μ] :
    (multAlgebra μ).centralizer.centralizer = multAlgebra μ := by sorry
