-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.contSymbol_mul
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_toLp_eq_mulRep_oneLp
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
theorem solution {S : Lp ℂ 2 mu →L[ℂ] Lp ℂ 2 mu} (hS : CommutesWithContMult S)
    (g : C(X, ℂ)) :
    ((S (ContinuousMap.toLp 2 mu ℂ g)) : X → ℂ) =ᵐ[mu] fun x => g x * symbol S x := by

  have h := congrArg (fun P : Lp ℂ 2 mu →L[ℂ] Lp ℂ 2 mu => P (oneLp mu)) (hS g)
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at h
  rw [toLp_eq_mulRep_oneLp, h]
  filter_upwards [mulRep_coeFn mu g (S (oneLp mu)), symbol_ae_eq S] with x h1 h2
  rw [h1, h2]
