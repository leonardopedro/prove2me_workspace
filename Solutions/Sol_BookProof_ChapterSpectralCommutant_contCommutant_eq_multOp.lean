-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.contCommutant_eq_multOp
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_denseRange_toLp
import Theorems.Thm_BookProof_ChapterSpectralCommutant_contSymbol_mul
import Theorems.Thm_BookProof_ChapterSpectralCommutant_memLp_top_contSymbol
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
theorem solution {S : Lp ℂ 2 mu →L[ℂ] Lp ℂ 2 mu} (hS : CommutesWithContMult S) :
    S = multOp (symbol S) (memLp_top_contSymbol hS) := by

  set ψ := memLp_top_contSymbol hS with hψ
  have hfun : (fun v : Lp ℂ 2 mu => S v) = fun v => multOp (symbol S) ψ v := by
    refine denseRange_toLp.equalizer S.continuous (multOp (symbol S) ψ).continuous
      (funext fun g => ?_)
    simp only [Function.comp_apply]
    refine Lp.ext ?_
    filter_upwards [contSymbol_mul hS g, multOp_coeFn (symbol S) ψ (ContinuousMap.toLp 2 mu ℂ g),
      ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) g] with x h1 h2 h3
    rw [h1, h2, h3, mul_comm]
  exact ContinuousLinearMap.ext (congrFun hfun)
