-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.centralizer_multAlgebra
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.centralizer_multAlgebra [IsFiniteMeasure μ] :
    (multAlgebra μ).centralizer = multAlgebra μ := by sorry
