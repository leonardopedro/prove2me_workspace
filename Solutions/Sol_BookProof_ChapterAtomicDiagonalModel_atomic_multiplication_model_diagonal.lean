-- Generated from ChapterAtomicDiagonalModel.lean — solution of BookProof.ChapterAtomicDiagonalModel.atomic_multiplication_model_diagonal
import Mathlib
import Definitions.Def_ChapterAtomicDiagonalModel
import Theorems.Thm_BookProof_ChapterAtomicDiagonalModel_coe_atomBasis
import Theorems.Thm_BookProof_ChapterAtomicDiagonalModel_multOp_atomVec
open BookProof.ChapterAtomicDiagonalModel



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

set_option maxHeartbeats 1000000 in
theorem solution (hpure : mu (atomSet mu)ᶜ = 0) :
    ∃ B : HilbertBasis (atomSet mu) ℂ (Lp ℂ 2 mu),
      ∀ (g : α → ℂ) (hg : MemLp g ⊤ mu) (a : atomSet mu),
        multOp g hg (B a) = g (a : α) • B a := by

  refine ⟨atomBasis mu hpure, fun g hg a => ?_⟩
  rw [coe_atomBasis]
  exact multOp_atomVec mu hg a
