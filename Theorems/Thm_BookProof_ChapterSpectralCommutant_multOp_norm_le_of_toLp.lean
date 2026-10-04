-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.multOp_norm_le_of_toLp
import Definitions.Def_ChapterLinftyMaximalAbelian
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterA4
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.multOp_norm_le_of_toLp {φ : X → ℂ} (hφ : MemLp φ ⊤ mu) {c : ℝ}
    (h : ∀ g : C(X, ℂ), ‖multOp φ hφ (ContinuousMap.toLp 2 mu ℂ g)‖
      ≤ c * ‖ContinuousMap.toLp 2 mu ℂ g‖) (u : Lp ℂ 2 mu) :
    ‖multOp φ hφ u‖ ≤ c * ‖u‖ := by sorry
