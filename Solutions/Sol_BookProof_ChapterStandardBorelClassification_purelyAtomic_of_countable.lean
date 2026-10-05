-- Generated from ChapterStandardBorelClassification.lean — solution of BookProof.ChapterStandardBorelClassification.purelyAtomic_of_countable
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
open BookProof.ChapterStandardBorelClassification



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)

set_option maxHeartbeats 1000000 in
theorem solution {X : Type*} [MeasurableSpace X]
    [MeasurableSingletonClass X] [Countable X] (mu : Measure X) :
    mu (atomSet mu)ᶜ = 0 := by

  have hcount : ((atomSet mu)ᶜ).Countable := Set.to_countable _
  have hsub : (atomSet mu)ᶜ ⊆ ⋃ x ∈ (atomSet mu)ᶜ, ({x} : Set X) := by
    intro x hx
    exact Set.mem_biUnion hx rfl
  refine measure_mono_null hsub ?_
  rw [measure_biUnion_null_iff hcount]
  intro x hx
  simpa [atomSet] using hx
