-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.gram_quadForm
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {X : Type*} [Fintype X] (C : FormIdx → X → ℂ) (z : X → ℂ) :
    ∑ c : X, ∑ d : X,
        (starRingEnd ℂ) (z c) * ((∑ F : FormIdx, (starRingEnd ℂ) (C F c) * C F d) * z d)
      = ∑ F : FormIdx, (starRingEnd ℂ) (∑ c : X, C F c * z c) * (∑ d : X, C F d * z d) := by

  have hL : ∀ c : X, ∀ d : X,
      (starRingEnd ℂ) (z c) * ((∑ F : FormIdx, (starRingEnd ℂ) (C F c) * C F d) * z d)
        = ∑ F : FormIdx,
            (starRingEnd ℂ) (z c) * ((starRingEnd ℂ) (C F c) * C F d) * z d := by
    intro c d
    rw [Finset.sum_mul, Finset.mul_sum]
    exact Finset.sum_congr rfl fun F _ => by ring
  have hR : ∀ F : FormIdx,
      (starRingEnd ℂ) (∑ c : X, C F c * z c) * (∑ d : X, C F d * z d)
        = ∑ c : X, ∑ d : X, (starRingEnd ℂ) (z c) * ((starRingEnd ℂ) (C F c) * C F d) * z d := by
    intro F
    rw [map_sum, Finset.sum_mul_sum]
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
    rw [map_mul]
    ring
  calc ∑ c : X, ∑ d : X,
        (starRingEnd ℂ) (z c) * ((∑ F : FormIdx, (starRingEnd ℂ) (C F c) * C F d) * z d)
      = ∑ c : X, ∑ d : X, ∑ F : FormIdx,
          (starRingEnd ℂ) (z c) * ((starRingEnd ℂ) (C F c) * C F d) * z d :=
        Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => hL c d
    _ = ∑ c : X, ∑ F : FormIdx, ∑ d : X,
          (starRingEnd ℂ) (z c) * ((starRingEnd ℂ) (C F c) * C F d) * z d :=
        Finset.sum_congr rfl fun c _ => Finset.sum_comm
    _ = ∑ F : FormIdx, ∑ c : X, ∑ d : X,
          (starRingEnd ℂ) (z c) * ((starRingEnd ℂ) (C F c) * C F d) * z d :=
        Finset.sum_comm
    _ = ∑ F : FormIdx, (starRingEnd ℂ) (∑ c : X, C F c * z c) * (∑ d : X, C F d * z d) :=
        Finset.sum_congr rfl fun F _ => (hR F).symm
