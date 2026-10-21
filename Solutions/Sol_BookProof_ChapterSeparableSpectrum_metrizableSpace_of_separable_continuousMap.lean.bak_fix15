-- Generated from ChapterSeparableSpectrum.lean — solution of BookProof.ChapterSeparableSpectrum.metrizableSpace_of_separable_continuousMap
import Mathlib
import Definitions.Def_ChapterSeparableSpectrum
import Theorems.Thm_BookProof_ChapterSeparableSpectrum_eq_of_forall_dense_apply_eq
open BookProof.ChapterSeparableSpectrum



noncomputable section

open MeasureTheory TopologicalSpace WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianDirectSum
open BookProof.ChapterStandardBorelClassification

variable (Y : Type*) [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]

set_option maxHeartbeats 1000000 in
theorem solution [SeparableSpace C(Y, ℂ)] :
    MetrizableSpace Y := by

  obtain ⟨D, hDcount, hDdense⟩ := exists_countable_dense C(Y, ℂ)
  haveI : Countable D := hDcount.to_subtype
  set F : Y → (D → ℂ) := fun y d => (d : C(Y, ℂ)) y with hF
  have hcont : Continuous F := continuous_pi fun d => (d : C(Y, ℂ)).continuous
  have hinj : Function.Injective F := by
    intro y₁ y₂ h
    exact eq_of_forall_dense_apply_eq Y hDdense fun d hd => congrFun h ⟨d, hd⟩
  exact (hcont.isClosedEmbedding hinj).isEmbedding.metrizableSpace
