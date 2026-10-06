-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.toLp_eq_mulRep_oneLp
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_oneLp_coeFn
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
omit [T2Space X] [mu.WeaklyRegular] in
theorem solution (g : C(X, ℂ)) :
    ContinuousMap.toLp 2 mu ℂ g = mulRep mu g (oneLp mu) := by

  refine Lp.ext ?_
  filter_upwards [ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) g,
    mulRep_coeFn mu g (oneLp mu), oneLp_coeFn (μ := mu)] with x h1 h2 h3
  rw [h1, h2, h3, mul_one]
