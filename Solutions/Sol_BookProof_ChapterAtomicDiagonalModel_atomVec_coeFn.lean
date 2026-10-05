-- Generated from ChapterAtomicDiagonalModel.lean — solution of BookProof.ChapterAtomicDiagonalModel.atomVec_coeFn
import Mathlib
import Definitions.Def_ChapterAtomicDiagonalModel
open BookProof.ChapterAtomicDiagonalModel



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

set_option maxHeartbeats 1000000 in
theorem solution (a : atomSet mu) :
    (atomVec mu a : α → ℂ) =ᵐ[mu] fun x =>
      (((Real.sqrt (mu.real {(a : α)}))⁻¹ : ℝ) : ℂ) *
        Set.indicator {(a : α)} (fun _ => (1 : ℂ)) x := by

  have hs := Lp.coeFn_smul ((((Real.sqrt (mu.real {(a : α)}))⁻¹ : ℝ) : ℂ))
    (atomIndicator mu (a : α))
  filter_upwards [hs, atomIndicator_coeFn mu (a : α)] with x hx hy
  rw [atomVec, hx]
  simp only [Pi.smul_apply, smul_eq_mul]
  rw [hy]
